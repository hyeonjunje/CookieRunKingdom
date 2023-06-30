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

    // �⺻ ����
    public abstract void NormalAttack();

    // ��ų
    public abstract bool UseSkill();

    // ��ų �̺�Ʈ
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
