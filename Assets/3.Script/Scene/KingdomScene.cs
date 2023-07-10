using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomScene : BaseScene
{
    [Header("����")]
    [SerializeField] private GroundGenerator _groundGenerator;

    [Header("������Ʈ Ǯ")]
    [SerializeField] private BuildingPreviewTileObjectPool _pool;

    [Header("�θ� Transform")]
    [SerializeField] private Transform _buildingParent;
    [SerializeField] private Transform _cookieParent;

    [SerializeField] private KingdomManager _kingdomManager;

    protected override void Init()
    {
        // �� �����
        _groundGenerator.Generate();

        // �����Ұ� �� �����ϰ�...
        _pool.Init();

        // �ձ� ��ġ
        ArrangeBuilding();

        // ��Ű ����
        ArrangeCookies();

        // �ǹ��� ����
        CraftItem();

        // �ձ� ��������
        _kingdomManager.Init();
    }

    // �ձ���ġ
    private void ArrangeBuilding()
    {
        BuildingController[] allBuildingsData = DataBaseManager.Instance.AllBuildings;
        List<BuildingInfo> ownedBuildings = GameManager.Game.ownedBuildings;

        for(int i = 0; i < ownedBuildings.Count; i++)
        {
            BuildingInfo buildingInfo = ownedBuildings[i];
            BuildingController building = Instantiate(allBuildingsData[buildingInfo.buildingIndex], _buildingParent);

            // ���� ���� �ʱ�ȭ
            building.BuildingWorker.InitCraftSlot();

            // ��ġ�Ǿ� �ִ� �ǹ��� ���
            if (buildingInfo.isInstall)
            {
                _kingdomManager.buildingsInKingdom.Add(building);
                building.transform.position = buildingInfo.installationPosition;
                building.transform.SetGridTransform();
                building.gameObject.SetActive(true);

                // �ձ� ��ġ
                building.BuildingWorker.WorkBuilding();
                building.BuildingEditor.IsInstance = true;
                building.BuildingEditor.OnClickEditMode();
                building.BuildingEditor.PutBuilding();
                _pool.ResetPreviewTile();
            }
            // ��ġ���� ���� �ǹ��� ���
            else
            {
                _kingdomManager.buildingsInInventory.Add(building);
                building.gameObject.SetActive(false);
            }
        }

        // GridManager.Instance.buildingGridData.VisualizeGridMapData();
    }

    // ��Ű ����
    private void ArrangeCookies()
    {
        CookieController[] allCookiesData = DataBaseManager.Instance.AllCookies;
        List<CookieInfo> ownedCookies = GameManager.Game.allCookies;

        for(int i = 0; i < ownedCookies.Count; i++)
        {
            CookieInfo cookieInfo = ownedCookies[i];

            CookieController cookie = Instantiate(allCookiesData[cookieInfo.cookieIndex], _cookieParent);

            // ���� �ֱ�
            cookie.CookieStat.LoadCookie();

            if (cookieInfo.lastKingdomPosition == Vector3.zero)
                cookie.transform.position = GridManager.Instance.ReturnEmptyTilePosition();
            else
                cookie.transform.position = cookieInfo.lastKingdomPosition;

            _kingdomManager.allCookies.Add(cookie);
            cookie.CookieCitizeon.KingdomAI();
        }
    }

    // �ǹ��� ����
    private void CraftItem()
    {
        List<BuildingController> buildingsInKingdom = _kingdomManager.buildingsInKingdom;
        List<BuildingInfo> ownedBuildings = GameManager.Game.ownedBuildings;
        int buildingCount = 0;

        for (int i = 0; i < ownedBuildings.Count; i++)
        {
            BuildingInfo buildingInfo = ownedBuildings[i];
            if(buildingInfo.isInstall)
            {
                BuildingController building = buildingsInKingdom[buildingCount];
                if (buildingInfo.cookieWorkerIndex != -1)
                {
                    // �ϲۼ���
                    foreach (CookieController cookie in _kingdomManager.allCookies)
                        if (((CookieData)cookie.Data).CookieIndex == buildingInfo.cookieWorkerIndex)
                            building.BuildingWorker.LoadBuilding(buildingInfo.craftingItemData, cookie);
                }

                buildingCount++;
            }
        }
    }
}
