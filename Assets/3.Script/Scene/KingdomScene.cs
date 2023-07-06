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

    [SerializeField] private List<Building> _buildings = new List<Building>();
    [SerializeField] private List<BaseController> _myCookies = new List<BaseController>();

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

        // ��Ű ������ �� �� �ִ°��� ����
        for (int i = 0; i < myCookies.Count; i++)
        {
            BaseController cookie = Instantiate(myCookies[i], _cookieParent);
            cookie.transform.position = GridManager.Instance.ReturnEmptyTilePosition();
            _myCookies.Add(cookie);

            ((CookieController)cookie).CookieCitizeon.KingdomAI();
        }
    }
}
