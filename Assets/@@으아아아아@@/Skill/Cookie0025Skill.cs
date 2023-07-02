using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0025Skill : BaseSkill
{
    [SerializeField] private ProjectileMagicCircle _projectile;

    private float CurrentSkillTime => _controller.CharacterAnimator.GetIntervalAnimation();
    private int _skillIndex = 0;
    private float _currentTime = 0;

    public override void Init(BaseController controller)
    {
        base.Init(controller);
    }

    public override void SetLayer(LayerMask layer)
    {
        base.SetLayer(layer);
        _projectile.Init(1500, layer, _controller.CharacterBattleController.IsForward, transform, new Vector3(3f, 1.5f, 0));
    }

    public override void NormalAttack()
    {
        SingleAttack();
    }

    public override void OnSkillEvent(int index)
    {
        if(index == 0)
        {
            // 투사체 발사!
            _projectile.gameObject.SetActive(true);
        }
    }

    public override bool IsReadyToUseSkill()
    {
        return _detectAttackRange.enemies.Count != 0;
    }

    public override bool UseSkill()
    {
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
        }
        else if(_skillIndex != 0)
        {
            _currentTime += Time.deltaTime;

            if(_currentTime >= CurrentSkillTime)
            {
                _currentTime = 0;
                _skillIndex = 0;
                return false;
            }
        }

        return true;
    }
}
