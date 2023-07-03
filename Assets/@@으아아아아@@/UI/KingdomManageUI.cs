using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class KingdomManageUI : BaseUI
{
    [Header("Buttons")]
    [SerializeField] private Button _myCookiesButton;
    [SerializeField] private Button _storageButton;
    [SerializeField] private Button _gachaButton;

    [Header("UI")]
    [SerializeField] private InventoryUI _inventoryUI;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Show()
    {
        base.Show();
    }

    public override void Init()
    {
        base.Init();

        // ��ư �ʱ�ȭ
        _storageButton.onClick.AddListener(() => GameManager.UI.ShowPopUpUI(_inventoryUI));
    }
}
