using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class DataBase
{
    // ������ �����ͺ��̽�
    public Dictionary<ItemData, int> itemDataBase = new Dictionary<ItemData, int>();

    public DataBase(Dictionary<ItemData, int> itemDataBase)
    {
        this.itemDataBase = itemDataBase;
    }
}
