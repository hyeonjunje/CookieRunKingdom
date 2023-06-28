using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ECookieGrade { Common, Rare, Epic, SuperEpic, Ancient, Legendary, Dragon}
public enum ECookieType { Assault, Defense, Magic, Infiltration, Ranged, Headling, Explosion, Support }
public enum ECookiePosition { Front, Center, Rear}

[CreateAssetMenu]
public class CookieData : ScriptableObject
{
    [SerializeField] private string cookieName;
    [SerializeField] private ECookieGrade cookieGrade;
    [SerializeField] private ECookieType cookieType;
    [SerializeField] private ECookiePosition cookiePosition;
    [SerializeField] private CookieAnimationData cookieAnimationData;

    [SerializeField] private float moveSpeed;
    [SerializeField] private float detectRange;
    [SerializeField] private float attackRange;

    public string CookieName => cookieName;
    public ECookieGrade CookieGrade => cookieGrade;
    public ECookieType CookieType => cookieType;
    public ECookiePosition CookiePosition => cookiePosition;
    public CookieAnimationData CookieAnimationData => cookieAnimationData;
    public float MoveSpeed => moveSpeed;
    public float DetectRange => detectRange;
    public float AttackRange => attackRange;
}
