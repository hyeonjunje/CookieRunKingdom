using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridManager : MonoBehaviour
{
    public static GridManager instance = null;

    private void Awake()
    {
        if(instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(gameObject);
        }
    }

    [SerializeField] private Grid grid;

    public Vector2Int startPoint { get; private set; }
    public Grid Grid => grid;
    public GridMapData tileGridData { get; private set; }
    public GridMapData buildingGridData { get; private set; }


    public void SetGridMapData(GridMapData tileGridData, GridMapData buildingGridData, Vector2Int startPoint)
    {
        this.tileGridData = tileGridData;
        this.buildingGridData = buildingGridData;
        this.startPoint = startPoint;
    }

    public bool UpdateTileColor(int gridX, int gridY)
    {
        gridX -= startPoint.x;
        gridY -= startPoint.y;

        Tilemap tile = buildingGridData.gridData[gridY, gridX];

        if(tile == null)
            return false;
        if(tile.isEmpty)
            return true;
        else
            return false;
    }

    public void UpdateTile(int gridX, int gridY, bool isEmpty)
    {
        gridX -= startPoint.x;
        gridY -= startPoint.y;

        Tilemap tile = buildingGridData.gridData[gridY, gridX];

        if (tile == null)
            return;

        tile.isEmpty = isEmpty;
    }
}
