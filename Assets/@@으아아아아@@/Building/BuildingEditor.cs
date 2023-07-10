using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingEditor : MonoBehaviour
{
    private BuildingController _controller;
    private Grid _grid;
    private BuildingData _data;
    
    public List<SpriteRenderer> buildingPreviewTiles { get; private set; }

    public bool IsFlip { get; set; } = false;

    public bool IsInstance { get; set; } = false;


    public void Init(BuildingController controller)
    {
        _controller = controller;

        _grid = GridManager.Instance.Grid;
        _data = _controller.Data;
    }

    // 클릭 시 buildingPreviewTiles가 정해짐
    public void OnClickEditMode()
    {
        buildingPreviewTiles = BuildingPreviewTileObjectPool.instance.GetPreviewTile(_data.BuildingSize, transform);
        RelocationTile();
        UpdatePreviewTile();
    }

    // buildingPreviewTilese 업데이트 (유효한 곳 흰색, 안되는 곳 빨간색)
    public void UpdatePreviewTile()
    {
        for (int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = _grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            bool check = GridManager.Instance.InvalidTileCheck(gridPos.x, gridPos.y);

            Color color = Color.white;

            // 흰색  아니면   빨간색
            if (check)
                color = Color.white;
            else
                color = Color.red;

            color.a = 0.5f;
            buildingPreviewTiles[i].color = color;
        }

        _controller.BuildingAnimator.SettingOrder();
    }

    // 해당 장소에 설치할 수 있으면 true 아니면 false
    public bool IsInstallable()
    {
        for (int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = _grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            bool check = GridManager.Instance.InvalidTileCheck(gridPos.x, gridPos.y);

            if (!check)
            {
                Debug.Log("이곳엔 설치할 수 없습니다.");
                return false;
            }
        }

        return true;
    }

    // 건물 설치
    public void PutBuilding()
    {
        for (int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = _grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            GridManager.Instance.UpdateTile(gridPos.x, gridPos.y, false);
        }

        _controller.BuildingAnimator.SettingOrder();

        UpdatePreviewTile();
    }

    // 건물 철수
    public void UnInstallBuilding()
    {
        for(int i = 0; i < buildingPreviewTiles.Count; i++)
        {
            Vector3Int gridPos = _grid.WorldToCell(buildingPreviewTiles[i].transform.position);
            GridManager.Instance.UpdateTile(gridPos.x, gridPos.y, true);
        }

        UpdatePreviewTile();
    }

    // buildingPreviewTiles 재배치
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
