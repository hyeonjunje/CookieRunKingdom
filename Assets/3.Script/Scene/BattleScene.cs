using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleScene : BaseScene
{
    [SerializeField] private BattleUI _battleUI;

    private List<CookieController> _battleCookies;

    protected override void Init()
    {
        // �� ����⵵ ���⼭ ������

        // ��Ű ������
        CreateCookie();

        // ��Ʋ ����
        StartBattle();
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

                // �����ֱ�
                cookie.CookieStat.LoadCookie();
                _battleCookies.Add(cookie);
            }
        }
    }

    private void StartBattle()
    {
        StageData stageData = GameManager.Game.StageData;

        // battleManager �ʱ�ȭ �۾�
        BattleManager.instance.SetStage(_battleCookies, stageData);
        BattleManager.instance.Init();

        // UI �۾�
        GameManager.UI.PushUI(_battleUI);
        _battleUI.StartBattle(stageData, BattleManager.instance.StartBattle);
    }
}
