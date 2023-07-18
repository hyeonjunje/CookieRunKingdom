using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PathFindingAgent))]
public class CookieCitizen : MonoBehaviour
{
    [SerializeField] private string _greetingAnimation = "call_user";
    
    private CookieController _controller;
    private PathFindingAgent _agent;
    private KingdomManager _kingdomManager;

    private bool _isReadyToAI; // �ൿ�� �غ� �ƴٴ� ���� �̰� true�� Ȱ��ȭ�� �� ai ����
    private Transform _originParent = null;
    private Coroutine _coUpdate = null;
    private Coroutine _coHello = null;
    
    public bool IsWorking { get; private set; }

    private void OnEnable()
    {
        if(_isReadyToAI)
        {
            _isReadyToAI = false;
            StartKingdomAI();
        }
    }

    private void OnDisable()
    {
        StopKingdomAI();
    }

    public void Init(CookieController controller)
    {
        _controller = controller;
        _agent = GetComponent<PathFindingAgent>();
        _kingdomManager = FindObjectOfType<KingdomManager>();

        if (GameManager.Scene.CurrentScene == ESceneName.Battle)
            return;

        _agent.Init(_controller);
    }

    public void Hello()
    {
        if (_coHello != null)
            StopCoroutine(_coHello);
        _coHello = StartCoroutine(CoHello());
    }

    public void StopKingdomAI()
    {
        _agent.StopPathFinding();
        if (_coUpdate != null)
            StopCoroutine(_coUpdate);
    }

    public void StartKingdomAI()
    {
        if (IsWorking)
            return;

        if (GameManager.Scene.CurrentScene == ESceneName.Battle)
            return;

        // �ȴٰ�, ���ߴٰ�, �λ��ϴٰ�
        StopKingdomAI();
        _coUpdate = StartCoroutine(CoUpdate());
    }



    // ���
    public void GoToWork(Transform parent)
    {
        IsWorking = true;
        
        // �ϰ� �ִ� AI���� ����
        _agent.StopPathFinding();
        if (_coUpdate != null)
            StopCoroutine(_coUpdate);

        // �⼮�� ����ϰ�
        _kingdomManager.workingCookies.Add(_controller);

        // ��ġ �����ϰ�
        _originParent = transform.parent;
        transform.SetParent(parent);
        transform.localPosition = Vector3.zero;
        _controller.CharacterAnimator.FlipX(false);
        _controller.CharacterAnimator.SettingOrder();

        // �λ��ϰ�
        _controller.CharacterAnimator.PlayAnimation(_greetingAnimation);
        _controller.CharacterAnimator.SettingOrderLayer(true);
    }

    public void EndWork()
    {
        // �λ�
        _controller.CharacterAnimator.PlayAnimation(_greetingAnimation);
    }

    // ���
    public void LeaveWork()
    {
        IsWorking = false;

        // �⼮�ο� ����
        _kingdomManager.workingCookies.Remove(_controller);

        // ��ġ �����ϰ�
        transform.SetParent(_originParent);
        transform.position = GridManager.Instance.ReturnEmptyTilePosition();

        _controller.CharacterAnimator.SettingOrderLayer(false);

        if (!gameObject.activeSelf)
        {
            _isReadyToAI = true;
            return;
        }

        // �ٽ� �ϻ��Ȱ��
        StartKingdomAI();
    }


    private IEnumerator CoUpdate()
    {
        while(true)
        {
            // int act = Random.Range(0, 3);
            int act = 0;
            switch (act)
            {
                case 0:
                    MoveRandomPosition();
                    break;
                case 1:
                    break;
                case 2:
                    break;
            }

            yield return new WaitForSeconds(Random.Range(5, 10));
        }
    }

    private IEnumerator CoHello()
    {
        StopKingdomAI();
        _controller.CharacterAnimator.PlayAnimation("idle_back", false);
        _controller.CharacterAnimator.PlayAnimation("call_user", false);

        yield return new WaitUntil(() => !_controller.CharacterAnimator.IsPlayingAnimation());

        StartKingdomAI();
    }

    private void MoveRandomPosition()
    {
        while (true)
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


    public void TeleportValidPosition(Vector3 originPos)
    {
        // �÷��̾ �巡�� �ϱ� �� �׸��� ��ġ
        Vector3Int playerOriginGridPos = GridManager.Instance.Grid.WorldToCell(originPos);

        // ���� �÷��̾��� �׸��� ��ġ
        Vector3Int playerGridPos = GridManager.Instance.Grid.WorldToCell(transform.position);
        

        if (!GridManager.Instance.ValidTileCheck(playerGridPos.x, playerGridPos.y))
        {
            // GuideDisplayer.Instance.ShowGuide("��Ű�� �������� �� ���� ���Դϴ�.");

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

                for(int i = 0; i < tiles.Count; i++)
                {
                    float distanceTile = Mathf.Sqrt(Mathf.Pow(transform.position.x - tiles[i].position.x, 2) + Mathf.Pow(transform.position.y - tiles[i].position.y, 2));
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
}
