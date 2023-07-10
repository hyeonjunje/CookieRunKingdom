using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Stat
{
    // ���� ����
    private float _baseStat;

    // �� �ɷ�ġ => �����̳�, ��ų���� �ø� �� ��ġ������ �ö󰡴� ����
    private float _kangStats;

    // �ۼ�Ʈ �ɷ�ġ => ���帶ũ, ���� ������ �ö󰡴� ����
    private float _percentStats;

    // ������ �Ͻ������� �ö󰡴� ����
    private float _tempPercentStats;

    public Stat(float baseStat, float kangStats = 0, float percentStats = 0, float tempPercentStats = 0)
    {
        _baseStat = baseStat;

        _kangStats = kangStats;
        _percentStats = percentStats;
        _tempPercentStats = tempPercentStats;
    }

    public void LevelUpStat()
    {
        _baseStat *= Utils.LevelUpInterest;
    }

    public void EvolutionStat()
    {
        _baseStat *= Utils.EvolutionInterest;
    }

    public void SkillLevelUpStat()
    {
        _baseStat *= Utils.SKillLevelUpInterest;
    }

    // ó�� �� ����
    public int ResultStat => Mathf.RoundToInt((_baseStat + _kangStats) * (1 + ((_percentStats + _tempPercentStats) / 100)));
}
