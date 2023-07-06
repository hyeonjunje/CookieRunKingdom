using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ECookieGrade { Common, Rare, Epic, SuperEpic, Ancient, Legendary, Dragon, Enemy }
public enum ECookieType { Assault, Defense, Magic, Infiltration, Ranged, Headling, Explosion, Support, Enemy }
public enum ECookiePosition { Front, Center, Rear }

public class CookieData : CharacterData
{
    [SerializeField] private Material _idleBlackMaterial;

    [SerializeField] private Sprite _idleSprite;
    [SerializeField] private Sprite _skillSprite;

    [SerializeField] private Sprite _typeSprite;
    [SerializeField] private Sprite _evolutionSprite;

    [SerializeField] private Sprite _cookieGradeSprite;

    [SerializeField] private ECookieGrade _cookieGrade;
    [SerializeField] private ECookieType _cookieType;
    [SerializeField] private ECookiePosition _cookiePosition;

    public Material IdleBlackMaterial => _idleBlackMaterial;

    public Sprite IdleSprite => _idleSprite;
    public Sprite SKillSprite => _skillSprite;
    public Sprite TypeSprite => _typeSprite;
    public Sprite EvolutionSprite => _evolutionSprite;
    public Sprite CookieGradeSprite => _cookieGradeSprite;

    public ECookieGrade CookieGrade => _cookieGrade;
    public ECookieType CookieType => _cookieType;
    public ECookiePosition CookiePosition => _cookiePosition;


    public string CookieTypeName
    {
        get
        {
            switch (CookieType)
            {
                case ECookieType.Assault:
                    return "돌격형"; 
                case ECookieType.Defense:
                    return "방어형";
                case ECookieType.Magic:
                    return "마법형";
                case ECookieType.Infiltration:
                    return "침투형";
                case ECookieType.Ranged:
                    return "사격형";
                case ECookieType.Headling:
                    return "회복형";
                case ECookieType.Explosion:
                    return "폭발형";
                case ECookieType.Support:
                    return "지원형";
                case ECookieType.Enemy:
                    return "적";
            }
            return "";
        }
    }

    public string CookiePositionName
    {
        get
        {
            switch (CookiePosition)
            {
                case ECookiePosition.Front:
                    return "전방";
                case ECookiePosition.Center:
                    return "중앙";
                case ECookiePosition.Rear:
                    return "후방";
            }
            return "";
        }
    }
}
