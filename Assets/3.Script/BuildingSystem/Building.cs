using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;
using Spine;

public class Building : MonoBehaviour
{
    [SerializeField] private BuildingData buildingData;
    [SerializeField] private List<CraftingItemData> craftingItemData = new List<CraftingItemData>();

    private List<SpriteRenderer> buildingPreviewTiles;
    
    // ������Ƽ
    private Grid grid => GridManager.instance.Grid;
    public List<CraftingItemData> CraftingItemData => craftingItemData;
    public BuildingData Data => buildingData;

    public void Highlighgt(bool flag)
    {
        GetComponent<MeshRenderer>().sortingLayerID = flag ? 
            SortingLayer.NameToID("GridUpper") : SortingLayer.NameToID("Default");
    }

    // Ŭ�� �� buildingPreviewTiles�� ������
    public void OnClickEditMode()
    {
        buildingPreviewTiles = BuildingPreviewTileObjectPool.instance.GetPreviewTile(buildingData.BuildingSize, transform);
        RelocationTile();
        UpdatePreviewTile();
    }

    // buildingPreviewTilese ������Ʈ (��ȿ�� �� ���, �ȵǴ� �� ������)
    public void UpdatePreviewTile()
    {
        for(int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            bool check = GridManager.instance.UpdateTileColor(gridPos.x, gridPos.y);

            Color color = Color.white;

            // ���  �ƴϸ�   ������
            if(check)
                color = Color.white;
            else
                color = Color.red;

            color.a = 0.5f;
            buildingPreviewTiles[i].color = color;
        }
    }

    // �ǹ� ��ġ
    public void PutBuilding()
    {
        for(int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            GridManager.instance.UpdateTile(gridPos.x, gridPos.y, false);
        }

        UpdatePreviewTile();
    }


    // buildingPreviewTiles ���ġ
    private void RelocationTile()
    {
        Vector3 offset = Vector3.up * -0.6f;
        float tileX = buildingPreviewTiles[0].transform.localScale.x / 2;
        float tileY = buildingPreviewTiles[0].transform.localScale.y / 4;

        for (int y = 0; y < buildingData.BuildingSize.y; y++)
        {
            for(int x = 0; x < buildingData.BuildingSize.x; x++)
            {
                int index = x + buildingData.BuildingSize.y * y;
                buildingPreviewTiles[index].transform.localPosition = offset + new Vector3(tileX * x, -tileY * x, 0f);
            }
            offset -= new Vector3(tileX, tileY, 0);
        }
    }
}
