using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class ItemSlot : MonoBehaviour
{
    [SerializeField] private GameObject itemUI;
    [SerializeField] private Image itemImage;
    [SerializeField] private TextMeshProUGUI itemCountText;

    public void FillSlot(ItemData item, int count)
    {
        itemUI.SetActive(true);

        itemImage.sprite = item.ItemImage;
        itemCountText.text = count.ToString();
    }

    public void ClearSlot()
    {
        itemUI.SetActive(false);
    }
}
