using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class GameManagerEx
{
    #region ��������
    private int _kingdomIndex;
    public int KingdomIndex
    {
        get { return _kingdomIndex; }
        set { _kingdomIndex = value; }
    }

    private string _kingdomName;
    public string KingdomName
    {
        get { return _kingdomName; }
        set { _kingdomName = value; }
    }
    private bool _isFirst;
    public bool IsFirst
    {
        get { return _isFirst; }
        set { _isFirst = value; }
    }

    public int EnvironmentScore { get; set; }
    #endregion

    #region ��ȭ
    public DateTime prevJellyTime = System.DateTime.Now;
    public int jellyTime = Utils.JellyTime;
    public Action OnChangeDia, OnChangeMoney, OnChangeJelly;
    private int _dia, _money, _jelly, _maxJelly;

    public int Dia
    {
        get { return _dia; }
        set { _dia = value; OnChangeDia?.Invoke(); }
    }

    public int Money
    {
        get { return _money; }
        set { _money = value; OnChangeMoney?.Invoke(); }
    }

    public int Jelly
    {
        get { return _jelly; }
        set { _jelly = value; OnChangeJelly?.Invoke(); }
    }

    public int MaxJelly
    {
        get { return _maxJelly; }
        set { _maxJelly = value; Jelly += _maxJelly; }
    }


    public void UpdateGoods()
    {
        OnChangeDia?.Invoke();
        OnChangeMoney?.Invoke();
        OnChangeJelly?.Invoke();
    }

    #endregion

    #region ��Ű����
    public Vector3 battlePosition;

    public List<CookieInfo> allCookies;
    #endregion

    #region �ǹ�����
    public List<BuildingInfo> OwnedCraftableBuildings;
    #endregion

    #region ������ ����
    public DataBase MyDataBase { get; set; }
    #endregion

    public DateTime PrevCraftTime { get; set; } // kingdomManageState�� ���� �ð�

    // ������ ������
    // ==============================================
    // ������ϴ� ������

    public StageData StageData { get; set; }

    public EKingdomState StartKingdomState { get; set; }

    public void Init()
    {
        
    }

    /// <summary>
    /// �α��� �Ǹ� ȣ��
    /// </summary>
    public void LoadData()
    {
        UserInfo userInfo = GameManager.SQL.UserInfo;

        _kingdomName = userInfo.KingdomName;
        _dia = userInfo.Dia;
        _isFirst = userInfo.IsFirst == 0;
        _money = userInfo.Money;
        _dia = userInfo.Dia;
        _jelly = userInfo.Jelly;
        _maxJelly = userInfo.MaxJelly;

        Debug.Log(userInfo.LastTime);

        PrevCraftTime = DateTime.ParseExact(userInfo.LastTime, "yyyyMMddHHmmss",
            System.Globalization.CultureInfo.InvariantCulture);

        allCookies = userInfo.cookieJson.allCookies;
        OwnedCraftableBuildings = userInfo.buildingJson.allBuildings;
        battlePosition = userInfo.cookieJson.battlePosition;
    }

    public void SaveData()
    {
        UserInfo userInfo = GameManager.SQL.UserInfo;

        int isFirst = 0;
        if (!_isFirst)
            isFirst = 1;

        userInfo.SaveData(_kingdomIndex, _kingdomName, isFirst, _money, _dia, _jelly, _maxJelly,
            PrevCraftTime, ReturnItemDataInfo());
    }

    private string ReturnItemDataInfo()
    {
        string result = "";

        foreach(var itemInfo in MyDataBase.itemDataBase)
        {
            result += itemInfo.Value + ",";
        }
        result = result.TrimEnd(',');

        Debug.Log(result);

        return result;
    }
}
