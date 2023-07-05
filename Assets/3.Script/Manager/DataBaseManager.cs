using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataBaseManager : Singleton<DataBaseManager>
{
    // �����ͺ��̽����� �������� �����ͼ� �Ľ� ���ֶ�...

    [Header("�⺻ ��Ű")]
    [SerializeField] private BaseController[] defaultCookie;

    [Header("���� ���� ��Ű")]
    [SerializeField] private List<BaseController> ownedCookies;

    [Header("��� ��Ű�� ������")]
    [SerializeField] private BaseController[] allCookies;

    [Header("��� ������ ������")]
    [SerializeField] private ItemData[] allItemData;

    [Header("Test")]
    [SerializeField] private ItemData[] testItem;

    public BaseController[] DefaultCookie => defaultCookie;
    public List<BaseController> OwnedCookies => ownedCookies;
    public BaseController[] AllCookies => allCookies;
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
