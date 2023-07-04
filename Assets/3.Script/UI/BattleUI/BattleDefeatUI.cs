using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;

public class BattleDefeatUI : BaseUI
{
    [SerializeField] private CookieBattleAward _award;

    [SerializeField] private GameObject _touchText;
    [SerializeField] private GameObject _buttons;

    [Header("UI")]
    [SerializeField] private Button _nextStageButton;
    [SerializeField] private Button _exitButton;
    [SerializeField] private Button _reStartButton;
    [SerializeField] private Button _goKingdomButtom;

    private bool _isGainReward = false;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Show()
    {
        base.Show();
        _isGainReward = false;
        _touchText.SetActive(true);
        _buttons.SetActive(false);
    }

    public override void Init()
    {
        base.Init();

        _award.ShowResult();

        _nextStageButton.onClick.AddListener(OnClickNextStageButton);
        _exitButton.onClick.AddListener(OnClickExitButton);
        _reStartButton.onClick.AddListener(OnClickReStartButton);
        _goKingdomButtom.onClick.AddListener(OnClickGoKingdomButton);
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        if(value.started)
        {
            if (_isGainReward) return;

            _isGainReward = true;

            _touchText.SetActive(false);
            _buttons.SetActive(true);
        }
    }

    private void OnClickNextStageButton()
    {
        GameManager.Game.StartKingdomState = EKingdomState.Adventure;
        GameManager.Scene.LoadScene(ESceneName.Kingdom);
    }

    private void OnClickExitButton()
    {
        GameManager.Game.StartKingdomState = EKingdomState.Adventure;
        GameManager.Scene.LoadScene(ESceneName.Kingdom);
    }

    private void OnClickReStartButton()
    {
        GameManager.Scene.LoadScene(ESceneName.Battle);
    }

    private void OnClickGoKingdomButton()
    {
        GameManager.Game.StartKingdomState = EKingdomState.Manage;
        GameManager.Scene.LoadScene(ESceneName.Kingdom);
    }
}
