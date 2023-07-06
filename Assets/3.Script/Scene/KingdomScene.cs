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

        // 왕국 상태패턴
        _kingdomManager.Init();
    }

    private void ArrangeBuilding()
    {
        // 내가 가진 건물들 설치
        List<BuildingController> myBuildings = DataBaseManager.Instance.OwnedBuildings;
        _kingdomManager.buildings = new List<BuildingController>();

        for (int i = 0; i < myBuildings.Count; i++)
        {
            BuildingController building = Instantiate(myBuildings[i], _buildingParent);
            _kingdomManager.buildings.Add(building);
            building.transform.SetGridTransform();
            building.BuildingWorker.WorkBuilding();

            building.BuildingEditor.OnClickEditMode();
            building.BuildingEditor.PutBuilding();
            _pool.ResetPreviewTile();
        }

        // GridManager.Instance.buildingGridData.VisualizeGridMapData();
    }

    private void ArrangeCookies()
    {
        List<CookieController> myCookies = DataBaseManager.Instance.OwnedCookies;
        _kingdomManager.myCookies = new List<CookieController>();

        // 쿠키 무작위 둘 수 있는곳에 생성
        for (int i = 0; i < myCookies.Count; i++)
        {
            CookieController cookie = Instantiate(myCookies[i], _cookieParent);
            cookie.transform.position = GridManager.Instance.ReturnEmptyTilePosition();
            _kingdomManager.myCookies.Add(cookie);

            cookie.CookieCitizeon.KingdomAI();
        }
    }
}
