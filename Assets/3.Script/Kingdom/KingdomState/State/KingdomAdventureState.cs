using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomAdventureState : KingdomBaseState
{
    // 들어올 시 배틀쿠키들 생성해주고 이동해주기

    public KingdomAdventureState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {

    }

    public override void Enter()
    {
        _manager.CurrentCameraControllerData = _manager.CameraContrllInStageData;
        _camera.transform.position = Vector3.forward * -10;
        _camera.orthographicSize = 10;

        GameManager.UI.PushUI(_manager.KingdomAdventureUI);
    }

    public override void Exit()
    {
        _manager.CurrentCameraControllerData = _manager.CameraControllInKingdomData;

        GameManager.UI.ClearUI();
    }

    public override void Update()
    {

    }

    public override void OnClick(InputAction.CallbackContext value)
    {
        if(_manager.IsMoveCamera)
            base.OnClick(value);
    }

    public override void OnDrag(InputAction.CallbackContext value)
    {
        if (_manager.IsMoveCamera)
            base.OnDrag(value);
    }

    public override void OnWheel(InputAction.CallbackContext value)
    {
        if (_manager.IsMoveCamera)
            base.OnWheel(value);
    }
}
