using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

//1.2 1.5

public class BattleUI : BaseUI
{
    [Header("Cookie Skill UI")]
    [SerializeField] private Transform _skillButtonParent;
    [SerializeField] private SkillButton _skillButtonPrefab;

    [Header("BattleSpeedButton")]
    [SerializeField] private Button _battleSpeedButton;
    [SerializeField] private TextMeshProUGUI _battleSpeedText;
    [SerializeField] private GameObject _battleSpeedButtonActive;
    [SerializeField] private Color _activeColor;
    [SerializeField] private Color _inActiveColor;

    [Header("AutoBattleButton")]
    [SerializeField] private Button _autoBattleButton;
    [SerializeField] private TextMeshProUGUI _autoBattleText;
    [SerializeField] private GameObject _autoBattleButtonActive;

    [Header("PauseButton")]
    [SerializeField] private Button _pauseButton;

    [Header("Gauge")]
    [SerializeField] private RectTransform _battleGague;

    [Header("Time")]
    [SerializeField] private TextMeshProUGUI _timeText;

    [Header("UI")]
    [SerializeField] private BaseUI _pauseUI;

    private SkillButton[] _skillButtons;

    // 한 스테이지당 3분
    private int CurrentTime = 0;
    private Coroutine _coUpdate = null;

    private float _targetGauge;
    private float _currentGague = 0;

    private float[] speedValues = new float[] { 1.0f, 1.2f, 1.5f };
    private int _speedIndex;
    private int SpeedIndex
    {
        get { return _speedIndex; }
        set
        {
            _speedIndex = value;

            if (_speedIndex >= speedValues.Length)
                _speedIndex = 0;

            if (_speedIndex != 0)
            {
                _battleSpeedButtonActive.SetActive(true);
                _battleSpeedText.color = _activeColor;
            }
            else
            {
                _battleSpeedButtonActive.SetActive(false);
                _battleSpeedText.color = _inActiveColor;
            }

            Time.timeScale = speedValues[_speedIndex];
            _battleSpeedText.text = "x" + speedValues[_speedIndex].ToString("F1");
        }
    }

    private bool _isAutoMode = false;
    private bool IsAutoMode
    {
        get { return _isAutoMode; }
        set
        {
            _isAutoMode = value;

            if(_isAutoMode)
            {
                _autoBattleText.color = _activeColor;
                _autoBattleButtonActive.SetActive(true);
            }
            else
            {
                _autoBattleText.color = _inActiveColor;
                _autoBattleButtonActive.SetActive(false);
            }
        }
    }

    public override void Show()
    {
        base.Show();
        CurrentTime = 180;

        _timeText.text = Utils.GetTimeText(CurrentTime, false);

        if (_coUpdate != null)
            StopCoroutine(_coUpdate);
        _coUpdate = StartCoroutine(CoUpdate());
    }

    public override void Hide()
    {
        if (_coUpdate != null)
            StopCoroutine(_coUpdate);

        base.Hide();
    }

    // 전투가 끝나면 BattleUI는 비활성화 되니까 이건 실행안돼
    private void Update()
    {
        _currentGague = Mathf.Lerp(_currentGague, _targetGauge, Time.deltaTime);
        _battleGague.sizeDelta = new Vector2(_currentGague, _battleGague.sizeDelta.y);
    }

    public void SetBattleGauge(float ratio)
    {
        _targetGauge = 30 + 370 * ratio;
        _targetGauge = Mathf.Clamp(_targetGauge, 30, 400);
    }

    public void Init()
    {
        // 스킬 버튼 초기화
        List<BaseController> cookies = BattleManager.instance.Cookies;
        _skillButtons = new SkillButton[cookies.Count];
        for (int i = 0; i < cookies.Count; i++)
        {
            SkillButton skillButton = Instantiate(_skillButtonPrefab, _skillButtonParent);
            skillButton.Init(cookies[i]);
            _skillButtons[i] = skillButton;
        }

        // 모험 게이지 초기화
        _currentGague = 0f;
        SetBattleGauge(0);

        // 전투 속도 버튼 초기화
        SpeedIndex = 0;
        _battleSpeedButton.onClick.AddListener(() => SpeedIndex++);

        // 자동 전투 버튼 초기화
        _autoBattleButton.onClick.AddListener(() => IsAutoMode = IsAutoMode ? false : true);
    }

    private IEnumerator CoUpdate()
    {
        WaitForSeconds wait = new WaitForSeconds(1f);

        while(true)
        {
            yield return wait;
            _timeText.text = Utils.GetTimeText(--CurrentTime, false);

            // 자동 모드일 경우 1초마다 스킬을 굴림
            if(IsAutoMode)
            {
                for(int i = 0; i < _skillButtons.Length; i++)
                {
                    if(_skillButtons[i].IsReadyToUse())
                    {
                        _skillButtons[i].OnClickButton();
                        break;
                    }
                }
            }
        }
    }

    public void Pause()
    {
        GameManager.UI.ShowPopUpUI(_pauseUI);
        Time.timeScale = 0;
    }

    public void Continue()
    {
        Time.timeScale = 1;
        GameManager.UI.ExitPopUpUI();
    }
}
