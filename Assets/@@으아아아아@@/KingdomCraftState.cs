using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using DG.Tweening;

public class KingdomCraftState : KingdomBaseState
{
    private Building _building;
    private float prevOrthoSize = 0;

    public KingdomCraftState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public void SetBuilding(Building building)
    {
        _building = building;
        _manager.KingdomCraftUI.SetCraft(building);
    }

    public override void Enter()
    {
        prevOrthoSize = _camera.orthographicSize;

        Sequence seq = DOTween.Sequence();
        seq.Append(_camera.transform.DOMove(_building.transform.position + _manager.CameraControllData.CameraBuildingZoomOffset, 0.5f))
            .Join(_camera.DOOrthoSize(_manager.CameraControllData.CameraBuildingZoom, 0.5f))
            .OnComplete(() =>
            {
                _manager.KingdomBackGroundUI.SetActive(true);
                UIManager.instance.PushUI(_manager.KingdomCraftUI.gameObject);
            });
    }

    public override void Exit()
    {
        _building = null;
        _manager.KingdomBackGroundUI.SetActive(false);
        UIManager.instance.ClearUI();

        Sequence seq = DOTween.Sequence();
        seq.Append(_camera.DOOrthoSize(prevOrthoSize, 0.5f));
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
