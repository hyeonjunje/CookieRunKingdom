using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EStat
{
    hp, attack, defense, criticlal, size
}

public class CharacterStat : MonoBehaviour
{
    // �����Ұ� �̰�
    // ������, ü��, ���ݷ�, ����, ġ��Ÿ Ȯ��


    // ������ �̰�
    // ���ݷ�, ����, ü��, ���ݼӵ�, ġ��Ÿ Ȯ��
    // ��Ÿ��, ���ذ���, ġ��Ÿ ���ذ���,
    // �̷ο� ȿ�� ����, �طο� ȿ�� ����

    // ��ų�������ϸ� �� 4% ���� ����
    // �������ϸ� �� 4.5% ���� ����
    // �±��ϸ� �� 5% ���� ����

    public int powerStat => attackStat.ResultStat + defenseStat.ResultStat;
    public Stat hpStat;
    public Stat attackStat;
    public Stat defenseStat;
    public Stat criticalStat;

    private Stat[] _stats;
    private BaseController _controller;

    public void Init(BaseController controller)
    {
        _controller = controller;

        hpStat = new Stat(_controller.Data.HpStat);
        attackStat = new Stat(_controller.Data.AttackStat);
        defenseStat = new Stat(_controller.Data.DefenseStat);
        criticalStat = new Stat(_controller.Data.CriticalStat);

        _stats = new Stat[(int)EStat.size];
        _stats[0] = hpStat;
        _stats[1] = attackStat;
        _stats[2] = defenseStat;
        _stats[3] = criticalStat;
    }

    public void LevelUP()
    {
        for(int i = 0; i < _stats.Length; i++)
        {
            _stats[i].LevelUpStat();
        }
    }

    public void Evolution()
    {
        for(int i = 0; i < _stats.Length; i++)
        {
            _stats[i].EvolutionStat();
        }
    }

    public void SkillLevelUp()
    {
        // ũ��Ƽ�� ����
        for (int i = 0; i < _stats.Length - 1; i++)
        {
            _stats[i].SkillLevelUpStat();
        }
    }
}
