using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// ��ų ��ư ������ ��ų �ߵ��Ǹ� �� ���·� �̵�
public class BattleSkillState : BaseBattleState
{
    private float _currentTime = 0f;

    public BattleSkillState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        if (_controller.CharacterBattleController.CookieBundle != null)
            _controller.CharacterBattleController.CookieBundle.ActiveMove(true);

        _currentTime = 0f;
        _controller.BaseSkill.UseSkill();
    }

    public override void Exit()
    {
        if (_controller.CharacterBattleController.CookieBundle != null)
            _controller.CharacterBattleController.CookieBundle.ActiveMove(false);
    }

    public override void Update()
    {
        if(!_controller.BaseSkill.UseSkill())
        {
            _factory.ChangeState(EBattleState.BattleRunState);
        }
    }
}
