using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0025Skill : BaseSkill
{
    private float CurrentSkillTime => _controller.CharacterAnimator.GetIntervalAnimation();
    private int _skillIndex = 0;
    private float _currentTime = 0;

    public override void NormalAttack()
    {
        SingleAttack();
    }

    public override void OnSkillEvent(int index)
    {
        if(index == 0)
        {
            // 투사체 발사!
        }
    }

    public override bool UseSkill()
    {
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
        }
        else if(_skillIndex != 0)
        {
            _currentTime += Time.deltaTime;

            if(_currentTime >= CurrentSkillTime)
            {
                _currentTime = 0;
                return false;
            }
        }

        return true;
    }
}
