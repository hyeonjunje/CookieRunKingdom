using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class GameManagerEx
{
    public DateTime PrevCraftTime { get; set; }

    // DataBase의 Allcookies의 인덱스로 저장
    public BaseController[] myCookies { get; set; }

    public int[] BattleCookies { get; set; }
    public StageData StageData { get; set; }

    public EKingdomState StartKingdomState { get; set; }

    public void Init()
    {

    }
}
