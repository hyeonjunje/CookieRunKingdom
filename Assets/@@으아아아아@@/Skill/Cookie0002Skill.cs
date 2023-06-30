using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0002Skill : BaseSkill
{
    [SerializeField] protected DetectRange _detectSkillRange;
    private List<CharacterBattleController> targets => _detectSkillRange.enemies;
    private int _skillIndex = 0;
    private float _currentTime = 0;

    private int _currentCount = 0;
    private int _attackCount = 6;
    private float _duration = 3f;

    public virtual void SetLater(LayerMask enemyLayer)
    {
        base.SetLayer(enemyLayer);
        _detectSkillRange.Init(enemyLayer);
    }

    public override void NormalAttack()
    {
        SingleAttack();
    }

    public override void OnSkillEvent(int index)
    {

    }

    // false면 스킬 종료
    public override bool UseSkill()
    {
        // 딸쿠는 그냥 돌면서 때려야 해
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++]);
        }
        else 
        {
            _currentTime += Time.deltaTime;

            if(_currentTime >= _duration * _currentCount / _attackCount)
            {
                for (int i = 0; i < targets.Count; i++)
                    targets[i].CurrentHp -= 700;
                _currentCount++;
            }

            if(_currentTime >= _duration)
            {
                _skillIndex = 0;
                _currentCount = 0;
                return false;
            }
        }
        return true;
    }
}
