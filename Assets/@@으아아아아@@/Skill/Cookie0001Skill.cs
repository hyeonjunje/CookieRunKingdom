using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0001Skill : BaseMeleeSkill
{
    [SerializeField] protected DetectRange _detectSkillRange;
    [SerializeField] protected DetectRange _detectSkillAttackRange;

    // ���� ����ǰ� �ִ� �ִϸ��̼��� ����
    private List<CharacterBattleController> targets => _detectSkillAttackRange.enemies;
    private float CurrentSkillTime => _controller.CharacterAnimator.GetIntervalAnimation();
    private int _skillIndex = 0;
    private float _currentTime = 0;

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
            Vector3 dir = _controller.CharacterBattleController.IsForward ? new Vector3(7.72f, 3.68f, 0f).normalized : new Vector3(-7.72f, -3.68f, 0f).normalized;
            _controller.transform.position += dir * Time.deltaTime * _controller.Data.MoveSpeed * 2;
        }
        else if(_skillIndex == 1 && targets.Count != 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
            for(int i = 0; i < targets.Count; i++)
            {
                targets[i].CurrentHp -= 3000;
            }
        }
        else
        {
            _currentTime += Time.deltaTime;
            if(_currentTime >= CurrentSkillTime)
            {
                _skillIndex = 0;
                return false;
            }
        }

        return true;
    }
}
