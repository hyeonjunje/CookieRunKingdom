using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0058Skill : BaseMeleeSkill
{
    [SerializeField] private DetectRange _detectedSkillRange;

    public int _onionPower = 0;

    private int _skillIndex = 0;

    public override void Init(BaseController controller)
    {
        base.Init(controller);
    }

    public override bool IsReadyToUseSkill()
    {
        return _onionPower >= 1 && _detectedSkillRange.enemies.Count != 0;
    }

    public override void NormalAttack()
    {
        base.NormalAttack();
    }

    public override void NormalAttackEvent()
    {
        _onionPower++;
    }

    public override void OnSkillEvent(int index)
    {
        base.OnSkillEvent(index);

        _detectedSkillRange.enemies.ForEach(target => target.CurrentHp -= 1000 * _onionPower);
        _onionPower = 0;
    }

    public override void SetLayer(LayerMask layer)
    {
        base.SetLayer(layer);
        _detectedSkillRange.Init(layer);
    }

    public override bool UseSkill()
    {
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++], false);
        }
        else if(_skillIndex == 1)
        {
            if (!_controller.CharacterAnimator.IsPlayingAnimation())
            {
                _skillIndex = 0;
                return false;
            }
        }

        return true;
    }
}
