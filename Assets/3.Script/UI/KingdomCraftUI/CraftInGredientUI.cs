using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CraftInGredientUI : MonoBehaviour
{
    [SerializeField] private Image ingredientImage;
    [SerializeField] private TextMeshProUGUI ingredientAmount;

    public void Init(ItemBundle ingredientItem)
    {
        ingredientImage.sprite = ingredientItem.ingredientItem.ItemImage;
        ingredientAmount.text = ingredientItem.count.ToString();
    }
}
