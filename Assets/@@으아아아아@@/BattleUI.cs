using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleUI : BaseUI
{
    [SerializeField] private Transform _skillButtonParent;
    [SerializeField] private SkillButton _skillButtonPrefab;

    // 한 스테이지당 3분

    public override void Show()
    {
        base.Show();
    }

    private void Start()
    {
        Init();
    }

    private void Init()
    {
        BaseController[] cookies = BattleManager.instance.Cookies;

        for(int i = 0; i < cookies.Length; i++)
        {
            SkillButton skillButton = Instantiate(_skillButtonPrefab, _skillButtonParent);
            skillButton.Init(cookies[i]);
        }
    }
}
