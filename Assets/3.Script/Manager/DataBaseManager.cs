using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataBaseManager : Singleton<DataBaseManager>
{
    // 데이터베이스에서 정보들을 가져와서 파싱 해주라...

    [Header("기본 쿠키")]
    [SerializeField] private BaseController[] defaultCookie;

    [Header("내가 가진 쿠키")]
    [SerializeField] private List<BaseController> ownedCookies;

    [Header("모든 쿠키의 데이터")]
    [SerializeField] private BaseController[] allCookies;

    [Header("모든 아이템 데이터")]
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
