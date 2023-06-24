using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class ResultItem
{
    public ItemData ingredientItem;
    public int count;
}

[CreateAssetMenu]
public class CraftData : ScriptableObject
{
    [SerializeField] private Sprite craftImage;
    [SerializeField] private string craftName;

    [SerializeField] private bool isResource;

    [SerializeField] private ResultItem craftResult;
    [SerializeField] private ResultItem[] ingredients;
    [SerializeField] private float craftTime;
    [SerializeField] private float craftCost;

    public Sprite CraftImage => craftImage;
    public string CraftName => craftName;
    public bool IsResource => isResource;
    public ResultItem CraftResult => craftResult;
    public ResultItem[] Ingredients => ingredients;
    public float CraftTime => craftTime;
    public float CraftCost => craftCost;
}
