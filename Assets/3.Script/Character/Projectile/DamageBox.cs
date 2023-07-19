using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamageBox : MonoBehaviour
{
    private bool _isPersistance;
    private int _damage;
    private LayerMask _targetLayer;
    private CharacterStat _characterStat;
    private ECCType _ccType;
    private Vector3 _dir;

    public void Init(int damage, LayerMask targetLayer ,CharacterStat characterStat , bool isPersistance = false, ECCType ccType = ECCType.none, Vector3 dir = default(Vector3))
    {
        _damage = damage;
        _targetLayer = targetLayer;
        _characterStat = characterStat;
        _isPersistance = isPersistance;
        _ccType = ccType;
        _dir = dir;
    }

    public void SetPower(int damage)
    {
        _damage = damage;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if(collision.gameObject.layer == _targetLayer)
        {
            Debug.Log("�̰� ����??");

            CharacterBattleController target = collision.GetComponent<CharacterBattleController>();

            if(target != null)
            {
                target.ChangeCurrentHp(-_damage, _characterStat);

                // CC��!!
                if(_ccType != ECCType.none)
                    target.SetCC(_ccType, _dir);
            }

            // ���Ӽ��� ������ �ѹ� �ε����� ��Ȱ��ȭ��
            if(!_isPersistance)
                gameObject.SetActive(false);
        }
    }
}
