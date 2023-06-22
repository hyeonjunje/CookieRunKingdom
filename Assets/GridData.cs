using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridData
{
    private int[,] gridData;

    public GridData(int[,] gridData)
    {
        this.gridData = gridData;
    }

    public int CheckGrid(int x, int y)
    {
        return gridData[y, x];
    }
}

