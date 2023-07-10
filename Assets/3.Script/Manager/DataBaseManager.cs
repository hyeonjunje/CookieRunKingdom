using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataBaseManager : Singleton<DataBaseManager>
{
    // �����ͺ��̽����� �������� �����ͼ� �Ľ� ���ֶ�...

    [Header("��� �ǹ�")]
    [SerializeField] private BuildingController[] allBuildings;

    [Header("��� ��Ű�� ������")]
    [SerializeField] private CookieController[] allCookies;

    [Header("��� ������ ������")]
    [SerializeField] private ItemData[] allItemData;

    [Header("�Ͽ�¡ ������")]
    [SerializeField] private HousingItemData[] allTills;

    [Header("Test")]
    [SerializeField] private ItemData[] testItem;

    public BuildingController[] AllBuildings => allBuildings;
    public CookieController[] AllCookies => allCookies;
    public ItemData[] AllItemData => allItemData;
    public HousingItemData[] AllTiles => allTills;
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
        if(MyDataBase.itemDataBase.ContainsKey(item))
        {
            MyDataBase.itemDataBase[item] += count;
        }
        else
        {
            MyDataBase.itemDataBase[item] = count;
        }
    }
}
