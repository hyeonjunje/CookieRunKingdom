using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0001Skill : BaseMeleeSkill
{
    [SerializeField] protected DetectRange _detectSkillRange;
    [SerializeField] protected DetectRange _detectSkillAttackRange;

    // ���� ����ǰ� �ִ� �ִϸ��̼��� ����
    private List<CharacterBattleController> targets => _detectSkillAttackRange.enemies;
    private int _skillIndex = 0;

    public override void Init(BaseController controller)
    {
        base.Init(controller);
    }

    public override void SetLayer(LayerMask layer)
    {
        base.SetLayer(layer);
        _detectSkillRange.Init(layer);
        _detectSkillAttackRange.Init(layer);
    }

    public override void NormalAttackEvent()
    {
        base.NormalAttackEvent();
    }

    public override void OnSkillEvent(int index)
    {

    }

    public override bool IsReadyToUseSkill()
    {
        return _detectSkillRange.enemies.Count != 0;
    }

    // false�� ��ų ����
    public override bool UseSkill()
    {
        // ����� �޷����� ���� ������ ���� �ִϸ��̼� �ϸ鼭 ����
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
        }
        else if(_skillIndex == 1 && !DetectTarget())
        {
            // �޷���
            Vector3 dir = _controller.CharacterBattleController.IsForward ? Utils.Dir.normalized : -Utils.Dir.normalized;
            _controller.transform.position += dir * Time.deltaTime * _controller.Data.MoveSpeed * 2;
        }
        else if(_skillIndex == 1 && targets.Count != 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
            for(int i = 0; i < targets.Count; i++)
            {
                if (targets[i].IsDead)
                    continue;
                targets[i].SetCC(ECCType.KnockBack, Utils.Dir.normalized * 3);
                targets[i].ChangeCurrentHp(AttackPower, _controller.CharacterStat);
            }
        }
        else
        {
            if(!_controller.CharacterAnimator.IsPlayingAnimation())
            {
                _skillIndex = 0;
                return false;
            }
        }

        return true;
    }
}
