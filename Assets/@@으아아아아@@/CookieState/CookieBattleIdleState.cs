using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieBattleIdleState : CookieBattleBaseState
{
    private float _currentTime = 0f;

    public CookieBattleIdleState(CookieBattleStateFactory factory, CookieController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        _currentTime = 0f;
        _controller.CookieAnim.PlayAnimation(ECookieAnimation.BattleIdle);
    }

    public override void Exit()
    {

    }

    public override void Update()
    {
        _currentTime += Time.deltaTime;
        if(_currentTime > 2)
        {
            _factory.ChangeState(ECookieBattleState.CookieBattleRunState);
        }
    }
}
