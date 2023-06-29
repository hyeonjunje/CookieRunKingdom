using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class WaveInfo
{
    public BaseController[] enemies = new BaseController[15];
}

[CreateAssetMenu]
public class StageData : ScriptableObject
{
    [SerializeField] private WaveInfo[] _waveInfo;

    public WaveInfo[] WaveInfo => _waveInfo;
}
