using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleScene : BaseScene
{
    [SerializeField] private BattleUI _battleUI;

    protected override void Init()
    {
        // 맵 만들기도 여기서 만들자

        // 쿠키 만들자

        StartBattle();
    }

    private void StartBattle()
    {
        // battleManager 초기화 작업
        BattleManager.instance.SetStage(GameManager.Game.BattleCookies, GameManager.Game.StageData);
        BattleManager.instance.Init();

        // UI 작업
        GameManager.UI.PushUI(_battleUI);
        _battleUI.StartBattle(GameManager.Game.StageData, BattleManager.instance.StartBattle);
    }
}
