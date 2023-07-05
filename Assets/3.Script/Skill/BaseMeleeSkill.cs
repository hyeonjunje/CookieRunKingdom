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
            target.CurrentHp -= AttackPower;
    }

    public override void OnSkillEvent(int index)
    {

    }

    public override bool UseSkill()
    {
        return true;
    }
}
