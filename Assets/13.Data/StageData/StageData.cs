using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;

[System.Serializable]
public class WaveInfo
{
    public BaseController[] enemies = new BaseController[15];
    public int distance = 0;
}

[CreateAssetMenu]
public class StageData : ScriptableObject
{
    [Header("���������� ����")]
    [SerializeField] private bool _isBoss;
    [SerializeField] private SkeletonAnimation _bossSkeletonAnimation;


    [SerializeField] private string _stageName;
    [SerializeField] private float _recommendedPower;
    [SerializeField] private int _jelly;
    
    [Header("Wave ����")]
    [Space(10)]
    [SerializeField] private WaveInfo[] _waveInfo;
    
    [Header("�� ����")]
    [Space(10)]
    // ������ center1 => left1 1~5 => right1 1~5
    //        center2 => left2 1~5 => right2 1~5
    //        center3 => left3 1~5 => right3 1~5
    [SerializeField] private Sprite[] _mapSprites;

    [SerializeField] private Sprite[] _closeObjectSprites;   // 1
    [SerializeField] private Sprite[] _middleObjectSprites;  // 2
    [SerializeField] private Sprite[] _farObjectSprites;     // 3

    [Header("���� ����")]
    [Space(10)]
    [SerializeField] private ItemBundle[] _victoryRewardItems;
    [SerializeField] private ItemBundle[] _defeatRewardItems;

    public bool IsBoss => _isBoss;
    public SkeletonAnimation BossSkeletonAnimation => _bossSkeletonAnimation;
    public string StageName => _stageName;
    public float RecommendedPower => _recommendedPower;
    public int Jelly => _jelly;
    public WaveInfo[] WaveInfo => _waveInfo;
    public Sprite[] MapSprites => _mapSprites;
    public Sprite[] CloseObjectSprites => _closeObjectSprites;
    public Sprite[] MiddleObjectSprites => _middleObjectSprites;
    public Sprite[] FarObjectSprites => _farObjectSprites;
    public ItemBundle[] VictoryRewardItems => _victoryRewardItems;
    public ItemBundle[] DefeatRewardItems => _defeatRewardItems;
}
