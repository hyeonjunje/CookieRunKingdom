using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class GameManagerEx
{
    #region 유저정보
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
    #endregion

    #region 재화
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

    #region 쿠키정보
    public List<CookieInfo> AllCookies { get; set; }
    #endregion

    #region 건물정보
    public List<CraftableBuildingInfo> OwnedCraftableBuildings { get; set; }
    #endregion

    public DateTime PrevCraftTime { get; set; } // kingdomManageState를 나간 시간

    // 저장할 데이터
    // ==============================================
    // 저장안하는 데이터

    public StageData StageData { get; set; }

    public EKingdomState StartKingdomState { get; set; }

    public void Init()
    {
        /*SaveData saveData = GameManager.File.SaveData;

        _dia = saveData.dia;
        _money = saveData.money;
        _jelly = saveData.jelly;
        _maxJelly = saveData.maxJelly;

        PrevCraftTime = DateTime.ParseExact(saveData.prevCraftTime, "yyyyMMddHHmmss",
        System.Globalization.CultureInfo.InvariantCulture); // DateTime 으로 변환

        AllCookies = saveData.allCookies;
        OwnedCraftableBuildings = saveData.ownedCraftableBuildings;*/
    }

    /// <summary>
    /// 로그인 되면 호출
    /// </summary>
    public void LoadData()
    {
        UserInfo userInfo = GameManager.SQL.UserInfo;

        _kingdomName = userInfo.Name;
        _dia = userInfo.Dia;
        _isFirst = userInfo.IsFirst == 0;
        _money = userInfo.Money;
        _dia = userInfo.Dia;
        _jelly = userInfo.Jelly;
        _maxJelly = userInfo.MaxJelly;
    }

    public void SaveData()
    {
        UserInfo userInfo = GameManager.SQL.UserInfo;

        int isFirst = 0;
        if (!_isFirst)
            isFirst = 1;

        userInfo.SetData(_kingdomName, isFirst, _money, _dia, _jelly, _maxJelly);
    }


/*    public void SetSaveData()
    {
        SaveData saveData = new SaveData();
        saveData.dia = _dia;
        saveData.money = _money;
        saveData.jelly = _jelly;
        saveData.maxJelly = _maxJelly;

        saveData.allCookies = AllCookies;
        saveData.ownedCraftableBuildings = OwnedCraftableBuildings;

        GameManager.File.SetSaveData(saveData);
        GameManager.File.SaveGame();
    }*/
}
