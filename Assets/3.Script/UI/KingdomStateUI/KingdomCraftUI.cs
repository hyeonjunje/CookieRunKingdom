using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class KingdomCraftUI: BaseUI
{
    [Header("Top")]
    [SerializeField] private TextMeshProUGUI _diaText;
    [SerializeField] private TextMeshProUGUI _moneyText;

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

    [Header("SelectCookie")]
    [SerializeField] private CraftCookieSelectUI _craftCookieSelectUI;

    private Camera _camera;
    private KingdomManager _kingdomManager;
    private BuildingController _currentBuilding;
    private List<CraftingItemUI> _craftList = new List<CraftingItemUI>();


    private int _buildingIndex;
    private int BuildingIndex
    {
        get { return _buildingIndex; }
        set
        {
            _buildingIndex = value;

            if(_buildingIndex < 0)
                _buildingIndex = _kingdomManager.buildingsInKingdom.Count - 1;
            else if(_buildingIndex >= _kingdomManager.buildingsInKingdom.Count)
                _buildingIndex = 0;

            _currentBuilding.BuildingWorker.Highlight(false);
            _currentBuilding = _kingdomManager.buildingsInKingdom[_buildingIndex];
            _currentBuilding.BuildingWorker.Highlight(true);

            _camera.transform.position = _currentBuilding.transform.position +
                _kingdomManager.CurrentCameraControllerData.CameraBuildingZoomOffset;

            // ī�޶� �Űܾ� �ϳ�??
            SetCraft(_kingdomManager.buildingsInKingdom[_buildingIndex]);
        }
    }

    private void OnEnable()
    {
        StartCoroutine(CoSecond());
    }

    private void OnDisable()
    {
        StopAllCoroutines();
    }

    public override void Hide()
    {
        base.Hide();
    }

    public override void Show()
    {
        base.Show();
    }

    public override void Init()
    {
        base.Init();

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeMoney += (() => _moneyText.text = GameManager.Game.Money.ToString("#,##0"));
        GameManager.Game.UpdateGoods();

        _camera = Camera.main;

        selectCookieButton.onClick.AddListener(() =>
        {
            GameManager.UI.ShowPopUpUI(_craftCookieSelectUI);
            _craftCookieSelectUI.changeWorkerAction = (cookie) =>
            {
                _currentBuilding.BuildingWorker.Worker.CookieCitizeon.LeaveWork();
                _currentBuilding.BuildingWorker.ChangeWorker(cookie);
            };
        });

        leftArrow.onClick.AddListener(() => BuildingIndex--);
        rightArrow.onClick.AddListener(() => BuildingIndex++);
    }

    // ������ ���� UI�� �����ȴ�.
    public void SetCraft(BuildingController building)
    {
        _currentBuilding = building;

        if(_kingdomManager == null)
            _kingdomManager = FindObjectOfType<KingdomManager>();

        for (int i = 0; i < _kingdomManager.buildingsInKingdom.Count; i++)
        {
            if(_currentBuilding.Data.BuildingName == _kingdomManager.buildingsInKingdom[i].Data.BuildingName)
            {
                _buildingIndex = i;
                break;
            }
        }

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

            craftTypeUI.Init(building, building.Data.CraftItems[i], CraftItem);
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

                craftProgressTime.text = Utils.GetTimeText(_currentBuilding.BuildingWorker.CraftingItemData[i].craftData.CraftTime
                    - _currentBuilding.BuildingWorker.CraftingItemData[i].takingTime);
            }
        }
    }

    // ������ ����� �޼ҵ�
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
            GuideDisplayer.Instance.ShowGuide("��⿭�� �� á���ϴ�.");
            return;
        }

        // ��� Ȯ��
        if(craftData.IsResource)
        {
            if(GameManager.Game.Money < craftData.CraftCost)
            {
                GuideDisplayer.Instance.ShowGuide("��ȭ�� �����մϴ�.");
                return;
            }
            else
            {
                GameManager.Game.Money -= craftData.CraftCost;
            }
        }
        else
        {
            // ��ᰡ ���ٸ� ���⼭ ����
            for (int i = 0; i < craftData.Ingredients.Length; i++)
            {
                if(DataBaseManager.Instance.MyDataBase.itemDataBase[craftData.Ingredients[i].ingredientItem] < craftData.Ingredients[i].count)
                {
                    GuideDisplayer.Instance.ShowGuide("��ᰡ �����մϴ�.");
                    return;
                }
            }

            // ��ᰡ �ִٸ� �׸�ŭ �Ҹ��ϰ� ����
            for (int i = 0; i < craftData.Ingredients.Length; i++)
                DataBaseManager.Instance.AddItem(craftData.Ingredients[i].ingredientItem, -craftData.Ingredients[i].count);
        }


        _currentBuilding.BuildingWorker.isWorking = true;

        int makingIndex = 0;
        for(int i = 0; i < _currentBuilding.BuildingWorker.CraftingItemData.Count; i++)
            if(_currentBuilding.BuildingWorker.CraftingItemData[i].state == ECraftingState.complete)
                makingIndex = i + 1;

        // ó�� ����� �Ŷ��
        if(emptyIndex == makingIndex)
        {
            _currentBuilding.BuildingWorker.SelectedWorker();

            _currentBuilding.BuildingWorker.CraftingItemData[emptyIndex] = new CraftingItemData(ECraftingState.making, craftData);
            craftProgressBar.SetActive(true);
            craftProgressBar.transform.SetParent(_craftList[emptyIndex].transform, false);

            craftProgressTime.text = Utils.GetTimeText(_currentBuilding.BuildingWorker.CraftingItemData[emptyIndex].craftData.CraftTime
                    - _currentBuilding.BuildingWorker.CraftingItemData[emptyIndex].takingTime);
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

             _craftList[i].UpdateCraft(_currentBuilding.BuildingWorker.CraftingItemData[i]);

            // ����� �ִٸ�  progressbar ����
            if (_currentBuilding.BuildingWorker.CraftingItemData[i].state == ECraftingState.making)
            {
                if (!craftProgressBar.transform.parent.Equals(_craftList[i]))
                {
                    craftProgressBar.SetActive(true);
                    craftProgressBar.transform.SetParent(_craftList[i].transform, false);
                }

                craftProgressTime.text = Utils.GetTimeText(_currentBuilding.BuildingWorker.CraftingItemData[i].craftData.CraftTime 
                    - _currentBuilding.BuildingWorker.CraftingItemData[i].takingTime);
            }
        }
    }
}
