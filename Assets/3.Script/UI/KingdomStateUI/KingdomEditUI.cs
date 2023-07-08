using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using DG.Tweening;
using Spine.Unity;

public class KingdomEditUI : BaseUI
{
    [Header("RightTop")]
    public int i;

    [Header("LeftTop")]
    public int h;

    [Header("Bottom")]
    [SerializeField] private Transform editInventory;
    [SerializeField] private Button foldButton;
    [SerializeField] private GameObject editSelected;
    [SerializeField] private Image editItemImage;
    [SerializeField] private TextMeshProUGUI editItemNameText;
    [SerializeField] private Button editExitButton;
    [SerializeField] private Button editCheckButton;

    [Header("Prefabs")]
    [SerializeField] private Transform _buildingParent;
    [SerializeField] private RectTransform editItemParent;
    [SerializeField] private Button editItemPrefab;
    [SerializeField] private Button editItemSkeletonPrefab;

    [Header("Sprite")]
    [SerializeField] private Sprite _foldButtonOn;
    [SerializeField] private Sprite _foldButtonOff;

    private Camera _camera;
    private HousingItemData[] _allTiles;
    private HousingItemData _currentHousingItemData;
    private BuildingController[] _allBuildingData;

    private KingdomManager _kindomManager;
    private bool _isBottomHide;

    public BuildingController CurrentBuilding { get; set; }

    public bool IsSelected => _currentHousingItemData != null || CurrentBuilding != null; 
    public HousingItemData CurrentHousingItemData => _currentHousingItemData;


    public override void Show()
    {
        base.Show();
    }

    public override void Hide()
    {
        base.Hide();

        if (_isBottomHide)
            OnClickFoldButton();

        OnClickEditExitButton();
    }

    public override void Init()
    {
        base.Init();

        _camera = Camera.main;
        _kindomManager = FindObjectOfType<KingdomManager>();

        foldButton.onClick.AddListener(OnClickFoldButton);

        _allTiles = DataBaseManager.Instance.AllTiles;
        _allBuildingData = DataBaseManager.Instance.AllBuildings;

        for (int i = 0; i < _allTiles.Length; i++)
        {
            int index = i;
            Button editItemButton = Instantiate(editItemPrefab, editItemParent);
            editItemButton.image.sprite = _allTiles[i].HousingItemImage;
            editItemButton.onClick.AddListener(() => OnClickEditItemButton(_allTiles[index]));
        }

        for(int i = 0; i < _allBuildingData.Length; i++)
        {
            int index = i;
            Button editItemButton = Instantiate(editItemSkeletonPrefab, editItemParent);
            SkeletonGraphic skeletonGraphic = editItemButton.GetComponentInChildren<SkeletonGraphic>();
            skeletonGraphic.skeletonDataAsset = _allBuildingData[i].Data.SkeletonData;
            skeletonGraphic.Initialize(true);
            editItemButton.onClick.AddListener(() => OnClickEditBuildingButton(_allBuildingData[index], editItemButton.gameObject));
        }

        editItemParent.sizeDelta = new Vector2(20 + 120 * (_allTiles.Length + _allBuildingData.Length), editItemParent.sizeDelta.y);

        editExitButton.onClick.AddListener(() => OnClickEditExitButton());
    }

    private void OnClickEditExitButton()
    {
        _currentHousingItemData = null;

        editInventory.gameObject.SetActive(true);
        editSelected.gameObject.SetActive(false);
    }

    private void OnClickEditBuildingButton(BuildingController currentBuildingPrefab, GameObject button)
    {
        OnClickFoldButton();

        _currentHousingItemData = null;

        // 카메라가 보고 있는 중간에 해당 건물을 생성하고 editUI도 넣어준다.
        // 건물은 투명하게 생김
        CurrentBuilding = Instantiate(currentBuildingPrefab, _buildingParent);

        float screenWidth = Screen.width;
        float screenHeight = Screen.height;
        Vector2 screenCenter = new Vector2(screenWidth / 2f, screenHeight / 2f);
        Vector3 centerWorldPosition = _camera.ScreenToWorldPoint(new Vector3(screenCenter.x, screenCenter.y, _camera.nearClipPlane));
        centerWorldPosition = new Vector3(centerWorldPosition.x, centerWorldPosition.y, 0f);

        CurrentBuilding.transform.position = centerWorldPosition;
        CurrentBuilding.transform.SetGridTransform();

        _kindomManager.BuildingCircleEditUIInPreview.SetPrevBuilding(CurrentBuilding);
        CurrentBuilding.BuildingEditor.OnClickEditMode();
        _kindomManager.BuildingCircleEditUIInPreview.SetBuilding(CurrentBuilding, CurrentBuilding.transform, _camera.orthographicSize);

        Destroy(button);
    }

    private void OnClickEditItemButton(HousingItemData currentHousingItemData)
    {
        editInventory.gameObject.SetActive(false);
        editSelected.gameObject.SetActive(true);

        CurrentBuilding = null;
        _currentHousingItemData = currentHousingItemData;

        editItemImage.sprite = currentHousingItemData.HousingItemImage;
        editItemNameText.text = currentHousingItemData.HousingItemName;
    }

    private void OnClickFoldButton()
    {
        _isBottomHide = !_isBottomHide;

        if (_isBottomHide)
        {
            editInventory.DOMoveY(editInventory.position.y - 126, 0.3f);
            foldButton.image.sprite = _foldButtonOn;
        }
        else
        {
            editInventory.DOMoveY(editInventory.position.y + 126, 0.3f);
            foldButton.image.sprite = _foldButtonOff;
        }
    }
}
