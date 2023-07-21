using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ECookieCitizenState
{
    idle, working, greeting
}

[RequireComponent(typeof(PathFindingAgent))]
public class CookieCitizen : BehaviorTree
{
    public class BlackBoardKey : BlackboardKeyBase
    {
        public static readonly BlackBoardKey GreetingCookies = new BlackBoardKey() { Name = "GreetingCookies" };
        public static readonly BlackBoardKey GreetingTargetCookie = new BlackBoardKey() { Name = "GreetingTargetCookie" };
        public string Name;
    }

    private Blackboard<BlackBoardKey> _localMemory;


    [SerializeField] private string _callUserAnimation = "call_user";
    [SerializeField] private string _touchAnimation = "touch";
    [SerializeField] private string _personalAnimation = "personal1";

    [SerializeField] private string _greetingAnimation = "greeting";
    [SerializeField] private string _greetingBackAnimation = "greeting_back";

    [SerializeField] private string _talkAnimation = "talk";
    [SerializeField] private string _talkBackAnimation = "talk_back";

    private CookieController _controller;
    private PathFindingAgent _agent;
    private KingdomManager _kingdomManager;

    private Coroutine _coBT = null;
    private Coroutine _coHello = null;
    private Transform _originParent = null;
    private bool _isKingdomScene = false;
    private bool _isReadyToBT; // �ൿ�� �غ� �ƴٴ� ���� �̰� true�� Ȱ��ȭ�� �� BT����


    public ECookieCitizenState CookieState { get; private set; }


    public void Init(CookieController controller)
    {
        _isKingdomScene = GameManager.Scene.CurrentScene == ESceneName.Kingdom;

        if (!_isKingdomScene)
            return;

        _controller = controller;
        _agent = GetComponent<PathFindingAgent>();
        _kingdomManager = FindObjectOfType<KingdomManager>();
        _agent.Init(_controller);

        // BT ����
        SetBT();
    }

    private void OnEnable()
    {
        if (!_isKingdomScene)
            return;

        if (_isReadyToBT)
        {
            _isReadyToBT = false;
            StartKingdomAI();
        }
    }

    private void OnDisable()
    {
        if (!_isKingdomScene)
            return;

        StopKingdomAI();
    }

    // AI����
    public void StartKingdomAI()
    {
        // ŷ���������� AI�ൿ
        if (!_isKingdomScene)
            return;

        // ���ϰ� �ִ� ��Ű��� AI����
        if (CookieState == ECookieCitizenState.working)
            return;

        CookieState = ECookieCitizenState.idle;

        StopKingdomAI();
        _coBT = StartCoroutine(CoBT());
    }

    // AI����
    public void StopKingdomAI()
    {
        _agent.StopPathFinding();

        if (_coBT != null)
            StopCoroutine(_coBT);
    }

    // �ϴ� BT�� ���߰� �λ���
    public void Hello()
    {
        if (_coHello != null)
            StopCoroutine(_coHello);
        // �ϴ� AI�ൿ �׸�!
        StopKingdomAI();
        _coHello = StartCoroutine(COHello());
    }

    // ����ϱ�
    public void GoToWork(Transform parent)
    {
        CookieState = ECookieCitizenState.working;

        // �ϰ� �ִ� AI���� ����
        _agent.StopPathFinding();
        if (_coBT != null)
            StopCoroutine(_coBT);

        // �⼮�� ����ϱ�
        _kingdomManager.workingCookies.Add(_controller);

        // ��ġ �����ϱ�
        _originParent = transform.parent;
        transform.SetParent(parent);
        transform.localPosition = Vector3.zero;
        _controller.CharacterAnimator.FlipX(false);
        _controller.CharacterAnimator.SettingOrder();

        // �λ��ϱ�
        _controller.CharacterAnimator.PlayAnimation(_callUserAnimation);
        _controller.CharacterAnimator.SettingOrderLayer(true);
    }

    // ���� ���ߴٸ� �λ���
    public void EndWork()
    {
        _controller.CharacterAnimator.PlayAnimation(_callUserAnimation);
    }

    // ����ϱ�
    public void LeaveWork()
    {
        CookieState = ECookieCitizenState.idle;

        // �⼮�ο��� ����
        _kingdomManager.workingCookies.Remove(_controller);

        // ��ġ �����ϱ�
        transform.SetParent(_originParent);
        transform.position = GridManager.Instance.ReturnEmptyTilePosition();
        _controller.CharacterAnimator.SettingOrderLayer(false);

        if (!gameObject.activeSelf)
        {
            _isReadyToBT = true;
            return;
        }

        StartKingdomAI();
    }

    // ���� ���������� �� ��ȿ���� ���� ��ġ��� ���� ����� ��ȿ�� ��ġ�� �����̵���Ŵ
    public void TeleportValidPosition(Vector3 originPos)
    {
        // ���� �÷��̾��� �׸��� ��ġ
        Vector3Int playerGridPos = GridManager.Instance.Grid.WorldToCell(transform.position);

        if (!GridManager.Instance.ValidTileCheck(playerGridPos.x, playerGridPos.y))
        {
            GuideDisplayer.Instance.ShowGuide("��Ű�� �������� �� ���� ���Դϴ�.");

            // �׸����� ���� ���̶�� ���� ��ġ�� �̵�
            if (playerGridPos.y >= 100 || playerGridPos.y <= -100 || playerGridPos.x >= 100 || playerGridPos.x <= -100)
            {
                transform.position = originPos;
            }
            // �ƴϸ� ����� ���� ����� ��ȿ�� ��ġ�� �̵�
            else
            {
                Collider2D[] tilesCol = Physics2D.OverlapCircleAll(transform.position, 10f);
                List<Transform> tiles = new List<Transform>();

                for (int i = 0; i < tilesCol.Length; i++)
                {
                    if (tilesCol[i].gameObject.layer != LayerMask.NameToLayer("Ground"))
                        continue;
                    Vector3Int tilesGridPos = GridManager.Instance.Grid.WorldToCell(tilesCol[i].transform.position);
                    if (!GridManager.Instance.ValidTileCheck(tilesGridPos.x, tilesGridPos.y))
                        continue;

                    tiles.Add(tilesCol[i].transform);
                }

                if (tiles.Count == 0)
                {
                    transform.position = originPos;
                    return;
                }

                float distance = int.MaxValue;
                Vector3 minTile = Vector3.zero;

                for (int i = 0; i < tiles.Count; i++)
                {
                    float distanceTile = Mathf.Pow(transform.position.x - tiles[i].position.x, 2) + Mathf.Pow(transform.position.y - tiles[i].position.y, 2);
                    if (distance > distanceTile)
                    {
                        distance = distanceTile;
                        minTile = tiles[i].transform.position;
                    }
                }
                transform.position = minTile;
            }
        }
    }

    private void SetBT()
    {
        _localMemory = BlackboardManager.Instance.GetIndividualBlackboard<BlackBoardKey>(this);
        _localMemory.SetGeneric<string>(BlackBoardKey.GreetingCookies, "");
        _localMemory.SetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie, null);

        BTNodeBase BTRoot = RootNode.Add<BTNodeSelector>("BT START");
        BTRoot.AddService<BTServiceBase>("��ó�� ��Ű�� �ֳ���?", (float deltaTime) =>
        {
            _localMemory.SetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie, null);
            Collider2D[] cookieCollider = Physics2D.OverlapCircleAll(transform.position, 1.5f, 1 << LayerMask.NameToLayer("Cookie"));

            if (cookieCollider.Length == 0)
                return;

            List<CookieController> cookieList = new List<CookieController>();

            for(int i = 0; i < cookieCollider.Length; i++)
            {
                if(cookieCollider[i].transform != transform)
                {
                    CookieController cookie = cookieCollider[i].GetComponent<CookieController>();
                    if (cookie != null)
                        cookieList.Add(cookie);
                }
            }

            if (cookieList.Count == 0)
                return;

            _localMemory.SetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie, cookieList[0]);

            if(gameObject.name == "Cookie0001(Clone)")
            {
                Debug.Log(_localMemory.GetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie) + " �� ��ó�� �ֽ��ϴ�.");
            }

        });


        BTNodeBase walkRoot = BTRoot.Add<BTNodeSequence>("������ �õ�");

        walkRoot.AddDecorator<BTDecoratorBase>("������ �õ� üũ", () =>
        {
            CookieController otherCookie = _localMemory.GetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie);
            if (otherCookie == null)
                return true;
            if (CheckGreeting(otherCookie))
                return true;
            return false;
        });

        BTNodeBase cookieWalk = walkRoot.Add<BTNodeAction>("����!",
            () =>
            {
                if (Random.Range(0, 2) == 0)
                    return ENodeStatus.Failed;

                if (MoveRandomPosition())
                    return ENodeStatus.Succeeded;
                else
                    return ENodeStatus.Failed;
            },
            () =>
            {
                if (_agent.IsDestination)
                    return ENodeStatus.Succeeded;
                else
                {
                    if (_localMemory.GetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie) != null)
                        return ENodeStatus.Failed;
                    return ENodeStatus.InProgress;
                }
            });

        BTNodeBase cookiePersonal = walkRoot.Add<BTNodeAction>("�����ൿ ���", () =>
        {
                _controller.CharacterAnimator.PlayAnimation(_personalAnimation, false);
                return ENodeStatus.Succeeded;
        },
        () =>
        {
            if (!_controller.CharacterAnimator.IsPlayingAnimation())
                return ENodeStatus.Succeeded;
            else
            {
                if (_localMemory.GetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie) != null)
                    return ENodeStatus.Failed;
                return ENodeStatus.InProgress;
            }
        });


        BTNodeBase greetingRoot = BTRoot.Add<BTNodeSequence>("�λ� �õ�");

        greetingRoot.AddDecorator<BTDecoratorBase>("�λ� �õ� üũ", () =>
        {
            CookieController otherCookie = _localMemory.GetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie);
            if (otherCookie != null && otherCookie.CookieCitizeon.CookieState == ECookieCitizenState.idle && !CheckGreeting(otherCookie))
            {
                return true;
            }
            return false;
        });

        BTNodeBase cookieGreet = greetingRoot.Add<BTNodeAction>("�λ��Ѵ�.",
            () =>
            {
                // BT�� ���߰� ���� �λ��ϴ� �ð��� ������.
                CookieController otherCookie = _localMemory.GetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie);
                StartCoroutine(CoGreeting(otherCookie));
                return ENodeStatus.Succeeded;
            },
            () =>
            {
                return ENodeStatus.Succeeded;
            });
        // BTNodeBase cookieCommunication = greetingRoot.Add<BTNodeAction>("����Ѵ�.",)


        BTNodeBase cookieIdle = BTRoot.Add<BTNodeAction>("������ �ִ´�.", () =>
            {
                _agent.StopPathFinding();
                _controller.CharacterAnimator.PlayAnimation("idle", false);
                return ENodeStatus.Succeeded;
            },
            () =>
            {
                CookieController otherCookie = _localMemory.GetGeneric<CookieController>(BlackBoardKey.GreetingTargetCookie);
                if (otherCookie != null && !CheckGreeting(otherCookie))
                    return ENodeStatus.Succeeded;

                if (!_controller.CharacterAnimator.IsPlayingAnimation())
                    return ENodeStatus.Succeeded;
                return ENodeStatus.InProgress;
            });
            
    }


    private bool MoveRandomPosition()
    {
        Vector3 targetPosition = Random.insideUnitCircle * 5;
        Vector3Int cellTargetPosition = GridManager.Instance.Grid.WorldToCell(transform.position + targetPosition);
        if (GridManager.Instance.ValidTileCheck(cellTargetPosition.x, cellTargetPosition.y))
        {
            _agent.MoveTo(GridManager.Instance.Grid.CellToWorld(cellTargetPosition));
            return true;
        }
        else
        {
            return false;
        }
    }

    public IEnumerator CoGreeting(CookieController otherCookie)
    {
        otherCookie.CookieCitizeon.CookieState = ECookieCitizenState.greeting;
        CookieState = ECookieCitizenState.greeting;

        Greeting(otherCookie);
        otherCookie.CookieCitizeon.Greeting(_controller);

        yield return new WaitUntil(() => !_controller.CharacterAnimator.IsPlayingAnimation());

        StartKingdomAI();
        otherCookie.CookieCitizeon.StartKingdomAI();
    }

    // �λ� ��ȣ�ۿ�
    public void Greeting(CookieController otherCookie)
    {
        StopKingdomAI();
        _controller.CharacterAnimator.PlayAnimation("idle_back", false);

        // �λ縦 �ϸ� �λ縦 �ߴ� ��Ű ��Ͽ� �־��ش�.
        string greetedCookies = _localMemory.GetGeneric<string>(BlackBoardKey.GreetingCookies);
        int cookieIndex = ((CookieData)otherCookie.Data).CookieIndex;
        greetedCookies += cookieIndex.ToString();
        _localMemory.SetGeneric<string>(BlackBoardKey.GreetingCookies, greetedCookies);

        // ���� ���� ������ 
        if (otherCookie.transform.position.y < transform.position.y)
            _controller.CharacterAnimator.PlayAnimation(_greetingAnimation, false);
        else
            _controller.CharacterAnimator.PlayAnimation(_greetingBackAnimation, false);

        // ���� �����ʿ� ������
        if (otherCookie.transform.position.x < transform.position.x)
            _controller.CharacterAnimator.FlipX(true);
        else
            _controller.CharacterAnimator.FlipX(false);
    }

    // otherCookie�� �λ縦 �ߴ��� üũ
    private bool CheckGreeting(CookieController otherCookie)
    {
        string greetedCookies = _localMemory.GetGeneric<string>(BlackBoardKey.GreetingCookies);
        int cookieIndex = ((CookieData)otherCookie.Data).CookieIndex;

        if (greetedCookies.Contains(cookieIndex.ToString()))
            return true;
        return false;
    }

    private IEnumerator CoBT()
    {
        ResetRootNode();
        Tick();
        while (true)
        {
            Tick(0.2f);
            yield return new WaitForSeconds(0.2f);
        }
    }

    private IEnumerator COHello()
    {
        _controller.CharacterAnimator.PlayAnimation("idle_back", false);
        _controller.CharacterAnimator.PlayAnimation(_touchAnimation, false);

        yield return new WaitUntil(() => !_controller.CharacterAnimator.IsPlayingAnimation());
        StartKingdomAI();
    }
}
