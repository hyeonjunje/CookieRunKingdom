using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManageState : KingdomBaseState
{
    private Building _currentBuilding = null;


    public KingdomManageState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {

    }

    private void Init()
    {
        _touchCount = 0;
        _currentBuilding = null;
        _isActiveCameraControll = true;
    }

    public override void Enter()
    {
        Init();
        GameManager.UI.PushUI(_manager.KingdomManagerUI);
    }

    public override void Exit()
    {
        GameManager.UI.ClearUI();
    }

    public override void OnClick(InputAction.CallbackContext value)
    {
        base.OnClick(value);

        if (value.started)
        {
            var rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Building"));

            if (!rayHit.collider)
            {
                _currentBuilding = null;
                return;
            }

            // 제작 건물
            _currentBuilding = rayHit.transform.GetComponent<Building>();

            if (_currentBuilding == null)
                return;

            Debug.Log(_currentBuilding.name + " 을 누릅니다.");

            if(!_currentBuilding.TryHarvest())
            {
                _factory.kingdomCraftState.SetBuilding(_currentBuilding);
                _factory.ChangeState(EKingdomState.Craft);
            }
        }

        else if (value.canceled)
        {
            _isActiveCameraControll = true;

            var rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Building"));

            if (!rayHit.collider)
            {
                _currentBuilding = null;
                return;
            }

            // 인터랙션 먼저
            KingdomInteractionBuilding building = rayHit.transform.GetComponent<KingdomInteractionBuilding>();
            if (building != null)
            {
                building.OnClickKingdomInteractionBuilding();
                return;
            }
        }
    }

    public override void OnDrag(InputAction.CallbackContext value)
    {
        base.OnDrag(value);
    }

    public override void OnWheel(InputAction.CallbackContext value)
    {
        base.OnWheel(value);
    }

    public override void Update()
    {

    }
}
