using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleRunState : BaseBattleState
{
    private bool _isPos = false;

    public BattleRunState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        _controller.CharacterAnimator.PlayAnimation(ECookieAnimation.BattleRun);
        _isPos = false;
    }

    public override void Exit()
    {
        _isPos = true;
    }

    public override void Update()
    {
        // ����ġ�� �ִ� ĳ���Ͷ�� ����ġ�� �ε巴�� �̵� �� ��ü������ �̵��ؾ� ��
        Vector3 dir = _controller.CharacterBattleController.IsForward ? Utils.Dir.normalized : -Utils.Dir.normalized;

        if (_controller.CharacterBattleController.OffsetPosition != null)
        {
            if(!_isPos)
            {
                if (Vector2.Distance(_controller.CharacterBattleController.OffsetPosition.position, _controller.transform.position) < 0.1f)
                {
                    _controller.transform.position = _controller.CharacterBattleController.OffsetPosition.position;
                    _isPos = true;
                }

                // �տ� ������ ��ٸ���
                // �ڿ� ������ ������ ���󰣴�.

                if (_controller.CharacterBattleController.OffsetPosition.position.x < _controller.transform.position.x)
                    dir *= 0.3f;
                else
                    dir *= 3f;
            }
        }
        _controller.transform.position += dir * Time.deltaTime * _controller.Data.MoveSpeed;

        CharacterBattleController enemy = _controller.BaseSkill.DetectTarget();
        if (enemy != null)
        {
            _factory.BattleAttack.SetTarget(enemy);
            _factory.ChangeState(EBattleState.BattleAttackState);
        }
    }
}
