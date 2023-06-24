using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CraftTypeResourceUI : CraftTypeUI
{
    [SerializeField] private Image craftResultImage;
    [SerializeField] private TextMeshProUGUI craftResultAmount;
    [SerializeField] private TextMeshProUGUI craftCostText;

    public override void Init(CraftData craftData)
    {
        base.Init(craftData);

        craftResultImage.sprite = craftData.CraftResult.ingredientItem.ItemImage;
        craftResultAmount.text = craftData.CraftResult.count.ToString();
        craftCostText.text = craftData.CraftCost.ToString();
    }
}
