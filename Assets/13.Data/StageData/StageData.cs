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
    [SerializeField] private string _stageName;
    [SerializeField] private float _recommendedPower;
    [SerializeField] private int _jelly;
    [SerializeField] private WaveInfo[] _waveInfo;

    public WaveInfo[] WaveInfo => _waveInfo;
    public string StageName => _stageName;
    public float RecommendedPower => _recommendedPower;
    public int Jelly => _jelly;
}
