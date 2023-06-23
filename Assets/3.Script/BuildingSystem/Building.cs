using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Building : MonoBehaviour
{
    [SerializeField] private Vector2Int size;
    private List<SpriteRenderer> buildingPreviewTiles;

    private Grid grid => GridManager.instance.Grid;

    // 클릭 시 buildingPreviewTiles가 정해짐
    public void OnClick()
    {
        buildingPreviewTiles = BuildingPreviewTileObjectPool.instance.GetPreviewTile(size, transform);
        RelocationTile();
        UpdatePreviewTile();
    }

    // buildingPreviewTilese 업데이트 (유효한 곳 흰색, 안되는 곳 빨간색)
    public void UpdatePreviewTile()
    {
        for(int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            bool check = GridManager.instance.UpdateTileColor(gridPos.x, gridPos.y);

            Color color = Color.white;

            // 흰색  아니면   빨간색
            if(check)
                color = Color.white;
            else
                color = Color.red;

            color.a = 0.5f;
            buildingPreviewTiles[i].color = color;
        }
    }


    public void PutBuilding()
    {
        for(int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            GridManager.instance.UpdateTile(gridPos.x, gridPos.y, false);
        }

        UpdatePreviewTile();
    }


    // buildingPreviewTiles 재배치
    private void RelocationTile()
    {
        Vector3 offset = Vector3.up * -0.6f;
        float tileX = buildingPreviewTiles[0].transform.localScale.x / 2;
        float tileY = buildingPreviewTiles[0].transform.localScale.y / 4;

        for (int y = 0; y < size.y; y++)
        {
            for(int x = 0; x < size.x; x++)
            {
                int index = x + size.y * y;
                buildingPreviewTiles[index].transform.localPosition = offset + new Vector3(tileX * x, -tileY * x, 0f);
            }
            offset -= new Vector3(tileX, tileY, 0);
        }
    }
}
