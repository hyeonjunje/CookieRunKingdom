using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingData : ScriptableObject
{
    [SerializeField] protected string buildingName;
    [SerializeField] protected Vector2Int buildingSize;
    [SerializeField] protected CraftData[] craftItems;

    // 프로퍼티
    public string BuildingName => buildingName;
    public Vector2Int BuildingSize => buildingSize;
    public CraftData[] CraftItems => craftItems;
}
