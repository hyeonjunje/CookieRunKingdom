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

    [SerializeField] private List<Building> _buildings = new List<Building>();
    [SerializeField] private List<BaseController> _myCookies = new List<BaseController>();

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
        List<Building> myBuildings = DataBaseManager.Instance.OwnedBuildings;
        for(int i = 0; i < myBuildings.Count; i++)
        {
            Building building = Instantiate(myBuildings[i], _buildingParent);
            _buildings.Add(building);
            building.transform.SetGridTransform();
            building.OnClickEditMode();
            building.PutBuilding();
            _pool.ResetPreviewTile();
        }

        // GridManager.Instance.buildingGridData.VisualizeGridMapData();
    }

    private void ArrangeCookies()
    {
        List<BaseController> myCookies = DataBaseManager.Instance.OwnedCookies;
        _myCookies = new List<BaseController>();

        // 쿠키 무작위 둘 수 있는곳에 생성
        for (int i = 0; i < myCookies.Count; i++)
        {
            BaseController cookie = Instantiate(myCookies[i], _cookieParent);
            cookie.transform.position = GridManager.Instance.ReturnEmptyTilePosition();
            _myCookies.Add(cookie);

            ((CookieController)cookie).CookieCitizeon.KingdomAI();
        }
    }
}
