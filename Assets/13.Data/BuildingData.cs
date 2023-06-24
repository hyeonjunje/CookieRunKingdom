using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class BuildingData : ScriptableObject
{
    [SerializeField] private string buildingName;
    [SerializeField] private Vector2Int buildingSize;
    [SerializeField] private ItemData[] items;

    // ������Ƽ
    public string BuildingName => buildingName;
    public Vector2Int BuildingSize => buildingSize;
    public ItemData[] Items => items;
}
