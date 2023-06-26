using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManager : MonoBehaviour
{
    private KingdomStateFactory _factory;

    [Header("UI")]
    [SerializeField] private BaseUI _kingdomManagerUI;
    [SerializeField] private BaseUI _kingdomEditUI;
    [SerializeField] private GameObject _backGroundUI;
    [SerializeField] private CraftUI _kingdomCraftUI;

    [Header("������Ʈ")]
    [SerializeField] private BuildingSelectUI _buildingSelectUI;
    [SerializeField] private Grid _grid;

    [Header("Data")]
    [SerializeField] private CameraControllData _cameraControllData;

    // ������Ƽ
    public BaseUI KingdomManagerUI => _kingdomManagerUI;
    public BaseUI KingdomEditUI => _kingdomEditUI;
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


    #region InputAction�� ���� �޼ҵ��!!
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


    #region ��ư�� ���� �޼ҵ��!!
    public void ChangeState(int index)
    {
        _factory.ChangeState((EKingdomState)index);
    }
    #endregion
}
