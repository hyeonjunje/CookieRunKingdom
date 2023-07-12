using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomScene : BaseScene
{
    [Header("����")]
    [SerializeField] private GroundGenerator _groundGenerator;

    [Header("�θ� Transform")]
    [SerializeField] private Transform _buildingParent;
    [SerializeField] private Transform _cookieParent;

    [SerializeField] private KingdomManager _kingdomManager;

    protected override void Init()
    {
        // �� �����
        _groundGenerator.Generate();

        // �����Ұ� �� �����ϰ�...
        BuildingPreviewTileObjectPool.instance.Init();

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
        List<CraftableBuildingInfo> ownedBuildings = GameManager.Game.OwnedCraftableBuildings;

        for(int i = 0; i < ownedBuildings.Count; i++)
        {
            CraftableBuildingInfo buildingInfo = ownedBuildings[i];
            BuildingController building = Instantiate(allBuildingsData[buildingInfo.buildingIndex], _buildingParent);
            
            building.BuildingWorker.LoadBuilding();

            if(buildingInfo.isInstall)
            {
                building.gameObject.SetActive(true);
                _kingdomManager.buildingsInKingdom.Add(building);
            }
            else
            {
                building.gameObject.SetActive(false);
                _kingdomManager.buildingsInInventory.Add(building);
            }
        }
        // GridManager.Instance.buildingGridData.VisualizeGridMapData();
    }

    // ��Ű ����
    private void ArrangeCookies()
    {
        CookieController[] allCookiesData = DataBaseManager.Instance.AllCookies;
        List<CookieInfo> ownedCookies = GameManager.Game.AllCookies;

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
        List<CraftableBuildingInfo> ownedBuildings = GameManager.Game.OwnedCraftableBuildings;
        int buildingCount = 0;

        for (int i = 0; i < ownedBuildings.Count; i++)
        {
            if (!ownedBuildings[i].isCraftable)
                continue;

            CraftableBuildingInfo buildingInfo = ownedBuildings[i];
            if(buildingInfo.isInstall)
            {
                BuildingController building = buildingsInKingdom[buildingCount];
                if (buildingInfo.cookieWorkerIndex != -1)
                {
                    // �ϲۼ���
                    foreach (CookieController cookie in _kingdomManager.allCookies)
                        if (((CookieData)cookie.Data).CookieIndex == buildingInfo.cookieWorkerIndex)
                            building.BuildingWorker.LoadBuilding(cookie);
                }

                buildingCount++;
            }
        }
    }
}
