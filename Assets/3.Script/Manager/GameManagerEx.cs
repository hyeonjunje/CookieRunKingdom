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

    public DateTime PrevCraftTime { get; set; } // kingdomManageState를 나간 시간

    // DataBase의 Allcookies의 인덱스로 저장
    public BaseController[] myCookies { get; set; }

    public int[] BattleCookies { get; set; }
    public StageData StageData { get; set; }

    public EKingdomState StartKingdomState { get; set; }

    public void Init()
    {

    }
}
