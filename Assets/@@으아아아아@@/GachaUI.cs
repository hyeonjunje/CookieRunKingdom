using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class GachaUI : BaseUI
{
    [Header("¹è°æ")]
    [SerializeField] private GameObject _specialGacha;
    [SerializeField] private GameObject _epicGacha;

    [Header("UI")]
    [SerializeField] private TextMeshProUGUI _diaText;
    [SerializeField] private TextMeshProUGUI _moneyText;
    [SerializeField] private TextMeshProUGUI _speicalCookieCutterText;
    [SerializeField] private TextMeshProUGUI _cookieCutterText;

    [SerializeField] private Button _specialGachaButton;
    [SerializeField] private Button _epicGachaButton;
    [SerializeField] private Button _exitButton;

    [SerializeField] private Button _gachaButton;
    [SerializeField] private Button _gacha10Button;

    [SerializeField] private Image _gachaImage;
    [SerializeField] private Image _gacha10Image;

    [SerializeField] private TextMeshProUGUI _gachaText;
    [SerializeField] private TextMeshProUGUI _gacha10Text;

    [Header("»ö±ò")]
    [SerializeField] private Color _selectedColor;
    [SerializeField] private Color _idleColor;

    [Header("Sprite")]
    [SerializeField] private Sprite _diaSprite;
    [SerializeField] private Sprite _specialCookieCutterSprite;
    [SerializeField] private Sprite _cookieCutterSprite;

    private KingdomManager _manager;

    public override void Hide()
    {
        base.Hide();

        _manager.IsMoveCamera = true;
    }

    public override void Init()
    {
        base.Init();

        _manager = FindObjectOfType<KingdomManager>();

        _specialGachaButton.onClick.AddListener(() => SpecialGacha());
        _epicGachaButton.onClick.AddListener(() => EpicGacha());

        _exitButton.onClick.AddListener(() => GameManager.UI.ExitPopUpUI());

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeMoney += (() => _moneyText.text = GameManager.Game.Money.ToString("#,##0"));
        GameManager.Game.OnChangeSpecialCookieCutter += (() => _speicalCookieCutterText.text = GameManager.Game.SpecialCookieCutter.ToString("#,##0"));
        GameManager.Game.OnChangeCookieCutter += (() => _cookieCutterText.text = GameManager.Game.CookieCutter.ToString("#,##0"));
    }

    public override void Show()
    {
        base.Show();

        _manager.IsMoveCamera = false;

        InitSetting();
        SpecialGacha();

        GameManager.Game.UpdateGoods();
    }

    private void InitSetting()
    {
        _specialGacha.SetActive(false);
        _epicGacha.SetActive(false);

        _specialGachaButton.image.color = _idleColor;
        _epicGachaButton.image.color = _idleColor;
    }

    private void SpecialGacha()
    {
        InitSetting();
        _specialGacha.SetActive(true);
        _specialGachaButton.image.color = _selectedColor;

        if (GameManager.Game.SpecialCookieCutter > 0)
        {
            _gachaImage.sprite = _specialCookieCutterSprite;
            _gachaText.text = GameManager.Game.SpecialCookieCutter + "/1";
        }
        else
        {
            _gachaImage.sprite = _diaSprite;
            _gachaText.text = GameManager.Game.Dia + "/300";
        }

        if(GameManager.Game.SpecialCookieCutter >= 10)
        {
            _gacha10Image.sprite = _specialCookieCutterSprite;
            _gacha10Text.text = GameManager.Game.SpecialCookieCutter + "/10";
        }
        else
        {
            _gacha10Image.sprite = _diaSprite;
            _gacha10Text.text = GameManager.Game.Dia + "/3000";
        }
    }

    private void EpicGacha()
    {
        InitSetting();
        _epicGacha.SetActive(true);
        _epicGachaButton.image.color = _selectedColor;

        if (GameManager.Game.SpecialCookieCutter > 0)
        {
            _gachaImage.sprite = _cookieCutterSprite;
            _gachaText.text = GameManager.Game.CookieCutter + "/1";
        }
        else
        {
            _gachaImage.sprite = _diaSprite;
            _gachaText.text = GameManager.Game.Dia + "/300";
        }

        if (GameManager.Game.SpecialCookieCutter >= 10)
        {
            _gacha10Image.sprite = _cookieCutterSprite;
            _gacha10Text.text = GameManager.Game.CookieCutter + "/10";
        }
        else
        {
            _gacha10Image.sprite = _diaSprite;
            _gacha10Text.text = GameManager.Game.Dia + "/3000";
        }
    }
}
