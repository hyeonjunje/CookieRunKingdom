using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using DG.Tweening;

public class KingdomCraftState : KingdomBaseState
{
    private BuildingController _building;
    private float prevOrthoSize = 0;

    public KingdomCraftState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public void SetBuilding(BuildingController building)
    {
        _building = building;
        _manager.KingdomCraftUI.SetCraft(building);
    }

    public override void Enter()
    {
        prevOrthoSize = _camera.orthographicSize;

        Sequence seq = DOTween.Sequence();
        seq.Append(_camera.transform.DOMove(_building.transform.position + _manager.CurrentCameraControllerData.CameraBuildingZoomOffset, 0.5f))
            .Join(_camera.DOOrthoSize(_manager.CurrentCameraControllerData.CameraBuildingZoom, 0.5f))
            .OnComplete(() =>
            {
                _building.BuildingWorker.Highlighgt(true);
                _manager.KingdomBackGroundUI.SetActive(true);
                GameManager.UI.PushUI(_manager.KingdomCraftUI);
            });


        _manager.myCookies.ForEach(cookie =>
        {
            cookie.gameObject.SetActive(true);
            cookie.CookieCitizeon.KingdomAI();
        });

        _manager.buildings.ForEach(building =>
        {
            building.gameObject.SetActive(true);
            building.BuildingWorker.WorkBuilding();
        });
    }

    public override void Exit()
    {
        _building.gameObject.SetActive(false);

        _building.BuildingWorker.Highlighgt(false);

        _building = null;
        _manager.KingdomBackGroundUI.SetActive(false);
        GameManager.UI.ClearUI();

        Sequence seq = DOTween.Sequence();
        seq.Append(_camera.DOOrthoSize(prevOrthoSize, 0.5f));

        _manager.myCookies.ForEach(cookie => cookie.gameObject.SetActive(false));
        _manager.buildings.ForEach(building => building.gameObject.SetActive(false));
    }

    public override void Update()
    {

    }

    public override void OnClick(InputAction.CallbackContext value)
    {

    }

    public override void OnDrag(InputAction.CallbackContext value)
    {

    }

    public override void OnWheel(InputAction.CallbackContext value)
    {

    }
}
