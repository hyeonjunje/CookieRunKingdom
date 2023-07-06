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
                    return "������"; 
                case ECookieType.Defense:
                    return "�����";
                case ECookieType.Magic:
                    return "������";
                case ECookieType.Infiltration:
                    return "ħ����";
                case ECookieType.Ranged:
                    return "�����";
                case ECookieType.Headling:
                    return "ȸ����";
                case ECookieType.Explosion:
                    return "������";
                case ECookieType.Support:
                    return "������";
                case ECookieType.Enemy:
                    return "��";
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
                    return "����";
                case ECookiePosition.Center:
                    return "�߾�";
                case ECookiePosition.Rear:
                    return "�Ĺ�";
            }
            return "";
        }
    }
}
