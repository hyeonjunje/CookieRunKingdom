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

    public BuildingController[] AllBuildings => allBuildings;
    public CookieController[] AllCookies => allCookies;
    public ItemData[] AllItemData => allItemData;
    public DataBase MyDataBase => GameManager.Game.MyDataBase;

    public void LoadData()
    {
        string itemInfoString = GameManager.SQL.UserInfo.ItemCount;

        Dictionary<ItemData, int> itemDataBase = new Dictionary<ItemData, int>();

        if (itemInfoString == "")
        {
            Debug.Log("ó���̤̤���");
            for (int i = 0; i < AllItemData.Length; i++)
                itemDataBase[AllItemData[i]] = 10;
        }
        else
        {
            Debug.Log("ó���� �ƴϱ���");
            int[] itemCountInfo = System.Array.ConvertAll(itemInfoString.Split(','), s => int.Parse(s));

            for (int i = 0; i < itemCountInfo.Length; i++)
                itemDataBase[AllItemData[i]] = itemCountInfo[i];
        }
        GameManager.Game.MyDataBase = new DataBase(itemDataBase);
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
