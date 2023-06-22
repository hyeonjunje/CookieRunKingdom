using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundGenerator : MonoBehaviour
{
    [SerializeField] private Tilemap tilemapPrefab;
    [SerializeField] private Transform parent;

    [SerializeField] private Vector2 startPoint;
    [SerializeField] private Vector2 endPoint;

    [SerializeField] private Grid grid;
    [SerializeField] private LayerMask detectedLayer;
    
    private int[,] mapData;
    private int startOrder;

    public GridData tileGridData { get; private set; }
    public GridData buildingGridData { get; private set; }

    private void Start()
    {
        Vector3Int start = grid.WorldToCell(startPoint);
        Vector3Int end = grid.WorldToCell(endPoint);

        startOrder = Mathf.Abs(start.x - end.x) * Mathf.Abs(start.y - end.y);
        
        int minX = start.x > end.x ? end.x : start.x;
        int maxX = start.x > end.x ? start.x : end.x;
        int minY = start.y > end.y ? end.y : start.y;
        int maxY = start.y > end.y ? start.y : end.y;

        GenerateGround(new Vector2Int(minX, minY), new Vector2Int(maxX, maxY));
    }

    private void GenerateGround(Vector2Int start, Vector2Int end)
    {
        mapData = new int[end.y - start.y + 1, end.x - start.x + 1];

        for (int y = start.y; y <= end.y; y++)
        {
            for(int x = start.x; x <= end.x; x++)
            {
                mapData[y - start.y, x - start.x] = -1;

                Vector3 gridPosition = grid.CellToWorld(new Vector3Int(x, y, 0));
                RaycastHit2D hit = Physics2D.Raycast(gridPosition, Vector2.zero, 0f, detectedLayer);

                if(hit.collider != null)
                {
                    mapData[y - start.y, x - start.x] = startOrder--;
                    Tilemap tile = Instantiate(tilemapPrefab, parent);
                    tile.SetInfo(gridPosition.x, gridPosition.y, startOrder);
                }
            }
        }

        tileGridData = new GridData(mapData);
        buildingGridData = new GridData(mapData);
    }
}
