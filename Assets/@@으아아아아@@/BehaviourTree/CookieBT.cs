using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PathFindingAgent))]
public class CookieBT : BehaviorTree
{
    [SerializeField] private string _greetingAnimation = "call_user";

    private CookieController _controller;
    private PathFindingAgent _agent;
    private KingdomManager _kingdomManager;

    private Coroutine _coBT = null;
    private Coroutine _coHello = null;
    private Transform _originParent = null;
    private bool _isKingdomScene = false;
    private bool _isReadyToBT; // �ൿ�� �غ� �ƴٴ� ���� �̰� true�� Ȱ��ȭ�� �� BT����

    public bool IsWorking { get; private set; }

    private void Init(CookieController controller)
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
        if (_isReadyToBT)
        {
            _isReadyToBT = false;
            StartKingdomAI();
        }
    }

    private void OnDisable()
    {
        StopKingdomAI();
    }

    // AI����
    public void StartKingdomAI()
    {
        // ŷ���������� AI�ൿ
        if (!_isKingdomScene)
            return;

        // ���ϰ� �ִ� ��Ű��� AI����
        if (IsWorking)
            return;

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
        IsWorking = true;

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
        _controller.CharacterAnimator.PlayAnimation(_greetingAnimation);
        _controller.CharacterAnimator.SettingOrderLayer(true);
    }

    // ���� ���ߴٸ� �λ���
    public void EndWork()
    {
        _controller.CharacterAnimator.PlayAnimation(_greetingAnimation);
    }

    // ����ϱ�
    public void LeaveWork()
    {
        IsWorking = false;

        // �⼮�ο��� ����
        _kingdomManager.workingCookies.Remove(_controller);

        // ��ġ �����ϱ�
        transform.SetParent(_originParent);
        transform.position = GridManager.Instance.ReturnEmptyTilePosition();
        _controller.CharacterAnimator.SettingOrderLayer(false);

        if(!gameObject.activeSelf)
        {
            _isReadyToBT = true;
            return;
        }

        StartKingdomAI();
    }

    // ���� ���������� �� ��ȿ���� ���� ��ġ��� ���� ����� ��ȿ�� ��ġ�� �����̵���Ŵ
    public void TeleportValildPosition(Vector3 originPos)
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
                    // float distanceTile = Mathf.Sqrt(Mathf.Pow(transform.position.x - tiles[i].position.x, 2) + Mathf.Pow(transform.position.y - tiles[i].position.y, 2));
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
        ResetRootNode();

        BTNodeBase walkRoot = RootNode.Add<BTNodeAction>("���ƴٴϱ�",
            () =>
            {
                // OnEnter
                // ��θ� ���ϰ� �̵��ϱ� �����Ѵ�.
                Debug.Log("��������");
                return ENodeStatus.InProgress;
            },
            () =>
            {
                // OnTick
                // ���������� �ٿԴٸ� �̰� ����
                Debug.Log("�ٿԴ��� �˻�!");
                return ENodeStatus.Succeeded;
            });
    }

    private void MoveRandomPosition()
    {
        // ��ȿ�� ��ġ�� ã�� ������ �ݺ�
        while(true)
        {
            Vector3 targetPosition = Random.insideUnitCircle * 5;
            Vector3Int cellTargetPosition = GridManager.Instance.Grid.WorldToCell(transform.position + targetPosition);
            if(GridManager.Instance.ValidTileCheck(cellTargetPosition.x, cellTargetPosition.y))
            {
                _agent.MoveTo(GridManager.Instance.Grid.CellToWorld(cellTargetPosition));
                break;
            }
        }
    }

    private IEnumerator CoBT()
    {
        while(true)
        {
            yield return null;
            Tick();
        }
    }

    private IEnumerator COHello()
    {
        _controller.CharacterAnimator.PlayAnimation("idle_back", false);
        _controller.CharacterAnimator.PlayAnimation(_greetingAnimation, false);

        yield return new WaitUntil(() => !_controller.CharacterAnimator.IsPlayingAnimation());
        StartKingdomAI();
    }
}
