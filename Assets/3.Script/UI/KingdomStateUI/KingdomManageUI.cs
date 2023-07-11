using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class KingdomManageUI : BaseUI
{
    [Header("Buttons")]
    [SerializeField] private Button _myCookiesButton;
    [SerializeField] private Button _storageButton;
    [SerializeField] private Button _gachaButton;

    [Header("Text")]
    [SerializeField] private TextMeshProUGUI _jellyText;
    [SerializeField] private TextMeshProUGUI _moneyText;
    [SerializeField] private TextMeshProUGUI _diaText;

    [Header("UI")]
    [SerializeField] private MyCookieUI _myCookieUI;
    [SerializeField] private InventoryUI _inventoryUI;
    [SerializeField] private GachaUI _gachaUI;

    private KingdomManager _manager;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Show()
    {
        base.Show();

        GameManager.Game.UpdateGoods();
    }

    public override void Init()
    {
        base.Init();

        _manager = FindObjectOfType<KingdomManager>();

        GameManager.Game.OnChangeDia = null;
        GameManager.Game.OnChangeMoney = null;
        GameManager.Game.OnChangeJelly = null;

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeMoney += (() => _moneyText.text = GameManager.Game.Money.ToString("#,##0"));
        GameManager.Game.OnChangeJelly += (() => _jellyText.text = GameManager.Game.Jelly + "/" + GameManager.Game.MaxJelly);

        // 버튼 초기화
        _myCookiesButton.onClick.AddListener(() => GameManager.UI.ShowPopUpUI(_myCookieUI));
        _storageButton.onClick.AddListener(() => GameManager.UI.ShowPopUpUI(_inventoryUI));
        _gachaButton.onClick.AddListener(() => GameManager.UI.PushUI(_gachaUI));
    }
}
