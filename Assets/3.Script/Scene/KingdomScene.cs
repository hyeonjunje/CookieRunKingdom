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

        // �� ���� �ҷ�����
        LoadData();

        // �ձ� ��������
        _kingdomManager.Init();
    }

    // �ձ���ġ
    private void ArrangeBuilding()
    {
        // ���� ���� ��� �ǹ� ����
        BuildingController[] ownedBuilding = DataBaseManager.Instance.AllBuildings;
        _kingdomManager.ownedBuilding = new List<BuildingController>();

        for(int i = 0; i < ownedBuilding.Length; i++)
        {
            BuildingController building = Instantiate(ownedBuilding[i], _buildingParent);
            _kingdomManager.ownedBuilding.Add(building);
            building.gameObject.SetActive(false);
        }


        // �ձ��� �ִ� �ǹ� ����
        List<BuildingController> buildingInKingdom = DataBaseManager.Instance.OwnedBuildings;
        _kingdomManager.buildingsInKingdom = new List<BuildingController>();

        for(int i = 0; i < buildingInKingdom.Count; i++)
        {
            for(int j = 0; j < _kingdomManager.ownedBuilding.Count; j++)
            {
                // �ش� �ǹ��� ��Ȱ��ȭ�̰� �̸��� ������ => ���߿��� id�� �ؾ� �ҵ�
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

    // ��Ű ����
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

    // �� ���� �ҷ�����
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
