using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;
using Spine;

public class Building : MonoBehaviour
{
    [SerializeField] private BuildingData buildingData;
    [SerializeField] private List<CraftingItemData> craftingItemData = new List<CraftingItemData>();
    [SerializeField] private GameObject craftBubble;

    private List<SpriteRenderer> buildingPreviewTiles;
    private List<SpriteRenderer> craftBubbleUnit = new List<SpriteRenderer>();

    // 프로퍼티
    private Grid grid => GridManager.instance.Grid;
    public List<CraftingItemData> CraftingItemData => craftingItemData;
    public BuildingData Data => buildingData;

    private void Awake()
    {
        StartCoroutine(CoSecond());

        for(int i = 0; i < craftBubble.transform.childCount; i++)
        {
            craftBubbleUnit.Add(craftBubble.transform.GetChild(i).GetComponent<SpriteRenderer>());
        }
    }

    public void Highlighgt(bool flag)
    {
        foreach(Renderer renderer in GetComponentsInChildren<Renderer>())
        {
            renderer.sortingLayerID = flag ?
            SortingLayer.NameToID("GridUpper") : SortingLayer.NameToID("Default");
        }
    }

    // 클릭 시 buildingPreviewTiles가 정해짐
    public void OnClickEditMode()
    {
        buildingPreviewTiles = BuildingPreviewTileObjectPool.instance.GetPreviewTile(buildingData.BuildingSize, transform);
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

    // 건물 설치
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


    private IEnumerator CoSecond()
    {
        WaitForSecondsRealtime second = new WaitForSecondsRealtime(1f);

        while (true)
        {
            yield return second;
            ManageCraftingItemData();
        }
    }

    private void ManageCraftingItemData()
    {
        for (int i = 0; i < craftingItemData.Count; i++)
        {
            if (craftingItemData[i].craftData == null)
                return;

            // 만들고 있다면
            if (craftingItemData[i].state == ECraftingState.making)
            {
                // 1초씩 더해준다.
                craftingItemData[i].takingTime += 1;

                // 만약 다 만들었다면
                if (craftingItemData[i].takingTime >= craftingItemData[i].craftData.CraftTime)
                {
                    // 버블
                    craftBubble.SetActive(true);
                    foreach(SpriteRenderer sr in craftBubbleUnit)
                    {
                        if(sr.sprite == null)
                        {
                            sr.sprite = craftingItemData[i].craftData.CraftImage;
                            break;
                        }
                    }

                    craftingItemData[i].state = ECraftingState.complete;
                    if (i + 1 < craftingItemData.Count && craftingItemData[i + 1].craftData != null &&
                        craftingItemData[i + 1].state == ECraftingState.waiting)
                    {
                        craftingItemData[i + 1].state = ECraftingState.making;
                    }
                }
            }
        }
    }

    /// <summary>
    /// 제작물 수확을 시도하는 메소드
    /// 수확할 수 있으면 수확하고 true반환
    /// 수확할 수 없으면 그냥 false 반환
    /// </summary>
    /// <returns>수확할 수 있나?</returns>
    public bool TryHarvest()
    {
        for(int i = 0; i < craftingItemData.Count; i++)
        {
            if (craftingItemData[i].state == ECraftingState.complete)
            {
                Harvest();
                return true;
            }
        }
        return false;
    }

    // 실질적으로 수확하는 메소드
    private void Harvest()
    {
        // 버블에 떠다니는 수확물 다 없애기
        craftBubble.SetActive(false);
        foreach (SpriteRenderer sr in craftBubbleUnit)
            sr.sprite = null;

        int count = 0;

        for(int i = 0; i < craftingItemData.Count; i++)
        {
            if(craftingItemData[i].state == ECraftingState.complete)
            {
                // Debug.Log(craftingItemData[i].craftData.CraftResult.ingredientItem.ItemName + " 을 " + craftingItemData[i].craftData.CraftResult.count + "개 얻었습니다.");
                DataBaseManager.Instance.AddItem(craftingItemData[i].craftData.CraftResult.ingredientItem, craftingItemData[i].craftData.CraftResult.count);
                craftingItemData[i].state = ECraftingState.empty;
            }
        }

        for(int i = 0; i < craftingItemData.Count; i++)
        {
            if(craftingItemData[i].state != ECraftingState.empty)
            {
                craftingItemData[count++] = new CraftingItemData(craftingItemData[i].state, craftingItemData[i].craftData);
                craftingItemData[i].state = ECraftingState.empty;
            }
        }
    }
}
