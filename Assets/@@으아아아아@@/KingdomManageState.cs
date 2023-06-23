using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomManageState : KingdomBaseState
{
    public KingdomManageState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public override void Enter()
    {
        _manager.KingdomManagerUI.SetActive(true);
    }

    public override void Exit()
    {
        _manager.KingdomManagerUI.SetActive(false);
    }

    public override void Update()
    {
    }
}
