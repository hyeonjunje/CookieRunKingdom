using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleRunState : BaseBattleState
{
    public BattleRunState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        _controller.CharacterAnimator.PlayAnimation(ECookieAnimation.BattleRun);
    }

    public override void Exit()
    {

    }

    public override void Update()
    {
        Vector3 dir = _controller.CharacterBattleController.IsForward ? new Vector3(7.72f, 3.68f, 0f).normalized : new Vector3(-7.72f, -3.68f, 0f).normalized;
        _controller.transform.position += dir * Time.deltaTime * _controller.Data.MoveSpeed;

        CharacterBattleController enemy = _controller.BaseSkill.DetectTarget();
        if (enemy != null)
        {
            _factory.BattleAttack.SetTarget(enemy);
            _factory.ChangeState(EBattleState.BattleAttackState);
        }
    }
}
