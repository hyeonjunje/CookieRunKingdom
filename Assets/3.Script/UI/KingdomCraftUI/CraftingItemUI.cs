using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public enum ECraftingState
{
    empty, waiting, making, complete
}

[System.Serializable]
public class CraftingItemData
{
    public ECraftingState state = ECraftingState.empty;
    public CraftData craftData = null;
    public int takingTime = 0;

    public CraftingItemData(ECraftingState state, CraftData craftData)
    {
        this.state = state;
        this.craftData = craftData;
        takingTime = 0;
    }
}

public class CraftingItemUI : MonoBehaviour
{
    [SerializeField] private GameObject craftingItemParent;
    [SerializeField] private Image craftingItemImage;
    [SerializeField] private GameObject checkImage;

    private ECraftingState state = ECraftingState.empty;

    public void InitCraft()
    {
        state = ECraftingState.empty;
        craftingItemParent.SetActive(false);
        checkImage.SetActive(false);
    }

    // �ձ��� ���� ���� 1�ʸ��� �ϴ°Ͱ���...
    public void UpdateCraft(CraftingItemData craftingItemData)
    {
        // ���� ���¿� �ٸ���
        if (state != craftingItemData.state)
        {
            ExitState(state, craftingItemData);
            state = craftingItemData.state;
            EnterState(state, craftingItemData);
        }
        else
        {
            UpdateState(state, craftingItemData);
            return;
        }
    }

    private void EnterState(ECraftingState state, CraftingItemData craftingItemData)
    {
        Debug.Log(state + "  " + craftingItemData);
        Debug.Log(craftingItemData.craftData);
        Debug.Log(craftingItemData.craftData.CraftImage);

        switch (state)
        {
            case ECraftingState.empty:
                craftingItemParent.SetActive(false);
                break;
            case ECraftingState.waiting:
                craftingItemImage.sprite = craftingItemData.craftData.CraftImage;
                break;
            case ECraftingState.making:
                craftingItemImage.sprite = craftingItemData.craftData.CraftImage;
                // �ð�ǥ�� ����
                break;
            case ECraftingState.complete:
                craftingItemImage.sprite = craftingItemData.craftData.CraftImage;
                checkImage.SetActive(true);
                break;
        }
    }

    private void ExitState(ECraftingState state, CraftingItemData craftingItemData)
    {
        switch (state)
        {
            case ECraftingState.empty:
                craftingItemParent.SetActive(true);
                break;
            case ECraftingState.waiting:
                break;
            case ECraftingState.making:
                // �ð�ǥ�� ����
                break;
            case ECraftingState.complete:
                checkImage.SetActive(false);
                break;
        }
    }

    private void UpdateState(ECraftingState state, CraftingItemData craftingItemData)
    {
        switch (state)
        {
            case ECraftingState.waiting:
                // �ð�ǥ�� update��
                break;
        }
    }
}
