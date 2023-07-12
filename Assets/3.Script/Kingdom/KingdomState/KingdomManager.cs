using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManager : MonoBehaviour
{
    private KingdomStateFactory _factory;

    [Header("UI")]
    [SerializeField] private KingdomManageUI _kingdomManagerUI;
    [SerializeField] private KingdomEditUI _kingdomEditUI;
    [SerializeField] private GameObject _backGroundUI;
    [SerializeField] private KingdomCraftUI _kingdomCraftUI;
    [SerializeField] private KingdomPlayUI _kingdomPlayUI;

    [SerializeField] private KingdomAdventureUI _kingdomAdventureUI;
    [SerializeField] private KingdomDailyDungeonUI _kingdomDailyDungeonUI;
    [SerializeField] private KingdomStatueUI _kingdomStatueUI;

    [Header("Ʈ������")]
    [SerializeField] private Transform _kingdomGrid;

    [Header("������Ʈ")]
    [SerializeField] private BuildingCircleEditUI _buildingCircleEditUI;
    [SerializeField] private BuildingCircleEditUIInPreview _buildingCircleEditUIInPreview;
    [SerializeField] private Grid _grid;

    [Header("Data")]
    [SerializeField] private CameraControllData _cameraControllInKingdomData;
    [SerializeField] private CameraControllData _cameraControllInStageData;

    // ������Ƽ
    public KingdomManageUI KingdomManagerUI => _kingdomManagerUI;
    public KingdomEditUI KingdomEditUI => _kingdomEditUI;
    public GameObject KingdomBackGroundUI => _backGroundUI;
    public KingdomCraftUI KingdomCraftUI => _kingdomCraftUI;
    public KingdomPlayUI KingdomPlayUI => _kingdomPlayUI;

    public KingdomAdventureUI KingdomAdventureUI => _kingdomAdventureUI;
    public KingdomDailyDungeonUI KingdomDailyDungeonUI => _kingdomDailyDungeonUI;
    public KingdomStatueUI KingdomStatueUI => _kingdomStatueUI;

    public Transform KingdomGrid => _kingdomGrid;

    public BuildingCircleEditUI BuildingCircleEditUI => _buildingCircleEditUI;
    public BuildingCircleEditUIInPreview BuildingCircleEditUIInPreview => _buildingCircleEditUIInPreview;
    public Grid Grid => _grid;
    public CameraControllData CameraControllInKingdomData => _cameraControllInKingdomData;
    public CameraControllData CameraContrllInStageData => _cameraControllInStageData;

    public CameraControllData CurrentCameraControllerData { get; set; }

    public bool IsMoveCamera { get; set; } = true;

    // ���� ������ �������� �ǹ�
    public List<BuildingController> buildingsInInventory = new List<BuildingController>();  
    
    // �� �ձ��� �ִ� �������� �ǹ�(��ġ�Ǿ��ִ� �ǹ��̶� ������)
    public List<BuildingController> buildingsInKingdom = new List<BuildingController>();
    
    
    public List<CookieController> allCookies = new List<CookieController>();


    public List<CookieController> workingCookies = new List<CookieController>();

    public void Init()
    {
        _factory = new KingdomStateFactory(this);
        ChangeState(GameManager.Game.StartKingdomState);
        StartCoroutine(CoUpdate());
    }


    #region InputAction�� ���� �޼ҵ��!!
    public void OnWheel(InputAction.CallbackContext value)
    {
        if (!IsMoveCamera)
            return;

        if (_factory == null)
            return;

        _factory.CurrentKingdomState.OnWheel(value);
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        if (!IsMoveCamera)
            return;

        if (_factory == null)
            return;

        _factory.CurrentKingdomState.OnClick(value);
    }

    public void OnDrag(InputAction.CallbackContext value)
    {
        if (!IsMoveCamera)
            return;

        if (_factory == null)
            return;

        _factory.CurrentKingdomState.OnDrag(value);
    }
    #endregion


    #region ��ư�� ���� �޼ҵ��!!
    public void ChangeState(int index)
    {
        _factory.ChangeState((EKingdomState)index);
    }

    public void ChangeState(EKingdomState state)
    {
        _factory.ChangeState(state);
    }
    #endregion

    private IEnumerator CoUpdate()
    {
        while (true)
        {
            yield return null;
            _factory.CurrentKingdomState.Update();
        }
    }
}
