using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Node
{
    public Node(bool _isWall, int _x, int _y) { isWall = _isWall; x = _x; y = _y; }

    public bool isWall;
    public Node ParentNode;

    // G : �������κ��� �̵��ߴ� �Ÿ�, H : |����|+|����| ��ֹ� �����Ͽ� ��ǥ������ �Ÿ�, F : G + H
    public int x, y, G, H;
    public int F { get { return G + H; } }
}


public class PathFindingAgent : MonoBehaviour
{
    private CookieController _controller;

    [Header("Test")]
    [SerializeField] private List<Node> FinalNodeList;

    [Header("�̵� ����")]
    [SerializeField] private float _moveSpeed = 1f;

    private Vector2Int _start, _end;
    private Node[,] _nodeArray;
    private Node _startNode, _targetNode, _curNode;
    private List<Node> _openList, _closedList;

    private Coroutine _coMove = null;

    private Grid _grid => GridManager.Instance.Grid;                      
    private Tilemap[,] _map => GridManager.Instance.buildingGridData.gridData;

    public void Init(CookieController controller)
    {
        _controller = controller;

        // �� �б�
        Vector3Int start1 = _grid.WorldToCell(Utils.MapStartPoint);
        Vector3Int end1 = _grid.WorldToCell(Utils.MapEndPoint);

        int minX = start1.x > end1.x ? end1.x : start1.x;
        int maxX = start1.x > end1.x ? start1.x : end1.x;
        int minY = start1.y > end1.y ? end1.y : start1.y;
        int maxY = start1.y > end1.y ? start1.y : end1.y;

        _start = new Vector2Int(minX, minY);
        _end = new Vector2Int(maxX, maxY);
    }

    public void MoveTo(Vector3 target)
    {
        // ��� ã��
        PathFinding(target);

        // _finalNodeList ��� �̵��Ѵ�.
        if (_coMove != null)
            StopCoroutine(_coMove);
        _coMove = StartCoroutine(CoMove());
    }

    public void StopPathFinding()
    {
        if (_coMove != null)
            StopCoroutine(_coMove);
    }

    private void PathFinding(Vector3 target)
    {
        // NodeArray�� ũ�� �����ְ�, isWall, x, y ����
        int sizeX = _end.x - _start.x + 1;
        int sizeY = _end.y - _start.y + 1;
        _nodeArray = new Node[sizeY, sizeX];

        for (int y = _end.y; y >= _start.y; y--)
        {
            for (int x = _end.x; x >= _start.x; x--)
            {
                bool isWall = _map[y - _start.y, x - _start.x] == null || !_map[y - _start.y, x - _start.x].isEmpty;
                _nodeArray[y - _start.y, x - _start.x] = new Node(isWall, x, y);
            }
        }

        Vector3Int startPoint = _grid.WorldToCell(transform.position);
        Vector3Int endPoint = _grid.WorldToCell(target);

        // ���۰� �� ���, ��������Ʈ�� ��������Ʈ, ����������Ʈ �ʱ�ȭ
        _startNode = _nodeArray[startPoint.y - _start.y, startPoint.x - _start.x];
        _targetNode = _nodeArray[endPoint.y - _start.y, endPoint.x - _start.x];

        _openList = new List<Node>() { _startNode };
        _closedList = new List<Node>();
        FinalNodeList = new List<Node>();


        while (_openList.Count > 0)
        {
            // ��������Ʈ �� ���� F�� �۰� F�� ���ٸ� H�� ���� �� ������� �ϰ� ��������Ʈ���� ��������Ʈ�� �ű��
            _curNode = _openList[0];
            for (int i = 1; i < _openList.Count; i++)
                if (_openList[i].F <= _curNode.F && _openList[i].H < _curNode.H) _curNode = _openList[i];

            _openList.Remove(_curNode);
            _closedList.Add(_curNode);


            // ������
            if (_curNode == _targetNode)
            {
                Node TargetCurNode = _targetNode;
                while (TargetCurNode != _startNode)
                {
                    FinalNodeList.Add(TargetCurNode);
                    TargetCurNode = TargetCurNode.ParentNode;
                }
                FinalNodeList.Add(_startNode);
                FinalNodeList.Reverse();

                return;
            }


            OpenListAdd(_curNode.x + 1, _curNode.y + 1);
            OpenListAdd(_curNode.x - 1, _curNode.y + 1);
            OpenListAdd(_curNode.x - 1, _curNode.y - 1);
            OpenListAdd(_curNode.x + 1, _curNode.y - 1);

            OpenListAdd(_curNode.x, _curNode.y + 1);
            OpenListAdd(_curNode.x + 1, _curNode.y);
            OpenListAdd(_curNode.x, _curNode.y - 1);
            OpenListAdd(_curNode.x - 1, _curNode.y);
        }
    }

    private void OpenListAdd(int checkX, int checkY)
    {
        // �����¿� ������ ����� �ʰ�, ���� �ƴϸ鼭, ��������Ʈ�� ���ٸ�
        if (checkX >= _start.x && checkX < _end.x + 1 && checkY >= _start.y && checkY < _end.y + 1 && !_nodeArray[checkY - _start.y, checkX - _start.x].isWall 
            && !_closedList.Contains(_nodeArray[checkY - _start.y, checkX - _start.x]))
        {
            if (_nodeArray[checkY - _start.y, checkX - _start.x].isWall && _nodeArray[checkY - _start.y, checkX - _start.x].isWall) 
                return;

            // �̿���忡 �ְ�, ������ �Ÿ�
            Node NeighborNode = _nodeArray[checkY - _start.y, checkX - _start.x];
            int MoveCost = _curNode.G + (int)Mathf.Sqrt(Mathf.Pow(_targetNode.x - _curNode.x, 2) + Mathf.Pow(_targetNode.y - _curNode.y, 2));

            // �̵������ �̿����G���� �۰ų� �Ǵ� ��������Ʈ�� �̿���尡 ���ٸ� G, H, ParentNode�� ���� �� ��������Ʈ�� �߰�
            if (MoveCost < NeighborNode.G || !_openList.Contains(NeighborNode))
            {
                NeighborNode.G = MoveCost;
                NeighborNode.H = (Mathf.Abs(NeighborNode.x - _targetNode.x) + Mathf.Abs(NeighborNode.y - _targetNode.y)) * 10;
                NeighborNode.ParentNode = _curNode;

                _openList.Add(NeighborNode);
            }
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;

        if (FinalNodeList.Count != 0)
        {
            for (int i = 0; i < FinalNodeList.Count - 1; i++)
            {
                Vector3 s = _grid.CellToWorld(new Vector3Int(FinalNodeList[i].x, FinalNodeList[i].y, 0));
                Vector3 d = _grid.CellToWorld(new Vector3Int(FinalNodeList[i + 1].x, FinalNodeList[i + 1].y, 0));
                Gizmos.DrawLine(s, d);
            }
        }
    }

    private IEnumerator CoMove()
    {
        if(FinalNodeList.Count == 0)
        {
            Debug.LogWarning("�װ����� �� ��ΰ� �����ϴ�.");
            yield break;
        }

        bool isFlip = false;
        bool isBack = false;

        for(int i = 0; i < FinalNodeList.Count; i++)
        {
            Vector3 s = transform.position;
            Vector3 d = _grid.CellToWorld(new Vector3Int(FinalNodeList[i].x, FinalNodeList[i].y, 0));
            float currentTime = 0;

            isBack = s.y > d.y;
            if(s.x != d.x)
                isFlip = s.x > d.x;

            _controller.CharacterAnimator.FlipX(isFlip);

            string animationName = isBack ? "walk" : "walk_back";

            _controller.CharacterAnimator.PlayAnimation(isBack ? "walk" : "walk_back");

            while(Vector3.Distance(transform.position, d) > 0.01f)
            {
                currentTime += Time.deltaTime;
                transform.position = Vector3.Lerp(s, d, currentTime * _moveSpeed);
                yield return null;
            }

            _controller.CharacterAnimator.SettingOrder();
            transform.position = d;
        }

        _controller.CharacterAnimator.PlayAnimation(isBack ? "idle" : "idle_back");
    }
}
