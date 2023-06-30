using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0001Skill : BaseSkill
{
    [SerializeField] protected DetectRange _detectSkillRange;

    // 현재 실행되고 있는 애니메이션의 길이
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

    // false면 스킬 종료
    public override bool UseSkill()
    {
        // 용쿠는 달려가서 적이 있으면 다음 애니메이션 하면서 때림
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
        }
        else if(_skillIndex == 1 && targets.Count == 0)
        {
            // 달려가
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
