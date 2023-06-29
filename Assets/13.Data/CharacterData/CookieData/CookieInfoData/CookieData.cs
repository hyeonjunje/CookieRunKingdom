using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ECookieGrade { Common, Rare, Epic, SuperEpic, Ancient, Legendary, Dragon, Enemy }
public enum ECookieType { Assault, Defense, Magic, Infiltration, Ranged, Headling, Explosion, Support, Enemy }
public enum ECookiePosition { Front, Center, Rear }

public class CookieData : CharacterData
{
    [SerializeField] private ECookieGrade _cookieGrade;
    [SerializeField] private ECookieType _cookieType;
    [SerializeField] private ECookiePosition _cookiePosition;

    public ECookieGrade CookieGrade => _cookieGrade;
    public ECookieType CookieType => _cookieType;
    public ECookiePosition CookiePosition => _cookiePosition;
}
