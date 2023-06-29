using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleRunState : BaseBattleState
{
    private Collider2D _col = null;

    public BattleRunState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        _col = null;
        _controller.CharacterAnimator.PlayAnimation(ECookieAnimation.BattleRun);
    }

    public override void Exit()
    {

    }

    public override void Update()
    {
        Vector3 dir = _controller.CharacterBattleController.IsForward ? new Vector3(7.72f, 3.68f, 0f).normalized : new Vector3(-7.72f, -3.68f, 0f).normalized;
        _controller.transform.position += dir * Time.deltaTime * _controller.Data.MoveSpeed;

        _col = Physics2D.OverlapCircle(_controller.transform.position, _controller.Data.AttackRange, _controller.targetLayer);
        if (_col != null)
        {
            _factory.BattleAttack.SetTarget(_col);
            _factory.ChangeState(EBattleState.BattleAttackState);
        }
    }
}
