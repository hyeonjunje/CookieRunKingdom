using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PathFindingAgent))]
public class CookieCitizen : MonoBehaviour
{
    private CookieController _controller;
    private PathFindingAgent _agent;
    private KingdomManager _kingdomManager;


    private Coroutine _coUpdate;
    private Transform _originParent = null;
    private bool _isWorking = false;
    [SerializeField] private string _greetingAnimation = "call_user";

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
        if (_isWorking)
            return;

        // 걷다가, 멈추다가, 인사하다가
        _coUpdate = StartCoroutine(CoUpdate());
    }


    public void WalkInKingdom()
    {


    }

    public void WalkInAdventure()
    {

    }

    // 출근
    public void GoToWork(Transform parent)
    {
        _isWorking = true;
        
        // 하고 있던 AI동작 중지
        _agent.StopPathFinding();
        if (_coUpdate != null)
            StopCoroutine(_coUpdate);

        // 출석부 등록하고
        _kingdomManager.workingCookies.Add(_controller);

        // 위치 조정하고
        _originParent = transform.parent;
        transform.SetParent(parent);
        transform.localPosition = Vector3.zero;
        _controller.CharacterAnimator.FlipX(false);
        _controller.CharacterAnimator.SettingOrder(-Mathf.RoundToInt(transform.position.y) + 100);

        // 인사하고
        _controller.CharacterAnimator.PlayAnimation(_greetingAnimation);
    }

    public void EndWork()
    {
        // 인사
        _controller.CharacterAnimator.PlayAnimation(_greetingAnimation);
    }

    // 퇴근
    public void LeaveWork()
    {
        _isWorking = false;

        // 출석부에 빼고
        _kingdomManager.workingCookies.Remove(_controller);

        // 위치 조정하고
        transform.SetParent(_originParent);
        transform.position = GridManager.Instance.ReturnEmptyTilePosition();
        
        // 다시 일상생활로
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
