using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cookie0063Skill : BaseHealSkill
{
    [SerializeField] private DetectRange _skillDetectRange;

    private int _skillIndex = 0;

    private Coroutine _coSkill = null;

    public override void Init(BaseController controller)
    {
        base.Init(controller);
    }

    public override bool IsReadyToUseSkill()
    {
        return DetectTarget();
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
        base.OnSkillEvent(index);

        // �� �ʰ� ȸ���ϴ� ���� �� ����� �ڷ�ƾ
        if(index == 0)
        {
            if (_coSkill != null)
                StopCoroutine(_coSkill);
            _coSkill = StartCoroutine(CoSKill());

            BattleManager.instance.CookiesInBattleList.ForEach
                (cookie => cookie.CharacterBattleController.ChangeCurrentHp(AttackPower, _controller.CharacterStat));
        }
    }

    public override void SetLayer(LayerMask layer)
    {
        base.SetLayer(layer);

        if (layer == LayerMask.NameToLayer("Cookie"))
            _skillDetectRange.Init(LayerMask.NameToLayer("Enemy"));
        else
            _skillDetectRange.Init(LayerMask.NameToLayer("Cookie"));
    }

    public override bool UseSkill()
    {
        if(_skillIndex == 0)
        {
            PlayAnimation(animationName[_skillIndex++], false);
        }
        else if(_skillIndex == 1)
        {
            if(!_controller.CharacterAnimator.IsPlayingAnimation())
            {
                _skillIndex = 0;
                return false;
            }
        }

        return true;
    }

    private IEnumerator CoSKill()
    {
        // ���� ��
        _skillDetectRange.transform.SetParent(null);
        _skillDetectRange.gameObject.SetActive(false);
        _skillDetectRange.gameObject.SetActive(true);

        for(int i = 0; i < _skillDetectRange.transform.childCount; i++)
        {
            Transform child = _skillDetectRange.transform.GetChild(i);
            float zPos = (child.position.x + child.position.y) / 100000f;
            child.position = new Vector3(child.position.x, child.position.y, zPos);
        }

        for (int i = 0; i < 5; i++)
        {
            yield return new WaitForSeconds(1f);

            _skillDetectRange.enemies.ForEach(cookie => cookie.ChangeCurrentHp(AttackPower, _controller.CharacterStat));
        }

        // ���� ��
        _skillDetectRange.gameObject.SetActive(false);
        _skillDetectRange.transform.SetParent(transform);
        _skillDetectRange.transform.localPosition = Vector3.zero;
    }
}
