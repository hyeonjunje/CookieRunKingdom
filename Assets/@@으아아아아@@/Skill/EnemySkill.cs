using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySkill : BaseSkill
{
    public override void NormalAttack()
    {
        SingleAttack();
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
