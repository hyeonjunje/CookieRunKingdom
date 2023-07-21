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
        // ���������� �о��
        StageData stageData = GameManager.Game.StageData;

        // �� ����⵵ ���⼭ ������
        _mapGenerator.GenerateBattleMap(stageData);
        _mapScrolling.Init();

        // ��Ű ������
        CreateCookie();

        // ��Ű ���� ����


        // ��Ʋ ����
        StartBattle(stageData);

        // �ε� UI Ǯ������!
        GameManager.Scene.EndLoading();
        GameManager.Sound.PlayBgm(EBGM.battle);
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

        _battleCookies.Sort(CustomComparison);
    }
    private int CustomComparison(CookieController x, CookieController y)
    {
        // ��Ű�� �ڸ� ������� ����
        int result = (x.CookieStat.BattlePosition).CompareTo(y.CookieStat.BattlePosition);

        // ������ index ��
        if (result == 0)
            result = ((CookieData)x.Data).CookieIndex.CompareTo(((CookieData)x.Data).CookieIndex);

        return result;
    }

    private void StartBattle(StageData stageData)
    {
        // battleManager �ʱ�ȭ �۾�
        BattleManager.instance.SetStage(_battleCookies, stageData);
        BattleManager.instance.Init();

        // UI �۾�
        GameManager.UI.PushUI(_battleUI);
        _battleUI.StartBattle(stageData, BattleManager.instance.StartBattle);
    }
}
