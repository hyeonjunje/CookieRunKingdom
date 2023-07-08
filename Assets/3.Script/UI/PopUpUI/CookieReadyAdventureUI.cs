using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
public class CookieReadyAdventureUI : BaseUI
{
    [Header("UI")]
    [SerializeField] private CookieReadyEditUI _cookieReadyEditUI;
    [SerializeField] private Button _exitButton;
    [SerializeField] private Button _startBattleButton;
    [SerializeField] private Button _settingTeamButton;

    [Header("Text")]
    [SerializeField] private TextMeshProUGUI _diaText;
    [SerializeField] private TextMeshProUGUI _jellyText;
    [SerializeField] private TextMeshProUGUI _jellyCountText; // 필요한 젤리 개수

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

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeJelly += (() => _jellyText.text = GameManager.Game.Jelly + "/" + GameManager.Game.MaxJelly);

        _cookieSelectUI = FindObjectOfType<CookieSelectUI>();

        _cookiePositionOrigin = _cookiePosition.position;
        BindingButton();
    }

    public override void Show()
    {
        base.Show();

        _cookiePosition.position = _cookiePositionOrigin;
        _jellyCountText.text = (-GameManager.Game.StageData.Jelly).ToString();

        GameManager.Game.UpdateGoods();
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
