using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseHealSkill : BaseSkill
{
    public override void NormalAttack()
    {
        // 가장 위급한 쿠키에게 회복을 해줍니다.

        List<BaseController> cookies = BattleManager.instance.CookiesInBattleList;
        BaseController selectedCookie = cookies[0];
        for (int i = 0; i < cookies.Count; i++)
            if(selectedCookie.CharacterBattleController.CurrentHp >= cookies[i].CharacterBattleController.CurrentHp)
                selectedCookie = cookies[i];

        selectedCookie.CharacterBattleController.CurrentHp += 500;
    }

    public override void OnSkillEvent(int index)
    {

    }

    public override bool UseSkill()
    {
        return true;
    }
}
