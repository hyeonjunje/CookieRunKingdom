using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySkill : BaseMeleeSkill
{
    public override void NormalAttackEvent()
    {
        base.NormalAttackEvent();
    }

    public override void OnSkillEvent(int index)
    {

    }

    // ��ų ���¿� ������ �� ����, �ִϸ��̼��� ���� �� isSkillUse�� true��� ����
    public override bool UseSkill()
    {
        return false;
    }
}
