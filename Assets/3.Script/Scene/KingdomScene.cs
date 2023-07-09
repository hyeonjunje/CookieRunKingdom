using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomScene : BaseScene
{
    [Header("몰라")]
    [SerializeField] private GroundGenerator _groundGenerator;

    [Header("오브젝트 풀")]
    [SerializeField] private BuildingPreviewTileObjectPool _pool;

    [Header("부모 Transform")]
    [SerializeField] private Transform _buildingParent;
    [SerializeField] private Transform _cookieParent;

    [SerializeField] private KingdomManager _kingdomManager;

    protected override void Init()
    {
        // 땅 만들기
        _groundGenerator.Generate();

        // 생성할건 다 생성하고...
        _pool.Init();

        // 왕국 배치
        ArrangeBuilding();

        // 쿠키 생성
        ArrangeCookies();

        // 건물들 제작
        CraftItem();

        // 왕국 상태패턴
        _kingdomManager.Init();
    }

    // 왕국배치
    private void ArrangeBuilding()
    {
        BuildingController[] allBuildingsData = DataBaseManager.Instance.AllBuildings;
        List<BuildingInfo> ownedBuildings = GameManager.Game.ownedBuildings;

        for(int i = 0; i < ownedBuildings.Count; i++)
        {
            BuildingInfo buildingInfo = ownedBuildings[i];
            BuildingController building = Instantiate(allBuildingsData[buildingInfo.buildingIndex], _buildingParent);

            // 설치되어 있는 건물일 경우
            if (buildingInfo.isInstall)
            {
                _kingdomManager.buildingsInKingdom.Add(building);
                building.transform.position = buildingInfo.installationPosition;
                building.transform.SetGridTransform();
                building.gameObject.SetActive(true);

                // 왕국 설치
                building.BuildingWorker.WorkBuilding();
                building.BuildingEditor.IsInstance = true;
                building.BuildingEditor.OnClickEditMode();
                building.BuildingEditor.PutBuilding();
                _pool.ResetPreviewTile();
            }
            // 설치되지 않은 건물일 경우
            else
            {
                _kingdomManager.buildingsInInventory.Add(building);
                building.gameObject.SetActive(false);
            }
        }

        // GridManager.Instance.buildingGridData.VisualizeGridMapData();
    }

    // 쿠키 생성
    private void ArrangeCookies()
    {
        CookieController[] allCookiesData = DataBaseManager.Instance.AllCookies;
        List<CookieInfo> ownedCookies = GameManager.Game.ownedCookies;

        for(int i = 0; i < ownedCookies.Count; i++)
        {
            CookieInfo cookieInfo = ownedCookies[i];
            CookieController cookie = Instantiate(allCookiesData[cookieInfo.cookieIndex], _cookieParent);

            // 정보 넣기
            cookie.CookieStat.cookieLevel = cookieInfo.cookieLevel;
            cookie.CookieStat.skillLevel = cookieInfo.skillLevel;
            cookie.CookieStat.evolutionCount = cookieInfo.evolutionCount;
            cookie.CookieStat.isBattleMember = cookieInfo.isBattleMember;

            if (cookieInfo.lastKingdomPosition == Vector3.zero)
                cookie.transform.position = GridManager.Instance.ReturnEmptyTilePosition();
            else
                cookie.transform.position = cookieInfo.lastKingdomPosition;

            _kingdomManager.myCookies.Add(cookie);
            cookie.CookieCitizeon.KingdomAI();
        }
    }

    // 건물들 제작
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
                if(buildingInfo.cookieWorkerIndex != -1)
                {
                    BuildingController building = buildingsInKingdom[buildingCount];
                    // 일꾼설정
                    foreach (CookieController cookie in _kingdomManager.myCookies)
                        if (((CookieData)cookie.Data).CookieIndex == buildingInfo.cookieWorkerIndex)
                            building.BuildingWorker.LoadBuilding(cookie, buildingInfo.craftingItemData);
                }

                buildingCount++;
            }
        }
    }
}
