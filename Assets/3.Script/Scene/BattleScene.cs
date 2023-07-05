using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleScene : MonoBehaviour
{
    [SerializeField] private BattleUI _battleUI;

    private void Awake()
    {
        Init();
    }

    private void Init()
    {
        // battleManager 초기화 작업
        BattleManager.instance.SetStage(GameManager.Game.BattleCookies, GameManager.Game.StageData);
        BattleManager.instance.Init();

        // UI 작업
        GameManager.UI.PushUI(_battleUI);
        _battleUI.StartBattle(GameManager.Game.StageData, BattleManager.instance.StartBattle);
    }
}
