using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class ItemData : ScriptableObject
{
    [SerializeField] private Sprite itemImage;
    [SerializeField] private string itemName;
    [SerializeField] private string itemType;
    [Multiline(5)]
    [SerializeField] private string itemExplain;
}
