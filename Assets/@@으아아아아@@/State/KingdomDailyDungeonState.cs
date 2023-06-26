using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomDailyDungeonState : KingdomBaseState
{
    public KingdomDailyDungeonState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public override void Enter()
    {
        UIManager.instance.PushUI(_manager.KingdomDailyDungeonUI);
    }

    public override void Exit()
    {
        UIManager.instance.ClearUI();
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
