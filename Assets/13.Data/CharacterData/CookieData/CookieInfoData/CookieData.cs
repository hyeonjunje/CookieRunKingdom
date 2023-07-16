using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;

public enum ECookieGrade { Common, Rare, Epic, SuperEpic, Ancient, Legendary, Dragon, Enemy }
public enum ECookieType { Assault, Defense, Magic, Infiltration, Ranged, Headling, Explosion, Support, Enemy }
public enum ECookiePosition { Front, Center, Rear }

[CreateAssetMenu]
public class CookieData : CharacterData
{
    [SerializeField] private int _cookieIndex;

    [SerializeField] private string _appearSpeech;
    [SerializeField] private string _bubbleSpeech;

    [SerializeField] private SkeletonDataAsset _cookiePortraitSkeleton;

    [SerializeField] private Material _idleBlackMaterial;

    [SerializeField] private Sprite _cookieHeadSprite;
    [SerializeField] private Sprite _idleSprite;
    [SerializeField] private Sprite _skillSprite;
    [SerializeField] private string _skillName;

    [SerializeField] private Sprite _typeSprite;
    [SerializeField] private Sprite _evolutionSprite;

    [SerializeField] private Sprite _cookieGradeSprite;

    [SerializeField] private ECookieGrade _cookieGrade;
    [SerializeField] private ECookieType _cookieType;
    [SerializeField] private ECookiePosition _cookiePosition;

    [Header("������")]
    [SerializeField] private ItemData _expCandyItemData;

    public int CookieIndex => _cookieIndex;

    public string AppearSpeech => _appearSpeech;
    public string BubbleSpeech => _bubbleSpeech;

    public SkeletonDataAsset CookiePortrait => _cookiePortraitSkeleton;
    public Material IdleBlackMaterial => _idleBlackMaterial;
    public Sprite CookieHeadSprite => _cookieHeadSprite;
    public Sprite IdleSprite => _idleSprite;
    public Sprite SKillSprite => _skillSprite;
    public string SKillName => _skillName;
    public Sprite TypeSprite => _typeSprite;
    public Sprite EvolutionSprite => _evolutionSprite;
    public Sprite CookieGradeSprite => _cookieGradeSprite;

    public ECookieGrade CookieGrade => _cookieGrade;
    public ECookieType CookieType => _cookieType;
    public ECookiePosition CookiePosition => _cookiePosition;

    public ItemData ExpCandyItemData => _expCandyItemData;

    public string CookieGradeName
    {
        get
        {
            switch (CookieGrade)
            {
                case ECookieGrade.Common:
                    return "COMMON";
                case ECookieGrade.Rare:
                    return "RARE";
                case ECookieGrade.Epic:
                    return "EPIC";
            }
            return "";
        }
    }

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
