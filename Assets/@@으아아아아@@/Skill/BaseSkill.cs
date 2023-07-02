using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class BaseSkill : MonoBehaviour
{
    public bool isSkillUse = false;

    // ��ų�� �ִϸ��̼� �̸�
    public string[] animationName;
    public string[] attackEvent;
    public string[] skillEvent;

    protected BaseController _controller;
    [SerializeField] protected DetectRange _detectAttackRange;

    public virtual void Init(BaseController controller)
    {
        _controller = controller;
    }

    public virtual void SetLayer(LayerMask layer)
    {
        _detectAttackRange.Init(layer);
    }

    // �⺻ ����
    public abstract void NormalAttack();

    // ��ų
    public abstract bool UseSkill();

    // ��ų �̺�Ʈ
    public abstract void OnSkillEvent(int index);

    // ��ų�� �� �� ������ true, �ƴϸ� false
    public virtual bool IsReadyToUseSkill()
    {
        return true;
    }

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
