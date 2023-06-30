using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class BaseSkill : MonoBehaviour
{
    public bool isSkillUse = false;

    // 스킬의 애니메이션 이름
    public string[] animationName;

    public string[] attackEvent;
    public string[] skillEvent;

    [SerializeField] protected DetectRange _detectAttackRange;

    protected BaseController _controller;

    public void Init(BaseController controller)
    {
        _controller = controller;
    }

    public virtual void SetLayer(LayerMask enemyLayer)
    {
        _detectAttackRange.Init(enemyLayer);
    }

    // 기본 공격
    public abstract void NormalAttack();

    // 스킬
    public abstract bool UseSkill();

    // 스킬 이벤트
    public abstract void OnSkillEvent(int index);

    public CharacterBattleController DetectTarget()
    {
        if (_detectAttackRange.enemies.Count != 0)
            return _detectAttackRange.enemies[0];
        return null;
    }

    protected void SingleAttack()
    {
        if(_detectAttackRange.enemies.Count != 0)
            _detectAttackRange.enemies[0].CurrentHp -= 1000;
    }

    protected void PlayAnimation(string animationName)
    {
        _controller.CharacterAnimator.PlayAnimation(animationName);
    }
}
