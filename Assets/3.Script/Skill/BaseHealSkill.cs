using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseHealSkill : BaseSkill
{
    public override void NormalAttackEvent()
    {
        // ���� ������ ��Ű���� ȸ���� ���ݴϴ�.

        List<CookieController> cookies = BattleManager.instance.CookiesInBattleList;
        BaseController selectedCookie = cookies[0];
        for (int i = 0; i < cookies.Count; i++)
            if(selectedCookie.CharacterBattleController.CurrentHp >= cookies[i].CharacterBattleController.CurrentHp)
                selectedCookie = cookies[i];

        selectedCookie.CharacterBattleController.ChangeCurrentHp(AttackPower, _controller.CharacterStat);
    }

    public override void OnSkillEvent(int index)
    {

    }

    public override bool UseSkill()
    {
        return true;
    }
}
