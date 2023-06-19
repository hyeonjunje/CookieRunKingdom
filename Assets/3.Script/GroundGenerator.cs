using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundGenerator : MonoBehaviour
{
    [SerializeField] private SpriteRenderer tilemapPrefab;

    [SerializeField] private Sprite grassTilemap;
    [SerializeField] private Sprite crackerTilemap;

    [SerializeField] private Vector3 startPoint = Vector3.zero;
    [SerializeField] private Vector3 diff = new Vector3(1.25f, 0.63f, 0);
    [SerializeField] private float size = 50;

    private Sprite currentSprite;

    private void Start()
    {
        currentSprite = grassTilemap;
        GenerateGround();
    }

    private void GenerateGround()
    {
        for(int i = 0; i <= size; i++)
        {
            for(int j = 0; j <= size; j++)
            {
                SpriteRenderer tile = Instantiate(tilemapPrefab, transform);
                tile.sprite = currentSprite;
                tile.transform.localPosition = new Vector3(diff.x * (-j + i), diff.y * (-size + j + i), 0f);
                tile.transform.localRotation = Quaternion.identity;

                // currentSprite = currentSprite == grassTilemap ? crackerTilemap : grassTilemap;
            }
        }
    }
}
