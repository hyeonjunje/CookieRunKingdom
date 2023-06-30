using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// 스킬 버튼 눌러서 스킬 발동되면 이 상태로 이동
public class BattleSkillState : BaseBattleState
{
    private float _currentTime = 0f;

    public BattleSkillState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        _currentTime = 0f;
        _controller.BaseSkill.UseSkill();
    }

    public override void Exit()
    {

    }

    public override void Update()
    {
        if(!_controller.BaseSkill.UseSkill())
        {
            _factory.ChangeState(EBattleState.BattleRunState);
        }
    }
}
