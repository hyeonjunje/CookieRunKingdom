using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManager : MonoBehaviour
{
    private KingdomStateFactory _factory;

    [Header("UI")]
    [SerializeField] private GameObject _kingdomManagerUI;
    [SerializeField] private GameObject _kingdomEditUI;
    [SerializeField] private GameObject _backGroundUI;
    [SerializeField] private CraftUI _kingdomCraftUI;

    [Header("컴포넌트")]
    [SerializeField] private BuildingSelectUI _buildingSelectUI;
    [SerializeField] private Grid _grid;

    [Header("Data")]
    [SerializeField] private CameraControllData _cameraControllData;

    // 프로퍼티
    public GameObject KingdomManagerUI => _kingdomManagerUI;
    public GameObject KingdomEditUI => _kingdomEditUI;
    public GameObject KingdomBackGroundUI => _backGroundUI;
    public CraftUI KingdomCraftUI => _kingdomCraftUI;
    public BuildingSelectUI BuildingSelectUI => _buildingSelectUI;
    public Grid Grid => _grid;
    public CameraControllData CameraControllData => _cameraControllData;


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
    #endregion
}
