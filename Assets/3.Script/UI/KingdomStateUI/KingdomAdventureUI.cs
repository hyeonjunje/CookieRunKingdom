using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class KingdomAdventureUI : BaseUI
{
    [Header("Buttons")]
    [SerializeField] private Button _myCookiesButton;
    [SerializeField] private Button _storageButton;
    [SerializeField] private Button _gachaButton;

    [Header("Text")]
    [SerializeField] private TextMeshProUGUI _diaText;
    [SerializeField] private TextMeshProUGUI _moneyText;
    [SerializeField] private TextMeshProUGUI _jellyText;

    [Header("UI")]
    [SerializeField] private MyCookieUI _myCookieUI;
    [SerializeField] private InventoryUI _inventoryUI;
    [SerializeField] private GachaUI _gachaUI;

    [Header("World")]
    [SerializeField] private GameObject _cookigKingdom;
    [SerializeField] private GameObject _world1;
    [SerializeField] private CookieBundleInAdventure _cookieBundle;

    public override void Init()
    {
        base.Init();

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeMoney += (() => _moneyText.text = GameManager.Game.Money.ToString("#,##0"));
        GameManager.Game.OnChangeJelly += (() => _jellyText.text = GameManager.Game.Jelly + "/" + GameManager.Game.MaxJelly);

        // 버튼 초기화
        _myCookiesButton.onClick.AddListener(() => GameManager.UI.ShowPopUpUI(_myCookieUI));
        _storageButton.onClick.AddListener(() => GameManager.UI.ShowPopUpUI(_inventoryUI));
        _gachaButton.onClick.AddListener(() => GameManager.UI.ShowPopUpUI(_gachaUI));
    }

    public override void Show()
    {
        base.Show();

        _cookigKingdom.SetActive(false);
        _world1.SetActive(true);
        // 월드 보이게

        _cookieBundle.Init();

        GameManager.Game.UpdateGoods();
    }

    public override void Hide()
    {
        // 월드 안 보이게
        _cookigKingdom.SetActive(true);
        _world1.SetActive(false);

        base.Hide();
    }
}
