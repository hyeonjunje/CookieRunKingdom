using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;
using Spine;


public class Cookie0035Skill : BaseMeleeSkill
{
    [SerializeField] private SkeletonAnimation _betSkeletonAnimation;

    [SerializeField] protected DetectRange _detectSkillRange;

    private int _skillIndex = 0;
    private Vector3 _prevPosition = Vector3.zero;
    private CharacterBattleController _target = null;

    public override void Init(BaseController controller)
    {
        base.Init(controller);
    }

    public override bool IsReadyToUseSkill()
    {
        return _detectSkillRange.enemies.Count != 0;
    }

    public override void NormalAttackEvent()
    {
        base.NormalAttackEvent();
        _controller.CharacterBattleController.CurrentHp += 1000;
    }

    public override void OnSkillEvent(int index)
    {
        base.OnSkillEvent(index);
    }

    public override void SetLayer(LayerMask layer)
    {
        base.SetLayer(layer);
        _detectSkillRange.Init(layer);
    }

    public override bool UseSkill()
    {
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++], false);
            _prevPosition = transform.position;

            // 타겟 정하기
            foreach(CharacterBattleController target in _detectSkillRange.enemies)
            {
                if (_target == null)
                    _target = target;
                else
                {
                    if(Vector3.Distance(transform.position, _target.transform.position) <
                        Vector3.Distance(transform.position, target.transform.position))
                    {
                        _target = target;
                    }
                }
            }
        }
        else if(_skillIndex == 1)
        {
            if(!_controller.CharacterAnimator.IsPlayingAnimation())
            {
                // 뱀파이어맛쿠키는 멀리 가버린다.
                transform.position = Vector3.up * 1000f;
                // 박쥐 애니메이션 
                _betSkeletonAnimation.gameObject.SetActive(true);
                Vector3 offset = _controller.CharacterBattleController.IsForward ? Utils.Dir * 0.1f : -Utils.Dir * 0.1f;
                _betSkeletonAnimation.transform.position = _target.transform.position + offset + Vector3.up * 0.8f;
                _betSkeletonAnimation.AnimationState.SetAnimation(0, animationName[_skillIndex++], false);
            }    
        }

        else if(_skillIndex == 2)
        {
            // 박쥐 애니메이션이 끝나면
            if(_betSkeletonAnimation.AnimationState.GetCurrent(0).IsComplete)
            {
                transform.position = _prevPosition;

                _betSkeletonAnimation.gameObject.SetActive(false);
                _target.CurrentHp -= 10000;
                _controller.CharacterBattleController.CurrentHp += 5000;

                PlayAnimation(animationName[_skillIndex++], false);
            }
        }
        else
        {
            if(!_controller.CharacterAnimator.IsPlayingAnimation())
            {
                _target = null;
                _skillIndex = 0;
                return false;
            }
        }
        return true;
    }
}
