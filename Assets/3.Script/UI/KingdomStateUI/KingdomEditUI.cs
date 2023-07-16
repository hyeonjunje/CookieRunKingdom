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
    [SerializeField] private TextMeshProUGUI _diaText;
    [SerializeField] private TextMeshProUGUI _moneyText;

    [Header("LeftTop")]
    [SerializeField] private TextMeshProUGUI _environmentScoreText;

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
    private List<Button> _ownedBuilding;  // ���� �����ϰ� �ִ� �ǹ�
    private KingdomManager _kindomManager;
    private bool _isBottomHide;

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

        for (int i = 0; i < _kindomManager.buildingsInKingdom.Count; i++)
            GameManager.Game.EnvironmentScore += _kindomManager.buildingsInKingdom[i].Data.BuildingScore;
        _environmentScoreText.text = GameManager.Game.EnvironmentScore.ToString();

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeMoney += (() => _moneyText.text = GameManager.Game.Money.ToString("#,##0"));
        GameManager.Game.UpdateGoods();

        _kindomManager.BuildingCircleEditUI.onInstallBuilding += () => _environmentScoreText.text = GameManager.Game.EnvironmentScore.ToString();
        _kindomManager.BuildingCircleEditUI.onUnInstallBuilding += () => _environmentScoreText.text = GameManager.Game.EnvironmentScore.ToString();
        _kindomManager.BuildingCircleEditUIInPreview.onInstallBuilding += () => _environmentScoreText.text = GameManager.Game.EnvironmentScore.ToString();
        _kindomManager.BuildingCircleEditUIInPreview.onUnInstallBuilding += () => _environmentScoreText.text = GameManager.Game.EnvironmentScore.ToString();

        List<BuildingController> ownedBuilding = _kindomManager.buildingsInInventory;  // ���� ������ ��ü �ǹ�
        List<BuildingController> buildingsInKingdom = _kindomManager.buildingsInKingdom;  // �ձ��� ��ġ�� �ǹ�

        _ownedBuilding = new List<Button>();

        for (int i = 0; i < ownedBuilding.Count; i++)
        {
            AddBuilding(ownedBuilding[i]);
        }
        foldButton.onClick.AddListener(OnClickFoldButton);
        editExitButton.onClick.AddListener(() => OnClickEditExitButton());
    }

    // �κ��丮�� �߰�
    public void AddBuilding(BuildingController building)
    {
        Button editItemButton = Instantiate(editItemSkeletonPrefab, editItemParent);
        SkeletonGraphic skeletonGraphic = editItemButton.GetComponentInChildren<SkeletonGraphic>();

        _ownedBuilding.Add(editItemButton);

        skeletonGraphic.skeletonDataAsset = building.Data.SkeletonData;
        skeletonGraphic.Initialize(true);
        editItemButton.onClick.AddListener(() => OnClickEditBuildingButton(building, editItemButton));

        editItemParent.sizeDelta = new Vector2(20 + 220 * (_ownedBuilding.Count), editItemParent.sizeDelta.y);
    }


    // �κ��丮�� ����
    public void RemoveBuilding(Button removeButton)
    {
        _ownedBuilding.Remove(removeButton);
        Destroy(removeButton.gameObject);
    }


    private void OnClickEditExitButton()
    {
        editInventory.gameObject.SetActive(true);
        editSelected.gameObject.SetActive(false);
    }

    private void OnClickEditBuildingButton(BuildingController currentBuildingPrefab, Button button)
    {
        OnClickFoldButton();

        // ī�޶� ���� �ִ� �߰��� �ش� �ǹ��� �����ϰ� editUI�� �־��ش�.
        // �ǹ��� �����ϰ� ����
        currentBuildingPrefab.gameObject.SetActive(true);

        float screenWidth = Screen.width;
        float screenHeight = Screen.height;
        Vector2 screenCenter = new Vector2(screenWidth / 2f, screenHeight / 2f);
        Vector3 centerWorldPosition = _camera.ScreenToWorldPoint(new Vector3(screenCenter.x, screenCenter.y, _camera.nearClipPlane));
        centerWorldPosition = new Vector3(centerWorldPosition.x, centerWorldPosition.y, 0f);

        currentBuildingPrefab.transform.position = centerWorldPosition;
        currentBuildingPrefab.transform.SetGridTransform();

        _kindomManager.BuildingCircleEditUIInPreview.SetPrevBuilding(currentBuildingPrefab);
        currentBuildingPrefab.BuildingEditor.OnClickEditMode();
        _kindomManager.BuildingCircleEditUIInPreview.SetBuilding(currentBuildingPrefab, currentBuildingPrefab.transform, _camera.orthographicSize);

        // Ÿ���� �������� ����
        RemoveBuilding(button);
    }

    private void OnClickEditItemButton(HousingItemData currentHousingItemData)
    {
        editInventory.gameObject.SetActive(false);
        editSelected.gameObject.SetActive(true);

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
