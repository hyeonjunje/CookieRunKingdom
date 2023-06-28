using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class CookieBattleBaseState
{
    protected CookieBattleStateFactory _factory;
    protected CookieController _controller;

    public CookieBattleBaseState(CookieBattleStateFactory factory, CookieController controller)
    {
        _factory = factory;
        _controller = controller;
    }

    public abstract void Enter();
    public abstract void Exit();
    public abstract void Update();
}
