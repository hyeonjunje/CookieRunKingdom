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
        BattleManager.instance.Init(GameManager.Game.BattleCookies, GameManager.Game.StageData);
        BattleManager.instance.StartBattle();

        _battleUI.Init();
        GameManager.UI.PushUI(_battleUI);
    }
}
