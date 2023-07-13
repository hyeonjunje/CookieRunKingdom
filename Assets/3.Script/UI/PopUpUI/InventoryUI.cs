using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InventoryUI : BaseUI
{
    [SerializeField] private ItemData _emptyItemData;
    [SerializeField] private ItemSlot itemSlot;
    [SerializeField] private RectTransform itemSlotParent;

    public int maxSlot = 80;

    private List<ItemSlot> inventoryItems = new List<ItemSlot>();

    private KingdomManager _manager;

    public override void Hide()
    {
        base.Hide();
        _manager.IsMoveCamera = true;
    }

    public override void Show()
    {
        base.Show();
        _manager.IsMoveCamera = false;
        UpdateInventory();
    }

    public void ExpandCapacity(int amount)
    {
        for(int i = 0; i < amount; i++)
        {
            ItemSlot slot = Instantiate(itemSlot, itemSlotParent);
            inventoryItems.Add(slot);
            slot.ClearSlot();
        }
    }

    public void ExitUI()
    {
        GameManager.UI.ExitPopUpUI();
    }

    public override void Init()
    {
        base.Init();

        _manager = FindObjectOfType<KingdomManager>();

        itemSlotParent.sizeDelta = new Vector2(itemSlotParent.sizeDelta.x, 30 + (165 + 30) * (maxSlot / 8));

        // 초기화
        for (int i = 0; i < maxSlot; i++)
        {
            ItemSlot slot = Instantiate(itemSlot, itemSlotParent);
            inventoryItems.Add(slot);
            inventoryItems[i].FillSlot(_emptyItemData, 0);
            slot.ClearSlot();
        }

        // 데이터베이스에서 가져와서 인벤토리에 적용해줘..
    }

    private void UpdateInventory()
    {
        // 데이터베이스에서 가져와서 인벤토리에 적용해줘..

        // Test
        int index = 0;
        foreach (KeyValuePair<ItemData, int> data in DataBaseManager.Instance.MyDataBase.itemDataBase)
        {
            inventoryItems[index++].FillSlot(data.Key, data.Value);
        }

        inventoryItems.Sort((item1, item2) => (item1.Data.ItemType).CompareTo(item2.Data.ItemType));
        for(int i = 0; i < inventoryItems.Count; i++)
        {
            inventoryItems[i].transform.SetSiblingIndex(i);
        }
    }
}
