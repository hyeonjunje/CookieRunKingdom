using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleAttackState : BaseBattleState
{
    private BaseController target = null;
    private Collider2D tar = null;

    public BattleAttackState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public void SetTarget(Collider2D col)
    {
        tar = col;
        target = col.GetComponent<BaseController>();
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
        if(Physics2D.OverlapCircle(_controller.transform.position, _controller.Data.AttackRange, _controller.targetLayer) != tar)
        {
            _factory.ChangeState(EBattleState.BattleRunState);
        }
    }
}
