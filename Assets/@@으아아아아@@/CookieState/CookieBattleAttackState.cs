using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieBattleAttackState : CookieBattleBaseState
{
    private Collider2D target = null;

    public CookieBattleAttackState(CookieBattleStateFactory factory, CookieController controller) : base(factory, controller)
    {
    }

    public void SetTarget(Collider2D col)
    {
        target = col;
    }

    public override void Enter()
    {
        _controller.CookieAnim.PlayAnimation(ECookieAnimation.BattleAttack);
    }

    public override void Exit()
    {
        target = null;
    }

    public override void Update()
    {
        if(Physics2D.OverlapCircle(_controller.transform.position, _controller.Data.AttackRange, 1 << LayerMask.NameToLayer("Enemy")) != target)
        {
            _factory.ChangeState(ECookieBattleState.CookieBattleRunState);
        }
    }
}
