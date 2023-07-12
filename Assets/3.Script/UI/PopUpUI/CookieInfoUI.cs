using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CookieInfoUI : BaseUI
{
    [Header("UI")]
    [SerializeField] private GameObject _kingdomManageUI;
    [SerializeField] private GameObject _myCookieUI;

    [Header("TopRight")]
    [SerializeField] private TextMeshProUGUI _diaText;
    [SerializeField] private TextMeshProUGUI _moneyText;
    [SerializeField] private Button _exitButton;

    [Header("Left")]
    [SerializeField] private Image _cookieGradeImage;
    [SerializeField] private TextMeshProUGUI _cookieNameText;
    [SerializeField] private TextMeshProUGUI _cookieLevelText;
    [SerializeField] private Image _cookieTypeImage;
    [SerializeField] private TextMeshProUGUI _cookieTypeText;

    [SerializeField] private Color _originColor;
    [SerializeField] private Color[] _positionColors;  // 전방, 중앙, 후방
    [SerializeField] private Image[] _positionImages;
    [SerializeField] private TextMeshProUGUI _cookiePositionText;

    [Header("Center")]
    [SerializeField] private Transform _instantiateParent;
    [SerializeField] private Button _cookieInteractionButton;

    [Header("Right")]
    [SerializeField] private TextMeshProUGUI _powerText;
    [SerializeField] private TextMeshProUGUI _hpText;
    [SerializeField] private TextMeshProUGUI _attackText;
    [SerializeField] private TextMeshProUGUI _defenseText;
    [SerializeField] private TextMeshProUGUI _criticalText;
    [SerializeField] private Image _cookieSKillImage;
    [SerializeField] private TextMeshProUGUI _cookieSKillText;

    [SerializeField] private Button _cookieLevelUpButton;
    [SerializeField] private Button _cookieEvolutionButton;
    [SerializeField] private Button _cookieSkillLevelUpButton;

    private CookieController _cookie;
    private CookieData _data;
    private Camera _camera;

    private float _prevCameraOrthoSize;
    private Vector3 _prevCameraPosition;
    private Coroutine _coTouch = null;
    private KingdomManager _manager;

    private bool _isOwned = false;

    public void SetCookie(CookieController cookie)
    {
        _cookie = cookie;
        _data = (CookieData)(_cookie.Data);

        _isOwned = _cookie.CookieStat.IsHave;
    }

    public override void Hide()
    {
        base.Hide();

        _manager.IsMoveCamera = true;

        _myCookieUI.SetActive(true);
        _kingdomManageUI.SetActive(true);

        _camera.orthographicSize = _prevCameraOrthoSize;
        _camera.transform.position = _prevCameraPosition;

        _instantiateParent.DestroyAllChild();
    }

    public override void Init()
    {
        base.Init();

        _manager = FindObjectOfType<KingdomManager>();

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeMoney += (() => _moneyText.text = GameManager.Game.Money.ToString("#,##0"));
        GameManager.Game.UpdateGoods();

        _exitButton.onClick.AddListener(() => GameManager.UI.PopUI());
        _camera = Camera.main;

        _cookieLevelUpButton.onClick.AddListener(() =>
        {
            if (!_isOwned) return;

            _cookie.CookieStat.LevelUp();
            UpdateUIInfo();
        });
        _cookieEvolutionButton.onClick.AddListener(() =>
        {
            if (!_isOwned) return;

            _cookie.CookieStat.Evolution();
            UpdateUIInfo();
        });
        _cookieSkillLevelUpButton.onClick.AddListener(() =>
        {
            if (!_isOwned) return;

            _cookie.CookieStat.SkillLevelUp();
            UpdateUIInfo();
        });
    }

    public override void Show()
    {
        base.Show();

        _manager.IsMoveCamera = false;

        _myCookieUI.SetActive(false);
        _kingdomManageUI.SetActive(false);

        _prevCameraOrthoSize = _camera.orthographicSize;
        _prevCameraPosition = _camera.transform.position;

        _camera.orthographicSize = 11;
        _camera.transform.position = new Vector3(0, 0, -10);

        // 왼쪽
        _cookieGradeImage.sprite = _data.CookieGradeSprite;
        _cookieNameText.text = _data.CharacterName;
        _cookieLevelText.text = _isOwned ? _cookie.CookieStat.CookieLevel + "/60" : "미획득";
        _cookieTypeImage.sprite = _data.TypeSprite;
        _cookieTypeText.text = _data.CookieTypeName;

        for (int i = 0; i < _positionImages.Length; i++)
        {
            if(i == (int)_data.CookiePosition)
            {
                _positionImages[i].color = _positionColors[i];
                _cookiePositionText.color = _positionColors[i];
            }
            else
            {
                _positionImages[i].color = _originColor;
            }
        }

        _cookiePositionText.text = _data.CookiePositionName;

        // 중앙

        // 생성은 얘로 일단 하고...
        CookieController tempCookie = Instantiate(_cookie, _instantiateParent);
        tempCookie.CharacterAnimator.SettingOrderLayer(true);
        TouchCookie(tempCookie);
        tempCookie.transform.localPosition = Vector3.zero;
        tempCookie.transform.localScale = Vector3.one;

        _cookieInteractionButton.onClick.RemoveAllListeners();
        _cookieInteractionButton.onClick.AddListener(() => TouchCookie(tempCookie));


        // 오른쪽
        if (_isOwned)
        {
            _powerText.text = _cookie.CharacterStat.powerStat.ToString();
            _hpText.text = _cookie.CharacterStat.hpStat.ResultStat.ToString("#,##0");
            _attackText.text = _cookie.CharacterStat.attackStat.ResultStat.ToString("#,##0");
            _defenseText.text = _cookie.CharacterStat.defenseStat.ResultStat.ToString("#,##0");
            _criticalText.text = _cookie.CharacterStat.criticalStat.ResultStat.ToString("#,##0.00") + "%";
        }
        else
        {
            _powerText.text = "-";
            _hpText.text = "-";
            _attackText.text = "-";
            _defenseText.text = "-";
            _criticalText.text = "-";
        }
        
        _cookieSKillImage.sprite = _data.SKillSprite;
        _cookieSKillText.text = "레벨 " + _cookie.CookieStat.SkillLevel.ToString();
    }

    public void UpdateUIInfo()
    {

        if (_isOwned)
        {
            _cookieLevelText.text =_cookie.CookieStat.CookieLevel + "/60";

            _powerText.text = _cookie.CharacterStat.powerStat.ToString();
            _hpText.text = _cookie.CharacterStat.hpStat.ResultStat.ToString("#,##0");
            _attackText.text = _cookie.CharacterStat.attackStat.ResultStat.ToString("#,##0");
            _defenseText.text = _cookie.CharacterStat.defenseStat.ResultStat.ToString("#,##0");
            _criticalText.text = _cookie.CharacterStat.criticalStat.ResultStat.ToString("#,##0.00") + "%";

            _cookieSKillText.text = "레벨 " + _cookie.CookieStat.SkillLevel.ToString();
        }
    }

    private void TouchCookie(BaseController cookie)
    {
        // 터치하면 touch 애니메이션 실행하고 (대사까지 쳐주면 완벽)
        // 애니메이션이 끝나면 standard 애니메이션 무한재생
        if (_coTouch != null)
            StopCoroutine(_coTouch);
        _coTouch = StartCoroutine(CoTouch(cookie));
    }

    private IEnumerator CoTouch(BaseController cookie)
    {
        cookie.CharacterAnimator.PlayAnimation("touch", false);

        while (true)
        {
            if(cookie.CharacterAnimator.IsPlayingAnimation())
                yield return null;
            else
                break;
        }

        cookie.CharacterAnimator.PlayAnimation("standard");
    }
}
