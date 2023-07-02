using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleRunState : BaseBattleState
{
    private bool isPos = false;

    public BattleRunState(BattleStateFactory factory, BaseController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        _controller.CharacterAnimator.PlayAnimation(ECookieAnimation.BattleRun);

        if (_controller.CharacterBattleController.CookieBundle != null)
        {
            isPos = false;
            _controller.CharacterBattleController.CookieBundle.ActiveMove(true);
        }
    }

    public override void Exit()
    {
        if (_controller.CharacterBattleController.CookieBundle != null)
            _controller.CharacterBattleController.CookieBundle.ActiveMove(false);
    }

    public override void Update()
    {
        // 원위치가 있는 캐릭터라면 윈위치로 부드럽게 이동 후 자체적으로 이동해야 함
        if (_controller.CharacterBattleController.OffsetPosition != null)
        {
            Vector3 dir = Vector3.zero;
            if(!isPos)
            {
                dir = (_controller.CharacterBattleController.OffsetPosition.position - _controller.transform.position).normalized * 3;

                if(Vector3.Distance(_controller.CharacterBattleController.OffsetPosition.position, _controller.transform.position) < 0.1f)
                {
                    _controller.transform.position = _controller.CharacterBattleController.OffsetPosition.position;
                    isPos = true;
                }
            }
            else
            {
                dir = _controller.CharacterBattleController.IsForward ? Utils.Dir.normalized : -Utils.Dir.normalized;
            }
            _controller.transform.position += dir * Time.deltaTime * _controller.Data.MoveSpeed;
        }
        // 아니면 그냥 움직임
        else
        {
            Vector3 dir = _controller.CharacterBattleController.IsForward ? Utils.Dir.normalized : -Utils.Dir.normalized;
            _controller.transform.position += dir * Time.deltaTime * _controller.Data.MoveSpeed;
        }

        CharacterBattleController enemy = _controller.BaseSkill.DetectTarget();
        if (enemy != null)
        {
            _factory.BattleAttack.SetTarget(enemy);
            _factory.ChangeState(EBattleState.BattleAttackState);
        }
    }
}
