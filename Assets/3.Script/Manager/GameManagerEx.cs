using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManagerEx
{
    // DataBase�� Allcookies�� �ε����� ����
    public BaseController[] myCookies { get; set; }

    public int[] BattleCookies { get; set; }
    public StageData StageData { get; set; }

    public EKingdomState StartKingdomState { get; set; }

    public void Init()
    {

    }
}
