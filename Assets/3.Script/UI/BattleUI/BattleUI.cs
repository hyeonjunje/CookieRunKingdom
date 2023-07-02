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

    [Header("Buttons")]
    [SerializeField] private Button _battleSpeedButton;
    [SerializeField] private Button _autoBattleButton;
    [SerializeField] private Button _pauseButton;

    [SerializeField] private TextMeshProUGUI _battleSpeedText;
    [SerializeField] private RectTransform _battleGague;

    [Header("Time")]
    [SerializeField] private TextMeshProUGUI _timeText;

    [Header("UI")]
    [SerializeField] private BaseUI _pauseUI;

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

            Time.timeScale = speedValues[_speedIndex];
            _battleSpeedText.text = "x" + speedValues[_speedIndex].ToString("F1");
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

    private void Start()
    {
        Init();
    }
    
    // 전투가 끝나면 BattleUI는 비활성화 되니까 이건 실행안돼
    private void Update()
    {
        /*_battleGague.sizeDelta += new Vector2(5 * Time.deltaTime, 0);
        Debug.Log(_battleGague.sizeDelta.x + " 입니다.");*/

        _currentGague = Mathf.Lerp(_currentGague, _targetGauge, Time.deltaTime);
        _battleGague.sizeDelta = new Vector2(_currentGague, _battleGague.sizeDelta.y);
    }

    public void SetBattleGauge(float ratio)
    {
        _targetGauge = 30 + 370 * ratio;
        _targetGauge = Mathf.Clamp(_targetGauge, 30, 400);
    }

    private void Init()
    {
        List<BaseController> cookies = BattleManager.instance.Cookies;

        for(int i = 0; i < cookies.Count; i++)
        {
            SkillButton skillButton = Instantiate(_skillButtonPrefab, _skillButtonParent);
            skillButton.Init(cookies[i]);
        }

        _currentGague = 0f;
        SetBattleGauge(0);
        SpeedIndex = 0;
        _battleSpeedButton.onClick.AddListener(() => SpeedIndex++);
    }

    private IEnumerator CoUpdate()
    {
        WaitForSeconds wait = new WaitForSeconds(1f);

        while(true)
        {
            yield return wait;
            _timeText.text = Utils.GetTimeText(--CurrentTime, false);
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
