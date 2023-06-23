using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomEditState : KingdomBaseState
{
    public KingdomEditState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public override void Enter()
    {
        _manager.KingdomEditUI.SetActive(true);
    }

    public override void Exit()
    {
        _manager.KingdomEditUI.SetActive(false);
    }

    public override void Update()
    {
    }
}
