using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class BattleUI : BaseUI
{
    [Header("Cookie Skill UI")]
    [SerializeField] private Transform _skillButtonParent;
    [SerializeField] private SkillButton _skillButtonPrefab;

    [Header("Buttons")]
    [SerializeField] private Button _battleSpeedButton;
    [SerializeField] private Button _autoBattleButton;
    [SerializeField] private Button _pauseButton;

    [Header("Time")]
    [SerializeField] private TextMeshProUGUI _timeText;

    // 한 스테이지당 3분
    private int CurrentTime = 0;
    private Coroutine _coUpdate = null;

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
}
