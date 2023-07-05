using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Node
{
    public Node(bool _isWall, int _x, int _y) { isWall = _isWall; x = _x; y = _y; }

    public bool isWall;
    public Node ParentNode;

    // G : 시작으로부터 이동했던 거리, H : |가로|+|세로| 장애물 무시하여 목표까지의 거리, F : G + H
    public int x, y, G, H;
    public int F { get { return G + H; } }
}


public class PathFindingAgent : MonoBehaviour
{
    // 맵의 크기
    [SerializeField] private Vector2 startMapPoint;  // -100 -100
    [SerializeField] private Vector2 endMapPoint;    //  100  100

    private Vector2Int start, end;
    public List<Node> FinalNodeList;

    private Node[,] NodeArray;
    private Node StartNode, TargetNode, CurNode;
    private List<Node> OpenList, ClosedList;

    private Grid _grid => GridManager.instance.Grid;
    private Tilemap[,] _map => GridManager.instance.buildingGridData.gridData;

    public void Init()
    {
        // 맵 읽기

        Vector3Int start1 = _grid.WorldToCell(startMapPoint);
        Vector3Int end1 = _grid.WorldToCell(endMapPoint);

        int minX = start1.x > end1.x ? end1.x : start1.x;
        int maxX = start1.x > end1.x ? start1.x : end1.x;
        int minY = start1.y > end1.y ? end1.y : start1.y;
        int maxY = start1.y > end1.y ? start1.y : end1.y;

        start = new Vector2Int(minX, minY);
        end = new Vector2Int(maxX, maxY);
    }


    public void PathFinding(Vector3 target)
    {

        // NodeArray의 크기 정해주고, isWall, x, y 대입
        int sizeX = end.x - start.x + 1;
        int sizeY = end.y - start.y + 1;
        NodeArray = new Node[sizeY, sizeX];

        for (int y = end.y; y >= start.y; y--)
        {
            for (int x = end.x; x >= start.x; x--)
            {
                bool isWall = _map[y - start.y, x - start.x] == null || !_map[y - start.y, x - start.x].isEmpty;
                NodeArray[y - start.y, x - start.x] = new Node(isWall, x, y);
            }
        }

        Vector3Int startPoint = _grid.WorldToCell(transform.position);
        Vector3Int endPoint = _grid.WorldToCell(target);

        // 시작과 끝 노드, 열린리스트와 닫힌리스트, 마지막리스트 초기화
        StartNode = NodeArray[startPoint.y - start.y, startPoint.x - start.x];
        TargetNode = NodeArray[endPoint.y - start.y, endPoint.x - start.x];



        OpenList = new List<Node>() { StartNode };
        ClosedList = new List<Node>();
        FinalNodeList = new List<Node>();


        while (OpenList.Count > 0)
        {
            // 열린리스트 중 가장 F가 작고 F가 같다면 H가 작은 걸 현재노드로 하고 열린리스트에서 닫힌리스트로 옮기기
            CurNode = OpenList[0];
            for (int i = 1; i < OpenList.Count; i++)
                if (OpenList[i].F <= CurNode.F && OpenList[i].H < CurNode.H) CurNode = OpenList[i];

            OpenList.Remove(CurNode);
            ClosedList.Add(CurNode);


            // 마지막
            if (CurNode == TargetNode)
            {
                Node TargetCurNode = TargetNode;
                while (TargetCurNode != StartNode)
                {
                    FinalNodeList.Add(TargetCurNode);
                    TargetCurNode = TargetCurNode.ParentNode;
                }
                FinalNodeList.Add(StartNode);
                FinalNodeList.Reverse();

                for (int i = 0; i < FinalNodeList.Count; i++) print(i + "번째는 " + FinalNodeList[i].x + ", " + FinalNodeList[i].y);
                return;
            }


            OpenListAdd(CurNode.x + 1, CurNode.y + 1);
            OpenListAdd(CurNode.x - 1, CurNode.y + 1);
            OpenListAdd(CurNode.x - 1, CurNode.y - 1);
            OpenListAdd(CurNode.x + 1, CurNode.y - 1);

            // ↑ → ↓ ←
            OpenListAdd(CurNode.x, CurNode.y + 1);
            OpenListAdd(CurNode.x + 1, CurNode.y);
            OpenListAdd(CurNode.x, CurNode.y - 1);
            OpenListAdd(CurNode.x - 1, CurNode.y);
        }
    }

    private void OpenListAdd(int checkX, int checkY)
    {
        // 상하좌우 범위를 벗어나지 않고, 벽이 아니면서, 닫힌리스트에 없다면
        if (checkX >= start.x && checkX < end.x + 1 && checkY >= start.y && checkY < end.y + 1 && !NodeArray[checkY - start.y, checkX - start.x].isWall 
            && !ClosedList.Contains(NodeArray[checkY - start.y, checkX - start.x]))
        {
            if (NodeArray[checkY - start.y, checkX - start.x].isWall && NodeArray[checkY - start.y, checkX - start.x].isWall) 
                return;

            // 이웃노드에 넣고, 일직선 거리
            Node NeighborNode = NodeArray[checkY - start.y, checkX - start.x];
            int MoveCost = CurNode.G + (int)Mathf.Sqrt(Mathf.Pow(TargetNode.x - CurNode.x, 2) + Mathf.Pow(TargetNode.y - CurNode.y, 2));

            // 이동비용이 이웃노드G보다 작거나 또는 열린리스트에 이웃노드가 없다면 G, H, ParentNode를 설정 후 열린리스트에 추가
            if (MoveCost < NeighborNode.G || !OpenList.Contains(NeighborNode))
            {
                NeighborNode.G = MoveCost;
                NeighborNode.H = (Mathf.Abs(NeighborNode.x - TargetNode.x) + Mathf.Abs(NeighborNode.y - TargetNode.y)) * 10;
                NeighborNode.ParentNode = CurNode;

                OpenList.Add(NeighborNode);
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
}
