using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleScene : BaseScene
{
    [SerializeField] private BattleUI _battleUI;

    protected override void Init()
    {
        // �� ����⵵ ���⼭ ������

        // ��Ű ������

        StartBattle();
    }

    private void StartBattle()
    {
        // battleManager �ʱ�ȭ �۾�
        BattleManager.instance.SetStage(GameManager.Game.BattleCookies, GameManager.Game.StageData);
        BattleManager.instance.Init();

        // UI �۾�
        GameManager.UI.PushUI(_battleUI);
        _battleUI.StartBattle(GameManager.Game.StageData, BattleManager.instance.StartBattle);
    }
}
