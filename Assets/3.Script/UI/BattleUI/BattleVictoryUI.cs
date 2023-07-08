using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;

public class BattleVictoryUI : BaseUI
{
    [SerializeField] private CookieBattleAward _award;

    [SerializeField] private GameObject _touchText;
    [SerializeField] private GameObject _buttons;

    [Header("UI")]
    [SerializeField] private Button _nextStageButton;
    [SerializeField] private Button _exitButton;
    [SerializeField] private Button _reStartButton;
    [SerializeField] private Button _goKingdomButtom;
    [SerializeField] private TextMeshProUGUI _restartJellyCount;

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

        _restartJellyCount.text = (-GameManager.Game.StageData.Jelly).ToString();

        // 여기서 젤리계산
        CalculateJelly();
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
        if(GameManager.Game.Jelly >= GameManager.Game.StageData.Jelly)
        {
            GameManager.Game.Jelly -= GameManager.Game.StageData.Jelly;
            GameManager.Scene.LoadScene(ESceneName.Battle);
        }
        else
        {
            Debug.Log("젤리가 모자랍니다.");
        }
    }

    private void OnClickGoKingdomButton()
    {
        GameManager.Game.StartKingdomState = EKingdomState.Manage;
        GameManager.Scene.LoadScene(ESceneName.Kingdom);
    }

    private void CalculateJelly()
    {
        int diffTime = (int)((System.DateTime.Now - GameManager.Game.prevJellyTime).TotalSeconds);

        if (diffTime >= GameManager.Game.jellyTime)
        {
            diffTime -= GameManager.Game.jellyTime;
            int count = diffTime / Utils.JellyTime;
            GameManager.Game.Jelly += 1 + count;
            GameManager.Game.jellyTime = diffTime % Utils.JellyTime;
        }
        else
        {
            GameManager.Game.jellyTime -= diffTime;
        }

        if (GameManager.Game.Jelly < GameManager.Game.MaxJelly)
        {
            StartCoroutine(CoUpdate());
        }
    }

    private IEnumerator CoUpdate()
    {
        WaitForSeconds wait = new WaitForSeconds(1f);

        while (true)
        {
            yield return wait;
            GameManager.Game.jellyTime--;

            if (GameManager.Game.jellyTime <= 0)
            {
                GameManager.Game.Jelly++;
                GameManager.Game.jellyTime = Utils.JellyTime;
                if (GameManager.Game.Jelly >= GameManager.Game.MaxJelly)
                    break;
            }
        }
    }
}
