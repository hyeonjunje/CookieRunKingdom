using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundGenerator : MonoBehaviour
{
    [SerializeField] private Tilemap tilemapPrefab;

    [SerializeField] private Sprite crackerTilemap;

    [SerializeField] private Transform[] startPoint;
    [SerializeField] private Transform[] endPoint;

    private void Start()
    {
        GenerateGround();
    }

    private void GenerateGround()
    {
        int length = startPoint.Length;

        for(int i = 0; i < length; i++)
        {

        }
    }
}
