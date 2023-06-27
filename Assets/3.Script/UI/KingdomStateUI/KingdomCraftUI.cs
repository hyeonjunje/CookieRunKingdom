using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class KingdomCraftUI: BaseUI
{
    [Header("Right")]
    [SerializeField] private Transform craftTypeParent;
    [SerializeField] private CraftTypeProductUI craftTypeProductPrefab;
    [SerializeField] private CraftTypeResourceUI craftTypeResourcePrefab;

    [Header("Left")]
    [SerializeField] private Transform craftItemParent;
    [SerializeField] private CraftingItemUI craftItemPrefab;
    [SerializeField] private GameObject craftProgressBar;
    [SerializeField] private TextMeshProUGUI craftProgressTime;

    [Header("Center")]
    [SerializeField] private TextMeshProUGUI buildingName;
    [SerializeField] private TextMeshProUGUI buildingLevel;
    [SerializeField] private Button levelUpButton;
    [SerializeField] private Button selectCookieButton;
    [SerializeField] private Button leftArrow;
    [SerializeField] private Button rightArrow;

    private Building currentBuilding;
    private List<CraftingItemUI> craftList = new List<CraftingItemUI>();

    private void OnEnable()
    {
        StopAllCoroutines();
        StartCoroutine(CoSecond());
    }

    public void SetCraft(Building building)
    {
        currentBuilding = building;

        // center
        buildingName.text = building.Data.BuildingName;

        // right
        craftTypeParent.DestroyAllChild();

        RectTransform parentTransform = craftTypeParent.GetComponent<RectTransform>();
        RectTransform craftTypePrefabTransform = craftTypeProductPrefab.GetComponent<RectTransform>();
        parentTransform.sizeDelta = new Vector2(parentTransform.sizeDelta.x
            , (craftTypePrefabTransform.sizeDelta.y + 10) * building.Data.CraftItems.Length);

        for (int i = 0; i < building.Data.CraftItems.Length; i++)
        {
            CraftTypeUI craftTypeUI = null;

            if (building.Data.CraftItems[i].IsResource)
                craftTypeUI = Instantiate(craftTypeResourcePrefab, craftTypeParent);
            else
                craftTypeUI = Instantiate(craftTypeProductPrefab, craftTypeParent);

            craftTypeUI.Init(building.Data.CraftItems[i], CraftItem);
        }

        craftProgressBar.transform.SetParent(transform, false);
        craftProgressBar.SetActive(false);
        // left
        craftItemParent.DestroyAllChild();
        craftList = new List<CraftingItemUI>();
        for (int i = 0; i < building.CraftingItemData.Count; i++)
        {
            CraftingItemUI craftingItemUI = Instantiate(craftItemPrefab, craftItemParent);
            craftList.Add(craftingItemUI);

            craftingItemUI.InitCraft();
            craftingItemUI.UpdateCraft(building.CraftingItemData[i]);

            if(building.CraftingItemData[i].state == ECraftingState.making)
            {
                craftProgressBar.SetActive(true);
                craftProgressBar.transform.SetParent(craftList[i].transform, false);
            }
        }
    }

    private void CraftItem(CraftData craftData)
    {
        int emptyIndex = -1;
        // 만들 곳
        for(int i = 0; i < currentBuilding.CraftingItemData.Count; i++)
        {
            if(currentBuilding.CraftingItemData[i].state == ECraftingState.empty)
            {
                emptyIndex = i;
                break;
            }
        }

        int makingIndex = 0;
        for(int i = 0; i < currentBuilding.CraftingItemData.Count; i++)
            if(currentBuilding.CraftingItemData[i].state == ECraftingState.complete)
                makingIndex = i + 1;

        if (emptyIndex == -1)
        {
            Debug.Log("대기열이 꽉 찼습니다.");
            return;
        }

        // 처음 만드는 거라면
        if(emptyIndex == makingIndex)
        {
            currentBuilding.CraftingItemData[emptyIndex] = new CraftingItemData(ECraftingState.making, craftData);
            craftProgressBar.SetActive(true);
            craftProgressBar.transform.SetParent(craftList[emptyIndex].transform, false);
        }
        else
            currentBuilding.CraftingItemData[emptyIndex] = new CraftingItemData(ECraftingState.waiting, craftData);

        craftList[emptyIndex].UpdateCraft(currentBuilding.CraftingItemData[emptyIndex]);
    }


    // 1초마다 생산품을 갱신한다.
    private IEnumerator CoSecond()
    {
        WaitForSecondsRealtime second = new WaitForSecondsRealtime(1f);

        while (true)
        {
            yield return second;
            ManageCraftingItemData();
        }
    }

    private void ManageCraftingItemData()
    {
        // 만들고 있는게 없다면
        bool isMaking = false;
        for(int i = 0; i < currentBuilding.CraftingItemData.Count; i++)
        {
            if(currentBuilding.CraftingItemData[i].state == ECraftingState.making)
            {
                isMaking = true;
                break;
            }
        }
        if(!isMaking)
        {
            craftProgressBar.transform.SetParent(transform, false);
            craftProgressBar.SetActive(false);
        }


        for (int i = 0; i < currentBuilding.CraftingItemData.Count; i++)
        {
            if (currentBuilding.CraftingItemData[i].craftData == null)
                return;

            // 만들고 있다면  progressbar 갱신
            if (currentBuilding.CraftingItemData[i].state == ECraftingState.making)
            {
                if(!craftProgressBar.transform.parent.Equals(craftList[i]))
                {
                    craftProgressBar.SetActive(true);
                    craftProgressBar.transform.SetParent(craftList[i].transform, false);
                }

                craftProgressTime.text = Utils.GetTimeText(currentBuilding.CraftingItemData[i].craftData.CraftTime - currentBuilding.CraftingItemData[i].takingTime);
            }

            craftList[i].UpdateCraft(currentBuilding.CraftingItemData[i]);
        }
    }
}
