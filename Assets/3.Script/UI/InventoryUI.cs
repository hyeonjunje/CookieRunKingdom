using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InventoryUI : BaseUI
{
    [SerializeField] private ItemSlot itemSlot;
    [SerializeField] private RectTransform itemSlotParent;

    public int maxSlot = 80;

    private List<ItemSlot> inventoryItems = new List<ItemSlot>();
    private bool isInit = false;

    public override void Show()
    {
        if (!isInit)
            IsInit();

        base.Show();

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

    private void IsInit()
    {
        isInit = true;

        itemSlotParent.sizeDelta = new Vector2(itemSlotParent.sizeDelta.x, 30 + (165 + 30) * (maxSlot / 8));

        // 초기화
        for (int i = 0; i < maxSlot; i++)
        {
            ItemSlot slot = Instantiate(itemSlot, itemSlotParent);
            inventoryItems.Add(slot);
            slot.ClearSlot();
        }

        // 데이터베이스에서 가져와서 인벤토리에 적용해줘..
    }

    private void UpdateInventory()
    {
        // 데이터베이스에서 가져와서 인벤토리에 적용해줘..

        // Test
        int index = 0;
        foreach (var data in DataBaseManager.Instance.MyDataBase.itemDataBase)
        {
            inventoryItems[index++].FillSlot(data.Key, data.Value);
        }
    }
}
