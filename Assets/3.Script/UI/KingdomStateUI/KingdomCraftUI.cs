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

    private BuildingController _currentBuilding;
    private List<CraftingItemUI> _craftList = new List<CraftingItemUI>();

    private void OnEnable()
    {
        StopAllCoroutines();
        StartCoroutine(CoSecond());
    }

    public void SetCraft(BuildingController building)
    {
        _currentBuilding = building;

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
        _craftList = new List<CraftingItemUI>();
        for (int i = 0; i < building.BuildingWorker.CraftingItemData.Count; i++)
        {
            CraftingItemUI craftingItemUI = Instantiate(craftItemPrefab, craftItemParent);
            _craftList.Add(craftingItemUI);

            craftingItemUI.InitCraft();
            craftingItemUI.UpdateCraft(building.BuildingWorker.CraftingItemData[i]);

            if(building.BuildingWorker.CraftingItemData[i].state == ECraftingState.making)
            {
                craftProgressBar.SetActive(true);
                craftProgressBar.transform.SetParent(_craftList[i].transform, false);
            }
        }
    }

    private void CraftItem(CraftData craftData)
    {
        if(!_currentBuilding.BuildingAnimator.IsAnimationExist("working"))
            _currentBuilding.BuildingAnimator.PlayAnimation("loop_back");
        else
            _currentBuilding.BuildingAnimator.PlayAnimation("working");

        int emptyIndex = -1;
        // ���� ��
        for(int i = 0; i < _currentBuilding.BuildingWorker.CraftingItemData.Count; i++)
        {
            if(_currentBuilding.BuildingWorker.CraftingItemData[i].state == ECraftingState.empty)
            {
                emptyIndex = i;
                break;
            }
        }

        if (emptyIndex == -1)
        {
            Debug.Log("��⿭�� �� á���ϴ�.");
            return;
        }

        int makingIndex = 0;
        for(int i = 0; i < _currentBuilding.BuildingWorker.CraftingItemData.Count; i++)
            if(_currentBuilding.BuildingWorker.CraftingItemData[i].state == ECraftingState.complete)
                makingIndex = i + 1;

        // ó�� ����� �Ŷ��
        if(emptyIndex == makingIndex)
        {
            Debug.Log("�����ƾƾƾƾƤ��� �̰� ���߿� �ض�ƶ��");
            _currentBuilding.BuildingWorker.SelectedWorker();

            _currentBuilding.BuildingWorker.CraftingItemData[emptyIndex] = new CraftingItemData(ECraftingState.making, craftData);
            craftProgressBar.SetActive(true);
            craftProgressBar.transform.SetParent(_craftList[emptyIndex].transform, false);
        }
        else
            _currentBuilding.BuildingWorker.CraftingItemData[emptyIndex] = new CraftingItemData(ECraftingState.waiting, craftData);

        _craftList[emptyIndex].UpdateCraft(_currentBuilding.BuildingWorker.CraftingItemData[emptyIndex]);
    }


    // 1�ʸ��� ����ǰ�� �����Ѵ�.
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
        // ����� �ִ°� ���ٸ�
        bool isMaking = false;
        for(int i = 0; i < _currentBuilding.BuildingWorker.CraftingItemData.Count; i++)
        {
            if(_currentBuilding.BuildingWorker.CraftingItemData[i].state == ECraftingState.making)
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


        for (int i = 0; i < _currentBuilding.BuildingWorker.CraftingItemData.Count; i++)
        {
            if (_currentBuilding.BuildingWorker.CraftingItemData[i].craftData == null)
                return;

            // ����� �ִٸ�  progressbar ����
            if (_currentBuilding.BuildingWorker.CraftingItemData[i].state == ECraftingState.making)
            {
                if(!craftProgressBar.transform.parent.Equals(_craftList[i]))
                {
                    craftProgressBar.SetActive(true);
                    craftProgressBar.transform.SetParent(_craftList[i].transform, false);
                }

                craftProgressTime.text = Utils.GetTimeText(_currentBuilding.BuildingWorker.CraftingItemData[i].craftData.CraftTime 
                    - _currentBuilding.BuildingWorker.CraftingItemData[i].takingTime);
            }

            _craftList[i].UpdateCraft(_currentBuilding.BuildingWorker.CraftingItemData[i]);
        }
    }
}
