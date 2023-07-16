using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamageBox : MonoBehaviour
{
    private bool _isPersistance;
    private int _damage;
    private LayerMask _targetLayer;
    private CharacterStat _characterStat;

    public void Init(int damage, LayerMask targetLayer ,CharacterStat characterStat , bool isPersistance = false)
    {
        _damage = damage;
        _targetLayer = targetLayer;
        _characterStat = characterStat;
        _isPersistance = isPersistance;
    }

    public void SetPower(int damage)
    {
        _damage = damage;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if(collision.gameObject.layer == _targetLayer)
        {
            CharacterBattleController target = collision.GetComponent<CharacterBattleController>();

            if(target != null)
            {
                target.ChangeCurrentHp(-_damage, _characterStat);
            }

            // 지속성이 없으면 한번 부딪히고 비활성화됨
            if(!_isPersistance)
                gameObject.SetActive(false);
        }
    }
}
