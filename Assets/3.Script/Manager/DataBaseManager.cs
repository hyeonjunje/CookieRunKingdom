using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataBaseManager : Singleton<DataBaseManager>
{
    // 데이터베이스에서 정보들을 가져와서 파싱 해주라...

    [Header("모든 건물")]
    [SerializeField] private BuildingController[] allBuildings;
    [SerializeField] private BuildingController[] landmarks;
    [SerializeField] private BuildingController cookieHouse;

    [Header("모든 쿠키의 데이터")]
    [SerializeField] private CookieController[] allCookies;

    [Header("모든 아이템 데이터")]
    [SerializeField] private ItemData[] allItemData;

    [Header("Test")]
    [SerializeField] private ItemData[] testItem;

    public BuildingController[] AllBuildings => allBuildings;
    public CookieController[] AllCookies => allCookies;
    public ItemData[] AllItemData => allItemData;
    public DataBase MyDataBase { get; private set; }

    private void Start()
    {
        Dictionary<ItemData, int> itemDataBase = new Dictionary<ItemData, int>();
        for(int i = 0; i < testItem.Length; i++)
        {
            itemDataBase[testItem[i]] = 100;
        }

        MyDataBase = new DataBase(itemDataBase);
    }

    public void AddItem(ItemData item, int count)
    {
        // 재화라면 바로 그 자리에서 데이터 업데이트
        if (item.ItemType == EItemType.dia)
        {
            GameManager.Game.Dia += count;
            return;
        }
        else if (item.ItemType == EItemType.money)
        {
            GameManager.Game.Money += count;
            return;
        }

        if (MyDataBase.itemDataBase.ContainsKey(item))
        {
            MyDataBase.itemDataBase[item] += count;
        }
        else
        {
            MyDataBase.itemDataBase[item] = count;
        }
    }
}
