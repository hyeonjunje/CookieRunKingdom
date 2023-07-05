using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CookieReadyAdventureUI : BaseUI
{
    [Header("UI")]
    [SerializeField] private CookieReadyEditUI _cookieReadyEditUI;
    [SerializeField] private Button _exitButton;
    [SerializeField] private Button _startBattleButton;
    [SerializeField] private Button _settingTeamButton;
    

    [SerializeField] private Transform _cookiePosition;

    private CookieSelectUI _cookieSelectUI;
    private Vector3 _cookiePositionOrigin;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Init()
    {
        base.Init();

        _cookieSelectUI = FindObjectOfType<CookieSelectUI>();

        _cookiePositionOrigin = _cookiePosition.position;
        BindingButton();
    }

    public override void Show()
    {
        base.Show();

        _cookiePosition.position = _cookiePositionOrigin;
    }

    private void BindingButton()
    {
        _settingTeamButton.onClick.AddListener(() =>
        {
            GameManager.UI.ExitPopUpUI();
            GameManager.UI.ShowPopUpUI(_cookieReadyEditUI);
        });

        _exitButton.onClick.AddListener(() =>
        {
            GameManager.UI.ExitPopUpUI();
            GameManager.UI.PopUI();
        });

        _startBattleButton.onClick.AddListener(() =>
        {
            _cookieSelectUI.OnClickBattleStartButton();
        });
    }
}
