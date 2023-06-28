using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Reflection;

[CreateAssetMenu]
public class CookieAnimationData : ScriptableObject
{
    [Header("¿Õ±¹")]

    [Header("ÀüÅõ")]
    [SerializeField] private string battleIdle;
    [SerializeField] private string battleRun;
    [SerializeField] private string battleAttack;
    // [SerializeField] private string skill1;
    [SerializeField] private string dead;
    [SerializeField] private string victory;
    [SerializeField] private string defeat;

    public string BattleIdle { get => battleIdle; }
    public string BattleRun { get => battleRun; }
    public string BattleAttack { get => battleAttack; }
    // public string Skill1 { get => skill1; }
    public string Dead { get => dead; }
    public string Victory { get => victory; }
    public string Defeat { get => defeat; }


    public string[] Init()
    {
        PropertyInfo[] properties = this.GetType().GetProperties();

        // nameÀÌ¶û hideflag¸¦ »©¾ßÇÔ
        string[] animations = new string[properties.Length - 2];

        for(int i = 0; i < animations.Length; i++)
            animations[i] = (string)properties[i].GetValue(this);

        return animations;
    }
}
