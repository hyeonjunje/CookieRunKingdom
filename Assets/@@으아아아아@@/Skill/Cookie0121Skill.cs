using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class Cookie0121Skill : BaseRangeSkill
{
    private float CurrentSkillTime => _controller.CharacterAnimator.GetIntervalAnimation();
    private int _skillIndex = 0;
    private float _currentTime = 0;

    [SerializeField] protected DetectRange _detectedSkilRange;
    [SerializeField] protected DetectRange _skillRange;

    private Vector3 _originPos = Vector3.zero;
    private CharacterBattleController _target;
    private int _skillAttackIndex = 0;

    public override void NormalAttack()
    {
        base.NormalAttack();
    }

    public override void SetLayer(LayerMask layer)
    {
        base.SetLayer(layer);
        _detectedSkilRange.Init(layer);
        _skillRange.Init(layer);
    }

    public override void OnSkillEvent(int index)
    {

    }

    // ��ų ������ ������ �Ǹ� �� �� ����� �� ����
    public override bool IsReadyToUseSkill()
    {
        return _detectedSkilRange.enemies.Count != 0;
    }

    public override bool UseSkill()
    {
        if(_currentTime == 0)
        {
            if (_skillIndex == 0)
            {
                PlayAnimation(animationName[_skillIndex]);
                foreach(CharacterBattleController target in _detectedSkilRange.enemies)
                {
                    // ���� �� Ÿ�� ����
                    if (_target == null)
                        _target = target;
                    else
                        if(Vector3.Distance(_target.transform.position, transform.position) < Vector3.Distance(target.transform.position, transform.position))
                           _target = target;
                }
            }
            else if (_skillIndex == 1)
            {
                PlayAnimation(animationName[_skillIndex]);

                if(_target != null)
                {
                    _originPos = transform.position;
                    transform.position = _target.transform.position;
                }
            }
        }

        if(_skillIndex == 1)
        {
            // ���� �ð� ���� ������ ���ظ� ��� ��

            if(_currentTime > (CurrentSkillTime / 4) * _skillAttackIndex )
            {
                foreach (CharacterBattleController target in _skillRange.enemies)
                {
                    target.CurrentHp -= 500;
                    _skillAttackIndex++;
                }
            }
        }

        _currentTime += Time.deltaTime;

        if(_currentTime >= CurrentSkillTime)
        {
            _currentTime = 0;
            _skillIndex++;

            if(_skillIndex == animationName.Length)
            {
                if (_originPos != Vector3.zero)
                    transform.position = _originPos;

                _currentTime = 0;
                _skillIndex = 0;

                return false;
            }
        }

        return true;
    }
}
