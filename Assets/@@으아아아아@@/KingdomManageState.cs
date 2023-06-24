using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManageState : KingdomBaseState
{
    public KingdomManageState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    private void Init()
    {
        _touchCount = 0;
        _isActiveCameraControll = true;
    }

    public override void Enter()
    {
        Init();
        _manager.KingdomManagerUI.SetActive(true);
    }

    public override void Exit()
    {
        _manager.KingdomManagerUI.SetActive(false);
    }

    public override void OnClick(InputAction.CallbackContext value)
    {
        base.OnClick(value);
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
