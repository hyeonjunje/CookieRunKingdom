using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CraftTypeUI : MonoBehaviour
{
    [SerializeField] private Image craftItemImage;
    [SerializeField] private TextMeshProUGUI craftItemName;

    public void Init(ItemData itemData)
    {
        craftItemImage.sprite = itemData.ItemImage;
        craftItemName.text = itemData.ItemName;
    }
}
