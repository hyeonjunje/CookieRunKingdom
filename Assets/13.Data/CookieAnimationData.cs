using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;


[CreateAssetMenu]
public class CookieAnimationData : ScriptableObject
{
    [Header("¿Õ±¹")]

    [Header("ÀüÅõ")]
    [SerializeField] private string battleIdle;
    [SerializeField] private string battleRun;
    [SerializeField] private string battleAttack;
    [SerializeField] private string skill1;
    [SerializeField] private string dead;
    [SerializeField] private string victory;
    [SerializeField] private string defeat;

    public string BattleIdle { get => battleIdle; }
    public string BattleRun { get => battleRun; }
    public string BattleAttack { get => battleAttack; }
    public string Skill1 { get => skill1; }
    public string Dead { get => dead; }
    public string Victory { get => victory; }
    public string Defeat { get => defeat; }

    // public List<string> animations
}
