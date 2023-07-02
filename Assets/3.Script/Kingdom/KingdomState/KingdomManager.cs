using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManager : MonoBehaviour
{
    private KingdomStateFactory _factory;

    [Header("UI")]
    [SerializeField] private BaseUI _kingdomManagerUI;
    [SerializeField] private KingdomEditUI _kingdomEditUI;
    [SerializeField] private GameObject _backGroundUI;
    [SerializeField] private KingdomCraftUI _kingdomCraftUI;
    [SerializeField] private KingdomPlayUI _kingdomPlayUI;

    [SerializeField] private KingdomAdventureUI _kingdomAdventureUI;
    [SerializeField] private KingdomDailyDungeonUI _kingdomDailyDungeonUI;
    [SerializeField] private KingdomHotAirBalloonUI _kingdomHotAirBalloonUI;
    [SerializeField] private KingdomStatueUI _kingdomStatueUI;
    [SerializeField] private KingdomTrainStationUI _kingdomTrainStationUI;
    [SerializeField] private KingdomWishTreeUI _kingdomWishTreeUi;
    [SerializeField] private KingdomSelectMapUI _kingdomSelectMapUI;

    [Header("컴포넌트")]
    [SerializeField] private BuildingSelectUI _buildingSelectUI;
    [SerializeField] private Grid _grid;

    [Header("Data")]
    [SerializeField] private CameraControllData _cameraControllInKingdomData;
    [SerializeField] private CameraControllData _cameraControllInStageData;

    // 프로퍼티
    public BaseUI KingdomManagerUI => _kingdomManagerUI;
    public KingdomEditUI KingdomEditUI => _kingdomEditUI;
    public GameObject KingdomBackGroundUI => _backGroundUI;
    public KingdomCraftUI KingdomCraftUI => _kingdomCraftUI;
    public KingdomPlayUI KingdomPlayUI => _kingdomPlayUI;

    public KingdomAdventureUI KingdomAdventureUI => _kingdomAdventureUI;
    public KingdomDailyDungeonUI KingdomDailyDungeonUI => _kingdomDailyDungeonUI;
    public KingdomHotAirBalloonUI KingdomHotAirBalloonUI => _kingdomHotAirBalloonUI;
    public KingdomStatueUI KingdomStatueUI => _kingdomStatueUI;
    public KingdomTrainStationUI KingdomTrainStationUI => _kingdomTrainStationUI;
    public KingdomWishTreeUI KingdomWishTreeUI => _kingdomWishTreeUi;
    public KingdomSelectMapUI KingdomSelectMapUI => _kingdomSelectMapUI;

    public BuildingSelectUI BuildingSelectUI => _buildingSelectUI;
    public Grid Grid => _grid;
    public CameraControllData CameraControllInKingdomData => _cameraControllInKingdomData;
    public CameraControllData CameraContrllInStageData => _cameraControllInStageData;

    public CameraControllData CurrentCameraControllerData { get; set; }

    public bool IsMoveCamera { get; set; } = true;

    private void Awake()
    {
        _factory = new KingdomStateFactory(this);
    }

    private void Update()
    {
        _factory.CurrentKingdomState.Update();
    }


    #region InputAction에 넣을 메소드들!!
    public void OnWheel(InputAction.CallbackContext value)
    {
        _factory.CurrentKingdomState.OnWheel(value);
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        _factory.CurrentKingdomState.OnClick(value);
    }

    public void OnDrag(InputAction.CallbackContext value)
    {
        _factory.CurrentKingdomState.OnDrag(value);
    }
    #endregion


    #region 버튼에 넣을 메소드들!!
    public void ChangeState(int index)
    {
        _factory.ChangeState((EKingdomState)index);
    }

    public void ChangeState(EKingdomState state)
    {
        _factory.ChangeState(state);
    }
    #endregion
}
