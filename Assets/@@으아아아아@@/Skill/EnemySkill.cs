using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySkill : BaseMeleeSkill
{
    public override void NormalAttack()
    {
        base.NormalAttack();
    }

    public override void OnSkillEvent(int index)
    {

    }

    // 스킬 상태에 돌입할 때 실행, 애니메이션이 끝날 때 isSkillUse가 true라면 실행
    public override bool UseSkill()
    {
        return false;
    }
}
