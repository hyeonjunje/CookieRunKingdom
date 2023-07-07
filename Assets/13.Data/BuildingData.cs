using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingData : ScriptableObject
{
    [SerializeField] protected string buildingName;
    [Multiline(5)] [SerializeField] protected string buildingExplain;
    [SerializeField] protected Vector2Int buildingSize;
    [SerializeField] protected int buildingScore;
    [SerializeField] protected CraftData[] craftItems;

    // 프로퍼티
    public string BuildingName => buildingName;
    public string BuildingExplain => buildingExplain;
    public Vector2Int BuildingSize => buildingSize;
    public int BuildingScore => buildingScore;
    public CraftData[] CraftItems => craftItems;
}
