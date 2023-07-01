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

    [Header("Time")]
    [SerializeField] private TextMeshProUGUI _timeText;

    [Header("UI")]
    [SerializeField] private BaseUI _pauseUI;

    // �� ���������� 3��
    private int CurrentTime = 0;
    private Coroutine _coUpdate = null;

    private float[] speedValues = new float[] { 1.0f, 1.2f, 1.5f };
    private int _speedIndex;
    private int SpeedIndex
    {
        get
        {
            return _speedIndex;
        }

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

    private void Init()
    {
        List<BaseController> cookies = BattleManager.instance.Cookies;

        for(int i = 0; i < cookies.Count; i++)
        {
            SkillButton skillButton = Instantiate(_skillButtonPrefab, _skillButtonParent);
            skillButton.Init(cookies[i]);
        }

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
        UIManager.instance.ShowPopUpUI(_pauseUI);
        Time.timeScale = 0;
    }

    public void Continue()
    {
        Time.timeScale = 1;
        UIManager.instance.ExitPopUpUI();
    }
}
