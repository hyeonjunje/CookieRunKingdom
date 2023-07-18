using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// ���������Ҹ� ��Ű
public class Cookie0513Skill : BaseRangeSkill
{
    [SerializeField] private ProjectileCoffee _skillProjectile;

    private int _skillIndex = 0;

    public override void Init(BaseController controller)
    {
        base.Init(controller);
    }

    public override bool IsReadyToUseSkill()
    {
        return base.IsReadyToUseSkill();
    }

    public override void NormalAttack()
    {
        base.NormalAttack();
    }

    public override void NormalAttackEvent()
    {
        base.NormalAttackEvent();
    }

    public override void OnSkillEvent(int index)
    {
        _skillProjectile.gameObject.SetActive(true);
    }

    public override void SetLayer(LayerMask layer)
    {
        base.SetLayer(layer);
        _skillProjectile.Init(AttackPower, layer, transform, new Vector3(6f, 3f, 0), _controller.CharacterStat);
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
