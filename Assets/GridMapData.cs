using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridMapData
{
    public Tilemap[,] gridData;

    public GridMapData(Tilemap[,] gridMapData)
    {
        this.gridData = gridMapData;
    }

    public bool CheckGrid(int x, int y)
    {
        return gridData[y, x].isEmpty;
    }
}

