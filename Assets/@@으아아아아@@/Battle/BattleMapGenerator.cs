using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleMapGenerator : MonoBehaviour
{
    [SerializeField] private Transform[] _battleMapTile;

    private StageData _stageData;
    public void GenerateBattleMap(StageData stageData)
    {
        _stageData = stageData;

        GenerateBattleTile();
        GenerateBattleObject();
    }

    private void a(int count)
    {
        Transform pieceParent = new GameObject("Piece" + count).transform;
        pieceParent.gameObject.AddComponent<MapPiece>();
        pieceParent.SetParent(transform);

        BoxCollider2D col = pieceParent.gameObject.AddComponent<BoxCollider2D>();
        col.isTrigger = true;
        col.offset = new Vector2(3, 3);
        col.size = new Vector2(10, 1);

        for (int i = 0; i < _battleMapTile.Length; i++)
        {
            GameObject tile = new GameObject(_battleMapTile[i].name);
            tile.transform.SetParent(pieceParent);
            tile.transform.position = _battleMapTile[i].position;
            SpriteRenderer tileSR = tile.AddComponent<SpriteRenderer>();
            tileSR.sortingOrder = -i - 1000;
            tileSR.sprite = _stageData.MapSprites[i];

            if(i % 11 == 1) // 가깝다
                CreateObject(_stageData.CloseObjectSprites[Random.Range(0, _stageData.CloseObjectSprites.Length)], tile.transform, Vector3.up, Vector3.one * 0.5f, true);
            else if(i % 11 == 2) // 중간
            {
                if (Random.Range(0, 3) == 0)
                    CreateObject(_stageData.MiddleObjectSprites[Random.Range(0, _stageData.MiddleObjectSprites.Length)], tile.transform, Vector3.zero, Vector3.one * 0.5f);
            }
            else if (i % 11 == 3) // 멀다
                CreateObject(_stageData.FarObjectSprites[Random.Range(0, _stageData.FarObjectSprites.Length)], tile.transform, Vector3.up, Vector3.one);
            else if(i % 11 == 6) // 가깝다
                CreateObject(_stageData.CloseObjectSprites[Random.Range(0, _stageData.CloseObjectSprites.Length)], tile.transform, -Vector3.up, Vector3.one * 0.5f, true);
            else if(i % 11 == 8) // 멀다
                CreateObject(_stageData.FarObjectSprites[Random.Range(0, _stageData.FarObjectSprites.Length)], tile.transform, -Vector3.up, Vector3.one);
        }
    }

    private void CreateObject(Sprite sprite, Transform parent, Vector3 pos, Vector3 size, bool isBoid = false)
    {
        if(isBoid)
        {
            for(int i = 0; i < 3; i++)
            {
                GameObject obj = new GameObject();
                obj.transform.SetParent(parent);
                obj.transform.localPosition = pos + (Vector3)(Random.insideUnitCircle * 1.5f);
                obj.transform.localScale = size;
                SpriteRenderer sr = obj.AddComponent<SpriteRenderer>();
                sr.sortingOrder = -100;
                sr.sprite = sprite;
            }
        }
        else
        {
            GameObject obj = new GameObject();
            obj.transform.SetParent(parent);
            obj.transform.localPosition = pos;
            obj.transform.localScale = size;
            SpriteRenderer sr = obj.AddComponent<SpriteRenderer>();
            sr.sortingOrder = -100;
            sr.sprite = sprite;
        }
    }

    // 타일만
    private void GenerateBattleTile()
    {
        for(int i = 1; i <= 6; i++)
        {
            a(i);
        }
    }

    // 맵 오브젝트(구조물 같은거... 나무, 해바라기)
    private void GenerateBattleObject()
    {

    }
}
