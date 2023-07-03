using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class Cookie0514Skill : BaseHealSkill
{
    private int _skillIndex = 0;
    private float _currentTime = 0;

    private float CurrentSkillTime => _controller.CharacterAnimator.GetIntervalAnimation();
    private bool _isSkillUse = false;

    public override void NormalAttack()
    {
        base.NormalAttack();
    }

    public override void OnSkillEvent(int index)
    {
        if(index == 0 && !_isSkillUse)
        {
            _isSkillUse = true;

            BaseController[] cookies = BattleManager.instance.Cookies.OrderBy(cookie => cookie.CharacterBattleController.CurrentHp).ToArray();

            // Hp ���� ���� 2�� ȸ�� �� ��ȣ��
            for(int i = 0; i < 2; i++)
            {
                if(i < cookies.Length)
                {
                    cookies[i].CharacterBattleController.CurrentHp += 1000;
                    Debug.Log(cookies[i] + " ȸ���մϴ�.");
                }
            }
        }
    }

    // �츮 ���� ü���� ���� ��Ű�� ������ true
    public override bool IsReadyToUseSkill()
    {
        List<BaseController> cookies = BattleManager.instance.Cookies;
        foreach(BaseController cookie in cookies)
        {
            if (cookie.CharacterBattleController.CurrentHp != cookie.CharacterBattleController.MaxHp)
                return true;
        }
        return false;
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
                _skillIndex = 0;
                return false;
            }
        }
        return true;
    }
}
