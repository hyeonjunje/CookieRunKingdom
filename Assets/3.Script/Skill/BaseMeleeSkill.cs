using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseMeleeSkill : BaseSkill
{
    public override void NormalAttackEvent()
    {
        // ������ �ִ� �� �������� ������.
        CharacterBattleController target = DetectTarget();
        if (target != null)
        {
            target.ChangeCurrentHp(-AttackPower, _controller.CharacterStat);
        }
    }

    public override void OnSkillEvent(int index)
    {

    }

    public override bool UseSkill()
    {
        return true;
    }
}
