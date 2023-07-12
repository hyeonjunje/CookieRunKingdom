using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class WaveInfo
{
    public BaseController[] enemies = new BaseController[15];
    public int distance = 0;
}

[CreateAssetMenu]
public class StageData : ScriptableObject
{
    [Header("스테이지의 정보")]
    [SerializeField] private string _stageName;
    [SerializeField] private float _recommendedPower;
    [SerializeField] private int _jelly;
    
    [Header("Wave 정보")]
    [Space(10)]
    [SerializeField] private WaveInfo[] _waveInfo;
    
    [Header("맵 정보")]
    [Space(10)]
    // 순서는 center1 => left1 1~5 => right1 1~5
    //        center2 => left2 1~5 => right2 1~5
    //        center3 => left3 1~5 => right3 1~5
    [SerializeField] private Sprite[] _mapSprites;

    [SerializeField] private Sprite[] _closeObjectSprites;   // 1
    [SerializeField] private Sprite[] _middleObjectSprites;  // 2
    [SerializeField] private Sprite[] _farObjectSprites;     // 3


    public string StageName => _stageName;
    public float RecommendedPower => _recommendedPower;
    public int Jelly => _jelly;
    public WaveInfo[] WaveInfo => _waveInfo;
    public Sprite[] MapSprites => _mapSprites;

    public Sprite[] CloseObjectSprites => _closeObjectSprites;
    public Sprite[] MiddleObjectSprites => _middleObjectSprites;
    public Sprite[] FarObjectSprites => _farObjectSprites;
}
