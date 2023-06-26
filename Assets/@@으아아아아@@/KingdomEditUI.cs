using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using DG.Tweening;

public class KingdomEditUI : BaseUI
{
    [Header("RightTop")]
    public int i;

    [Header("LeftTop")]
    public int h;

    [Header("Bottom")]
    [SerializeField] private Transform editInventory;
    [SerializeField] private Button foldButton;
    [SerializeField] private Transform foldButtonImage;
    [SerializeField] private GameObject editSelected;
    [SerializeField] private Image editItemImage;
    [SerializeField] private TextMeshProUGUI editItemNameText;
    [SerializeField] private Button editExitButton;
    [SerializeField] private Button editCheckButton;

    [SerializeField] private Transform editItemParent;
    [SerializeField] private Button editItemPrefab;

    [Header("Tile")]
    [SerializeField] private HousingItemData[] allTiles;

    private bool isBottomHide;
    private HousingItemData currentHousingItemData;
    private bool isInit = false;

    public HousingItemData CurrentHousingItemData => currentHousingItemData; 

    public override void Show()
    {
        if (!isInit)
            IsInit();

        base.Show();
    }

    private void IsInit()
    {
        foldButton.onClick.AddListener(OnClickFoldButton);

        for(int i = 0; i < allTiles.Length; i++)
        {
            int index = i;
            Button editItemButton = Instantiate(editItemPrefab, editItemParent);
            editItemButton.image.sprite = allTiles[i].HousingItemImage;
            editItemButton.onClick.AddListener(() => OnClickEditItemButton(allTiles[index]));
        }

        editExitButton.onClick.AddListener(OnClickEditExitButton);
    }

    private void OnClickEditExitButton()
    {
        this.currentHousingItemData = null;

        editInventory.gameObject.SetActive(true);
        editSelected.gameObject.SetActive(false);
    }

    private void OnClickEditItemButton(HousingItemData currentHousingItemData)
    {
        editInventory.gameObject.SetActive(false);
        editSelected.gameObject.SetActive(true);

        this.currentHousingItemData = currentHousingItemData;

        editItemImage.sprite = currentHousingItemData.HousingItemImage;
        editItemNameText.text = currentHousingItemData.HousingItemName;
    }

    private void OnClickFoldButton()
    {
        isBottomHide = !isBottomHide;

        if (isBottomHide)
        {
            editInventory.DOMoveY(editInventory.position.y - 126, 0.3f);
            foldButtonImage.rotation = Quaternion.identity;
        }
        else
        {
            editInventory.DOMoveY(editInventory.position.y + 126, 0.3f);
            foldButtonImage.rotation = Quaternion.Euler(Vector3.forward * 180f);
        }
    }
}
