using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class Cookie0514Skill : BaseHealSkill
{
    private int _skillIndex = 0;
    private bool _isSkillUse = false;

    public override void NormalAttackEvent()
    {
        base.NormalAttackEvent();
    }

    public override void OnSkillEvent(int index)
    {
        if(index == 0 && !_isSkillUse)
        {
            _isSkillUse = true;

            BaseController[] cookies = BattleManager.instance.CookiesInBattleList.OrderBy(cookie => cookie.CharacterBattleController.CurrentHp).ToArray();

            // Hp 제일 작은 2명 회복 및 보호막
            for(int i = 0; i < 2; i++)
            {
                if(i < cookies.Length)
                {
                    cookies[i].CharacterBattleController.CurrentHp += AttackPower;
                    Debug.Log(cookies[i] + " 회복합니다.");
                }
            }
        }
    }

    // 우리 팀에 체력이 깎인 쿠키가 있으면 true
    public override bool IsReadyToUseSkill()
    {
        List<BaseController> cookies = BattleManager.instance.CookiesInBattleList;
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
            if(!_controller.CharacterAnimator.IsPlayingAnimation())
            {
                _skillIndex = 0;
                return false;
            }
        }
        return true;
    }
}
