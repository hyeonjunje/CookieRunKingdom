using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManageState : KingdomBaseState
{
    private BuildingController _currentBuilding = null;


    public KingdomManageState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {

    }

    private void Init()
    {
        _manager.CurrentCameraControllerData = _manager.CameraControllInKingdomData;

        _touchCount = 0;
        _currentBuilding = null;
        _isActiveCameraControll = true;
    }

    public override void Enter()
    {
        Init();
        GameManager.UI.PushUI(_manager.KingdomManagerUI);

        _camera.transform.position = new Vector3(4.6f, 9f, -10f);
        _camera.orthographicSize = 13;

        // 쿠키들이 등장함
        _manager.allCookies.ForEach(cookie =>
        {
            cookie.CookieStat.SaveCookie();

            cookie.gameObject.SetActive(true);
            cookie.CookieCitizeon.KingdomAI();
        });

        _manager.buildingsInKingdom.ForEach(building =>
        {
            building.BuildingWorker.SaveBuilding();

            building.BuildingWorker.UpdateCraftingItem();

            building.gameObject.SetActive(true);
            building.BuildingWorker.WorkBuilding();
        });
    }

    public override void Exit()
    {
        GameManager.UI.ClearUI();

        // 쿠키들이 사라짐
        _manager.allCookies.ForEach(cookie => cookie.CookieStat.SaveCookie());
        _manager.allCookies.ForEach(cookie => cookie.gameObject.SetActive(false));

        _manager.buildingsInKingdom.ForEach(building => building.BuildingWorker.SaveBuilding());
        _manager.buildingsInKingdom.ForEach(building => building.gameObject.SetActive(false));

        GameManager.Game.PrevCraftTime = System.DateTime.Now;
    }

    public override void OnClick(InputAction.CallbackContext value)
    {
        base.OnClick(value);

        if (DetectUI())
            return;

        if (value.started)
        {
            var rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Building"));

            if (!rayHit.collider)
            {
                _currentBuilding = null;
                return;
            }

            // 제작 건물
            _currentBuilding = rayHit.transform.GetComponent<BuildingController>();

            if (_currentBuilding == null)
                return;

            Debug.Log(_currentBuilding.name + " 을 누릅니다.");

            if(!_currentBuilding.BuildingWorker.TryHarvest())
            {
                if(_currentBuilding.Data.IsCraftable)
                {
                    _factory.kingdomCraftState.SetBuilding(_currentBuilding);
                    _factory.ChangeState(EKingdomState.Craft);
                }
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
