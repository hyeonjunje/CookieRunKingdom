using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ECookieGrade { Common, Rare, Epic, SuperEpic, Ancient, Legendary, Dragon, Enemy }
public enum ECookieType { Assault, Defense, Magic, Infiltration, Ranged, Headling, Explosion, Support, Enemy }
public enum ECookiePosition { Front, Center, Rear }

public class CookieData : CharacterData
{
    [SerializeField] private Sprite _idleSprite;
    [SerializeField] private Sprite _skillSprite;

    [SerializeField] private ECookieGrade _cookieGrade;
    [SerializeField] private ECookieType _cookieType;
    [SerializeField] private ECookiePosition _cookiePosition;

    public Sprite IdleSprite => _idleSprite;
    public Sprite SKillSprite => _skillSprite;

    public ECookieGrade CookieGrade => _cookieGrade;
    public ECookieType CookieType => _cookieType;
    public ECookiePosition CookiePosition => _cookiePosition;
}
