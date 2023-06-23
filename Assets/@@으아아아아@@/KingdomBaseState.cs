using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class KingdomBaseState
{
    protected KingdomStateFactory _factory;
    protected KingdomManager _manager;

    public KingdomBaseState(KingdomStateFactory factory, KingdomManager manager)
    {
        _factory = factory;
        _manager = manager;
    }

    public abstract void Enter();
    public abstract void Exit();
    public abstract void Update();
}
