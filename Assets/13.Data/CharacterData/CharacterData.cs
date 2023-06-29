using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class CharacterData : ScriptableObject
{
    [SerializeField] private string _characterName;
    [SerializeField] private AnimationData _animationData;

    [SerializeField] private float moveSpeed;
    [SerializeField] private float attackRange;

    public string CharacterName => _characterName;
    public AnimationData AnimationData => _animationData;
    public float MoveSpeed => moveSpeed;
    public float AttackRange => attackRange;
}
