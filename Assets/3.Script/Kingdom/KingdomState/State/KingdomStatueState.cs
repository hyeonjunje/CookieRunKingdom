using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomStatueState : KingdomBaseState
{
    public KingdomStatueState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public override void Enter()
    {
        GameManager.UI.PushUI(_manager.KingdomStatueUI);
    }

    public override void Exit()
    {
        GameManager.UI.ClearUI();
    }

    public override void Update()
    {

    }

    public override void OnClick()
    {
    }

    public override void OnDrag()
    {
    }

    public override void OnWheel(InputAction.CallbackContext value)
    {
    }
}
