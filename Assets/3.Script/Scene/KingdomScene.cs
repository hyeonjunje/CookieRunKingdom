using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomScene : BaseScene
{
    [SerializeField] private KingdomManager _kingdomManager;
    [SerializeField] private List<BaseController> _myCookies = new List<BaseController>();

    protected override void Init()
    {
        // 왕국 배치

        // 쿠키 생성
        ArrangeCookies();


        // 왕국 상태패턴
        _kingdomManager.Init();
    }

    private void ArrangeCookies()
    {
        List<BaseController> myCookies = DataBaseManager.Instance.OwnedCookies;
        for(int i = 0; i < myCookies.Count; i++)
        {
            BaseController cookie = Instantiate(myCookies[i]);
            _myCookies.Add(cookie);
        }
    }
}
