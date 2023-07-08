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
    private Coroutine _coUpdate;
    private Transform _originParent = null;
    
    public bool IsWorking { get; private set; }

    private void OnEnable()
    {
        if(_isReadyToAI)
        {
            _isReadyToAI = false;
            KingdomAI();
        }
    }

    private void OnDisable()
    {
        if(_coUpdate != null)
            StopCoroutine(_coUpdate);
    }

    public void Init(CookieController controller)
    {
        _controller = controller;
        _agent = GetComponent<PathFindingAgent>();
        _kingdomManager = FindObjectOfType<KingdomManager>();

        _agent.Init(_controller);
    }

    public void KingdomAI()
    {
        if (IsWorking)
            return;

        // �ȴٰ�, ���ߴٰ�, �λ��ϴٰ�
        _coUpdate = StartCoroutine(CoUpdate());
    }


    public void WalkInKingdom()
    {


    }

    public void WalkInAdventure()
    {

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
        _controller.CharacterAnimator.SettingOrder(-Mathf.RoundToInt(transform.position.y) + 100);

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
        KingdomAI();
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

    private void MoveRandomPosition()
    {
        while (true)
        {
            Vector3 targetPosition = Random.insideUnitCircle * 5;
            Vector3Int cellTargetPosition = GridManager.Instance.Grid.WorldToCell(transform.position + targetPosition);
            if(GridManager.Instance.InvalidTileCheck(cellTargetPosition.x, cellTargetPosition.y))
            {
                _agent.MoveTo(GridManager.Instance.Grid.CellToWorld(cellTargetPosition));
                break;
            }
        }
    }
}
