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
    [SerializeField] private Button _exitButton;
    [SerializeField] private Button _goKingdomButtom;

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

        GameManager.Sound.PlaySe(EBGM.victoryBattle);

        _isGainReward = false;
        _touchText.SetActive(true);
        _buttons.SetActive(false);

        // ���⼭ �������
        GameManager.Game.UpdateJellyTime();

        // ���� ��������
        _rewardParent.DestroyAllChild();
        ItemBundle[] rewards = _stageData.VictoryRewardItems;
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

        _exitButton.onClick.AddListener(OnClickExitButton);
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

    private void OnClickExitButton()
    {
        GameManager.Game.StartKingdomState = EKingdomState.Adventure;
        GameManager.Scene.LoadScene(ESceneName.Kingdom);
    }


    private void OnClickGoKingdomButton()
    {
        GameManager.Game.StartKingdomState = EKingdomState.Manage;
        GameManager.Scene.LoadScene(ESceneName.Kingdom);
    }
}
