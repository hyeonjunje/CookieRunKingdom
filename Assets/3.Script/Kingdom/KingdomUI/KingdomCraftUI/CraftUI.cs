using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CraftUI : BaseUI
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
        int index = -1;

        for(int i = 0; i < currentBuilding.CraftingItemData.Count; i++)
        {
            if(currentBuilding.CraftingItemData[i].craftData == null)
            {
                index = i;
                break;
            }
        }

        if (index == -1)
        {
            Debug.Log("대기열이 꽉 찼습니다.");
            return;
        }

        // 처음 만드는 거라면
        if(index == 0)
        {
            currentBuilding.CraftingItemData[index] = new CraftingItemData(ECraftingState.making, craftData);
            craftProgressBar.SetActive(true);
            craftProgressBar.transform.SetParent(craftList[index].transform, false);
        }
        else
            currentBuilding.CraftingItemData[index] = new CraftingItemData(ECraftingState.waiting, craftData);
        craftList[index].UpdateCraft(currentBuilding.CraftingItemData[index]);
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
        for (int i = 0; i < currentBuilding.CraftingItemData.Count; i++)
        {
            if (currentBuilding.CraftingItemData[i].craftData == null)
                return;

            // 만들고 있다면
            if (currentBuilding.CraftingItemData[i].state == ECraftingState.making)
            {
                // 1초씩 더해준다.
                currentBuilding.CraftingItemData[i].takingTime += 1;
                craftProgressTime.text = Utils.GetTimeText(currentBuilding.CraftingItemData[i].craftData.CraftTime - currentBuilding.CraftingItemData[i].takingTime);

                // 만약 다 만들었다면
                if (currentBuilding.CraftingItemData[i].takingTime >= currentBuilding.CraftingItemData[i].craftData.CraftTime)
                {
                    currentBuilding.CraftingItemData[i].state = ECraftingState.complete;
                    if (i + 1 < currentBuilding.CraftingItemData.Count && currentBuilding.CraftingItemData[i + 1].craftData != null &&
                        currentBuilding.CraftingItemData[i + 1].state == ECraftingState.waiting)
                    {
                        currentBuilding.CraftingItemData[i + 1].state = ECraftingState.making;
                        craftProgressBar.transform.SetParent(craftList[i + 1].transform, false);
                    }
                    else
                    {
                        craftProgressBar.SetActive(false);
                        craftProgressBar.transform.SetParent(transform, false);
                    }
                }
            }

            craftList[i].UpdateCraft(currentBuilding.CraftingItemData[i]);
        }
    }
}
