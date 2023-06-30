using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0001Skill : BaseSkill
{
    [SerializeField] protected DetectRange _detectSkillRange;

    // ���� ����ǰ� �ִ� �ִϸ��̼��� ����
    private List<CharacterBattleController> targets => _detectSkillRange.enemies;
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
    }

    public override void NormalAttack()
    {
        SingleAttack();
    }

    public override void OnSkillEvent(int index)
    {

    }

    // false�� ��ų ����
    public override bool UseSkill()
    {
        // ����� �޷����� ���� ������ ���� �ִϸ��̼� �ϸ鼭 ����
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
        }
        else if(_skillIndex == 1 && targets.Count == 0)
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
