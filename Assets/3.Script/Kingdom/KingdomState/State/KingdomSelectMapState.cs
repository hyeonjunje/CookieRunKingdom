using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomSelectMapState : KingdomBaseState
{
    public KingdomSelectMapState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public override void Enter()
    {
        GameManager.UI.PushUI(_manager.KingdomSelectMapUI);
    }

    public override void Exit()
    {
        GameManager.UI.ClearUI();
    }
    public override void Update()
    {
    }

    public override void OnClick(InputAction.CallbackContext value)
    {
    }

    public override void OnDrag(InputAction.CallbackContext value)
    {
    }

    public override void OnWheel(InputAction.CallbackContext value)
    {
    }
}
