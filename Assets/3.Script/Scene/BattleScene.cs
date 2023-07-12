using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleScene : BaseScene
{
    [SerializeField] private BattleMapGenerator _mapGenerator;
    [SerializeField] private MapScrolling _mapScrolling;
    [SerializeField] private BattleUI _battleUI;

    private List<CookieController> _battleCookies;

    protected override void Init()
    {
        // 스테이지를 읽어와
        StageData stageData = GameManager.Game.StageData;

        // 맵 만들기도 여기서 만들자
        _mapGenerator.GenerateBattleMap(stageData);
        _mapScrolling.Init();

        // 쿠키 만들자
        CreateCookie();

        // 배틀 시작
        StartBattle(stageData);
    }

    private void CreateCookie()
    {
        CookieController[] allCookiesPrefab = DataBaseManager.Instance.AllCookies;
        List<CookieInfo> allCookieInfo = GameManager.Game.allCookies;

        _battleCookies = new List<CookieController>();

        for(int i = 0; i < allCookieInfo.Count; i++)
        {
            if(allCookieInfo[i].isBattleMember)
            {
                CookieInfo cookieInfo = allCookieInfo[i];
                CookieController cookie = Instantiate(allCookiesPrefab[cookieInfo.cookieIndex]);

                // 정보넣기
                cookie.CookieStat.LoadCookie();
                _battleCookies.Add(cookie);
            }
        }
    }

    private void StartBattle(StageData stageData)
    {
        // battleManager 초기화 작업
        BattleManager.instance.SetStage(_battleCookies, stageData);
        BattleManager.instance.Init();

        // UI 작업
        GameManager.UI.PushUI(_battleUI);
        _battleUI.StartBattle(stageData, BattleManager.instance.StartBattle);
    }
}
