using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataBaseManager : Singleton<DataBaseManager>
{
    // �����ͺ��̽����� �������� �����ͼ� �Ľ� ���ֶ�...

    [Header("��� �ǹ�")]
    [SerializeField] private BuildingController[] allBuildings;
    [SerializeField] private BuildingController[] landmarks;
    [SerializeField] private BuildingController cookieHouse;

    [Header("��� ��Ű�� ������")]
    [SerializeField] private CookieController[] allCookies;

    [Header("��� ������ ������")]
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
        // ��ȭ��� �ٷ� �� �ڸ����� ������ ������Ʈ
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
