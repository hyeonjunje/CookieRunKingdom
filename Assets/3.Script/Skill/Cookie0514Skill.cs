using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

// Ŀ���͵�3���� ��Ű
public class Cookie0514Skill : BaseHealSkill
{
    private int _skillIndex = 0;

    public override void NormalAttackEvent()
    {
        base.NormalAttackEvent();
    }

    public override void OnSkillEvent(int index)
    {
        if(index == 0)
        {
            CookieController[] cookies = BattleManager.instance.CookieList
                .Where(cookie => !cookie.CharacterBattleController.IsDead)
                .OrderBy(cookie => cookie.CharacterBattleController.CurrentHp).ToArray();

            Debug.Log(cookies.Length + " �� ȸ���մϴ�.");

            // Hp ���� ���� 2�� ȸ�� �� ��ȣ��
            for(int i = 0; i < 2; i++)
                if(i < cookies.Length)
                    cookies[i].CharacterBattleController.ChangeCurrentHp(AttackPower, _controller.CharacterStat);
        }
    }

    // �츮 ���� ü���� ���� ��Ű�� ������ true
    public override bool IsReadyToUseSkill()
    {
        List<CookieController> cookies = BattleManager.instance.CookieList;
        foreach(CookieController cookie in cookies)
            if (!cookie.CharacterBattleController.IsDead && cookie.CharacterBattleController.CurrentHp != cookie.CharacterBattleController.MaxHp)
                return true;
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
