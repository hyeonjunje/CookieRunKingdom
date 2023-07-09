using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;

public class BuildingData : ScriptableObject
{
    [SerializeField] private int _buildingIndex;

    [SerializeField] private SkeletonDataAsset _skeletonData;

    [SerializeField] protected string buildingName;
    [Multiline(5)] [SerializeField] protected string buildingExplain;
    [SerializeField] protected Vector2Int buildingSize;
    [SerializeField] protected int buildingScore;
    [SerializeField] protected CraftData[] craftItems;

    // ������Ƽ
    public int BuildingIndex => _buildingIndex;

    public SkeletonDataAsset SkeletonData => _skeletonData;
    public string BuildingName => buildingName;
    public string BuildingExplain => buildingExplain;
    public Vector2Int BuildingSize => buildingSize;
    public int BuildingScore => buildingScore;
    public CraftData[] CraftItems => craftItems;
}
