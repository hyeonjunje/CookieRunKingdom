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

        // 내 정보 불러오기
        LoadData();

        // 왕국 상태패턴
        _kingdomManager.Init();
    }

    // 왕국배치
    private void ArrangeBuilding()
    {
        // 내가 가진 모든 건물 생성
        BuildingController[] ownedBuilding = DataBaseManager.Instance.AllBuildings;
        _kingdomManager.ownedBuilding = new List<BuildingController>();

        for(int i = 0; i < ownedBuilding.Length; i++)
        {
            BuildingController building = Instantiate(ownedBuilding[i], _buildingParent);
            _kingdomManager.ownedBuilding.Add(building);
            building.gameObject.SetActive(false);
        }


        // 왕국에 있는 건물 설정
        List<BuildingController> buildingInKingdom = DataBaseManager.Instance.OwnedBuildings;
        _kingdomManager.buildingsInKingdom = new List<BuildingController>();

        for(int i = 0; i < buildingInKingdom.Count; i++)
        {
            for(int j = 0; j < _kingdomManager.ownedBuilding.Count; j++)
            {
                // 해당 건물이 비활성화이고 이름이 같으면 => 나중에는 id로 해야 할듯
                if(!_kingdomManager.ownedBuilding[j].gameObject.activeSelf 
                    && buildingInKingdom[i].Data.BuildingName == _kingdomManager.ownedBuilding[j].Data.BuildingName)
                {
                    BuildingController building = _kingdomManager.ownedBuilding[j];
                    building.gameObject.SetActive(true);
                    _kingdomManager.buildingsInKingdom.Add(building);

                    building.transform.SetGridTransform();
                    building.BuildingWorker.WorkBuilding();

                    building.BuildingEditor.IsInstance = true;
                    building.BuildingEditor.OnClickEditMode();
                    building.BuildingEditor.PutBuilding();
                    _pool.ResetPreviewTile();
                    break;
                }
            }
        }

        // GridManager.Instance.buildingGridData.VisualizeGridMapData();
    }

    // 쿠키 생성
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

    // 내 정보 불러오기
    private void LoadData()
    {
        /*GameManager.Game.Dia = 50737;
        GameManager.Game.Money = 8711280;
        GameManager.Game.MaxJelly = 170;
        GameManager.Game.Jelly = 558;*/

        GameManager.Game.Dia = 1234;
        GameManager.Game.Money = 5678910;
        GameManager.Game.MaxJelly = 85;
        GameManager.Game.Jelly = 5;
    }
}
