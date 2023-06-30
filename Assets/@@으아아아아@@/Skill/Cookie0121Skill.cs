using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0121Skill : BaseSkill
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
        throw new System.NotImplementedException();
    }

    public override bool UseSkill()
    {
        if(_currentTime == 0)
        {
            PlayAnimation(animationName[_skillIndex]);
            /*if (_skillIndex == 0)
            {
                PlayAnimation(animationName[_skillIndex]);
            }
            else if (_skillIndex == 1)
            {
                PlayAnimation(animationName[_skillIndex]);
            }
            else if (_skillIndex == 2)
            {
                PlayAnimation(animationName[_skillIndex]);
            }*/
        }

        _currentTime += Time.deltaTime;

        if(_currentTime >= CurrentSkillTime)
        {
            _currentTime = 0;
            _skillIndex++;

            if(_skillIndex == animationName.Length)
            {
                _currentTime = 0;
                _skillIndex = 0;

                return false;
            }
        }

        return true;
    }
}
