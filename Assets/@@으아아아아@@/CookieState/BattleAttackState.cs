using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleAttackState : BaseBattleState
{
    private Collider2D target = null;

    public BattleAttackState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public void SetTarget(Collider2D col)
    {
        target = col;
    }

    public override void Enter()
    {
        _controller.CharacterAnimator.PlayAnimation(ECookieAnimation.BattleAttack);
    }

    public override void Exit()
    {
        target = null;
    }

    public override void Update()
    {
        if(Physics2D.OverlapCircle(_controller.transform.position, _controller.Data.AttackRange, _controller.targetLayer) != target)
        {
            _factory.ChangeState(EBattleState.BattleRunState);
        }
    }
}
