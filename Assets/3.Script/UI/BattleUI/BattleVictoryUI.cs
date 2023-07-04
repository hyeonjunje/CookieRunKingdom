using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleVictoryUI : BaseUI
{
    [SerializeField] private CookieBattleAward _award;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Show()
    {
        base.Show();
    }

    public override void Init()
    {
        base.Init();

        _award.ShowResult();
    }
}
