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

        // �ձ� ��������
        _kingdomManager.Init();
    }

    private void ArrangeBuilding()
    {
        // ���� ���� �ǹ��� ��ġ
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

        // ��Ű ������ �� �� �ִ°��� ����
        for (int i = 0; i < myCookies.Count; i++)
        {
            CookieController cookie = Instantiate(myCookies[i], _cookieParent);
            cookie.transform.position = GridManager.Instance.ReturnEmptyTilePosition();
            _kingdomManager.myCookies.Add(cookie);

            cookie.CookieCitizeon.KingdomAI();
        }
    }
}
