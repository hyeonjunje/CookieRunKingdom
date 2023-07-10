using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class GameManagerEx
{
    #region 재화
    public DateTime prevJellyTime = System.DateTime.Now;
    public int jellyTime = Utils.JellyTime;
    public Action OnChangeDia, OnChangeMoney, OnChangeJelly;
    private int _dia, _money, _jelly, _maxJelly;
    public Action OnChangeCookieCutter, OnChangeSpecialCookieCutter;
    private int _cookieCutter, _specialCookieCutter;

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

    public int CookieCutter
    {
        get { return _cookieCutter; }
        set { _cookieCutter = value; OnChangeCookieCutter?.Invoke(); }
    }
    public int SpecialCookieCutter
    {
        get { return _specialCookieCutter; }
        set { _specialCookieCutter = value; OnChangeSpecialCookieCutter?.Invoke(); }
    }

    public void UpdateGoods()
    {
        OnChangeDia?.Invoke();
        OnChangeMoney?.Invoke();
        OnChangeJelly?.Invoke();

        OnChangeCookieCutter?.Invoke();
        OnChangeSpecialCookieCutter?.Invoke();
    }

    #endregion

    #region 쿠키정보
    public List<CookieInfo> allCookies { get; set; }
    #endregion

    #region 건물정보
    public List<BuildingInfo> ownedBuildings { get; set; }
    #endregion

    public DateTime PrevCraftTime { get; set; } // kingdomManageState를 나간 시간
    public StageData StageData { get; set; }

    public EKingdomState StartKingdomState { get; set; }

    public void Init()
    {
        SaveData saveData = GameManager.File.SaveData;
        _dia = saveData.dia;
        _money = saveData.money;
        _jelly = saveData.jelly;
        _maxJelly = saveData.maxJelly;

        _cookieCutter = saveData.cookieCutter;
        _specialCookieCutter = saveData.specialCookieCutter;

        PrevCraftTime = DateTime.ParseExact(saveData.prevCraftTime, "yyyyMMddHHmmss",
        System.Globalization.CultureInfo.InvariantCulture); // DateTime 으로 변환

        allCookies = saveData.allCookies;
        ownedBuildings = saveData.ownedBuildings;
    }


    public void SetSaveData()
    {
        SaveData saveData = new SaveData();
        saveData.dia = _dia;
        saveData.money = _money;
        saveData.jelly = _jelly;
        saveData.maxJelly = _maxJelly;

        saveData.cookieCutter = _cookieCutter;
        saveData.specialCookieCutter = _specialCookieCutter;

        saveData.allCookies = allCookies;
        saveData.ownedBuildings = ownedBuildings;

        GameManager.File.SetSaveData(saveData);
        GameManager.File.SaveGame();
    }
}
