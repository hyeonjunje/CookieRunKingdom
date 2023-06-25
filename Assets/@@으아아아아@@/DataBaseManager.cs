using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataBaseManager : MonoBehaviour
{
    // 데이터베이스에서 정보들을 가져와서 파싱 해주라...

    public static DataBaseManager instance = null;

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

    [Header("Test")]
    [SerializeField] private ItemData[] testItem;
    [SerializeField] private int[] testCount;

    public DataBase MyDataBase { get; private set; }

    private void Start()
    {
        Dictionary<ItemData, int> itemDataBase = new Dictionary<ItemData, int>();
        for(int i = 0; i < testItem.Length; i++)
        {
            itemDataBase[testItem[i]] = testCount[i];
        }

        MyDataBase = new DataBase(itemDataBase);
    }
}
