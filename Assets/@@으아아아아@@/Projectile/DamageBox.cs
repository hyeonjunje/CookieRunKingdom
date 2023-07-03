using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamageBox : MonoBehaviour
{
    private bool _isPersistance;
    private int _damage;
    private LayerMask _targetLayer;

    public void Init(int damage, LayerMask targetLayer , bool isPersistance = false)
    {
        _damage = damage;
        _targetLayer = targetLayer;
        _isPersistance = isPersistance;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if(collision.gameObject.layer == _targetLayer)
        {
            CharacterBattleController target = collision.GetComponent<CharacterBattleController>();

            if(target != null)
                target.CurrentHp -= _damage;

            // 지속성이 없으면 한번 부딪히고 비활성화됨
            if(!_isPersistance)
                gameObject.SetActive(false);
        }
    }
}
