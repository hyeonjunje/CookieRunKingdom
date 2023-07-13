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
        GameManager.UI.PushUI(_manager.KingdomDailyDungeonUI);
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
