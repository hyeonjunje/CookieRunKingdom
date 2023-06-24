using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CraftItemData : ScriptableObject
{
    [SerializeField] private Sprite itemImage;
    [SerializeField] private float productionTime;
    [SerializeField] private int productionCost;
}
