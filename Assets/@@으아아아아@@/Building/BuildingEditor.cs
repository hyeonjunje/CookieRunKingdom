using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingEditor : MonoBehaviour
{
    private BuildingController _controller;

    private List<SpriteRenderer> buildingPreviewTiles;

    private Grid _grid;
    private BuildingData _data;

    public void Init(BuildingController controller)
    {
        _controller = controller;

        _grid = GridManager.Instance.Grid;
        _data = _controller.Data;
    }

    // Ŭ�� �� buildingPreviewTiles�� ������
    public void OnClickEditMode()
    {
        buildingPreviewTiles = BuildingPreviewTileObjectPool.instance.GetPreviewTile(_data.BuildingSize, transform);
        RelocationTile();
        UpdatePreviewTile();
    }

    // buildingPreviewTilese ������Ʈ (��ȿ�� �� ���, �ȵǴ� �� ������)
    public void UpdatePreviewTile()
    {
        for (int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = _grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            bool check = GridManager.Instance.InvalidTileCheck(gridPos.x, gridPos.y);

            Color color = Color.white;

            // ���  �ƴϸ�   ������
            if (check)
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
        for (int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = _grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            GridManager.Instance.UpdateTile(gridPos.x, gridPos.y, false);
        }

        _controller.BuildingAnimator.SettingOrder(-Mathf.RoundToInt(transform.position.y) + 101);

        UpdatePreviewTile();
    }

    // buildingPreviewTiles ���ġ
    private void RelocationTile()
    {
        Vector3 offset = Vector3.up * -0.6f;
        float tileX = buildingPreviewTiles[0].transform.localScale.x / 2;
        float tileY = buildingPreviewTiles[0].transform.localScale.y / 4;

        for (int y = 0; y < _data.BuildingSize.y; y++)
        {
            for (int x = 0; x < _data.BuildingSize.x; x++)
            {
                int index = x + _data.BuildingSize.y * y;
                buildingPreviewTiles[index].transform.localPosition = offset + new Vector3(tileX * x, -tileY * x, 0f);
            }
            offset -= new Vector3(tileX, tileY, 0);
        }
    }
}
