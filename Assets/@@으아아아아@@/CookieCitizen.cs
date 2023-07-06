using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PathFindingAgent))]
public class CookieCitizen : MonoBehaviour
{
    private CookieController _controller;
    private PathFindingAgent _agent;

    private Coroutine _coUpdate;

    private void OnDisable()
    {
        if(_coUpdate != null)
            StopCoroutine(_coUpdate);
    }

    public void Init(CookieController controller)
    {
        _controller = controller;
        _agent = GetComponent<PathFindingAgent>();

        _agent.Init(_controller);
    }

    public void KingdomAI()
    {
        // 걷다가, 멈추다가, 인사하다가
        StartCoroutine(CoUpdate());
    }


    public void WalkInKingdom()
    {
        _agent.MoveTo(new Vector3(3, -10, 0));
    }

    public void WalkInAdventure()
    {

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
