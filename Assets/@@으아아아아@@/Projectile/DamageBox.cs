using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamageBox : MonoBehaviour
{
    private int _damage;
    private LayerMask _targetLayer;

    public void Init(int damage, LayerMask targetLayer)
    {
        _damage = damage;
        _targetLayer = targetLayer;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if(collision.gameObject.layer == _targetLayer)
        {
            CharacterBattleController target = collision.GetComponent<CharacterBattleController>();

            if(target != null)
                target.CurrentHp -= _damage;
        }
    }
}
