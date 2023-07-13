using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;

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
    [SerializeField] private TextMeshProUGUI _restartJellyCount;

    [Header("Prefab")]
    [SerializeField] private RectTransform _rewardParent;
    [SerializeField] private ItemSlot _itemSlotPrefab;

    private float _itemSlotSizeX;
    private bool _isGainReward = false;

    private StageData _stageData;

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

        // 보상 보여주자
        _rewardParent.DestroyAllChild();
        ItemBundle[] rewards = _stageData.DefeatRewardItems;
        for (int i = 0; i < rewards.Length; i++)
        {
            ItemSlot slot = Instantiate(_itemSlotPrefab, _rewardParent);
            slot.FillSlot(rewards[i].ingredientItem, rewards[i].count);
            DataBaseManager.Instance.AddItem(rewards[i].ingredientItem, rewards[i].count);
        }
        _rewardParent.anchoredPosition = -(Vector3.right * (_itemSlotSizeX + 10) * rewards.Length * 0.5f);
    }

    public override void Init()
    {
        base.Init();

        _stageData = BattleManager.instance.StageData;
        _itemSlotSizeX = _itemSlotPrefab.GetComponent<RectTransform>().sizeDelta.x;

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
        if (GameManager.Game.Jelly >= GameManager.Game.StageData.Jelly)
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
