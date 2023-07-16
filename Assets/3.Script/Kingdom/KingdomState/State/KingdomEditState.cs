using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomEditState : KingdomBaseState
{
    private BuildingController _currentBuilding = null;

    public KingdomEditState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    public override void Enter()
    {
        _currentBuilding = null;
        GameManager.UI.PushUI(_manager.KingdomEditUI);
        _manager.KingdomGrid.gameObject.SetActive(true);
        _manager.buildingsInKingdom.ForEach(building => building.gameObject.SetActive(true));
    }

    public override void Exit()
    {
        GameManager.UI.ClearUI();
        _manager.BuildingCircleEditUI.HideUI();
        _manager.BuildingCircleEditUIInPreview.HideUI();
        _manager.KingdomGrid.gameObject.SetActive(false);

        // ���� �� previewTile ������� ��
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();

        _manager.buildingsInKingdom.ForEach(building => building.gameObject.SetActive(false));
    }

    public override void Update()
    {

    }

    public override void OnClickStart()
    {
        base.OnClickStart();

        RaycastHit2D rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("UI"));
        if (rayHit.collider && rayHit.transform.gameObject.layer == LayerMask.NameToLayer("UI"))
            return;

        rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Building"));
        if (rayHit.collider)
        {
            _currentBuilding = rayHit.transform.GetComponent<BuildingController>();
            _manager.BuildingCircleEditUI.ButtonParent.SetActive(false);
            _manager.BuildingCircleEditUIInPreview.ButtonParent.SetActive(false);
            _manager.BuildingCircleEditUI.SetPrevBuilding(_currentBuilding);
            _manager.BuildingCircleEditUIInPreview.SetPrevBuilding(_currentBuilding);
            _currentBuilding.BuildingEditor.OnClickEditMode();

            if (_currentBuilding.BuildingEditor.IsInstance)
                _manager.BuildingCircleEditUI.SetBuilding(_currentBuilding, rayHit.transform, _camera.orthographicSize);
            else
                _manager.BuildingCircleEditUIInPreview.SetBuilding(_currentBuilding, rayHit.transform, _camera.orthographicSize);

            return;
        }

        rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Ground"));
        if (rayHit.collider)
        {
            _currentBuilding = null;
            return;
        }
    }

    public override void OnClick()
    {
        base.OnClick();

        RaycastHit2D rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("UI"));
        if (rayHit.collider && rayHit.transform.gameObject.layer == LayerMask.NameToLayer("UI"))
        {
            MyButton button = rayHit.transform.GetComponent<MyButton>();
            if (button != null)
                button.OnClick();
            return;
        }

        // �ձ��� ��ġ�� ������ ������ ��
        rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Building"));

        if (!rayHit.collider)
        {
            _currentBuilding = null;
            return;
        }

        _currentBuilding = rayHit.transform.GetComponent<BuildingController>();

        if (_currentBuilding == null)
            return;

        _manager.BuildingCircleEditUI.ButtonParent.SetActive(false);
        _manager.BuildingCircleEditUIInPreview.ButtonParent.SetActive(false);
        _manager.BuildingCircleEditUI.SetPrevBuilding(_currentBuilding);
        _manager.BuildingCircleEditUIInPreview.SetPrevBuilding(_currentBuilding);
        _currentBuilding.BuildingEditor.OnClickEditMode();

        if (_currentBuilding.BuildingEditor.IsInstance)
            _manager.BuildingCircleEditUI.SetBuilding(_currentBuilding, rayHit.transform, _camera.orthographicSize);
        else
            _manager.BuildingCircleEditUIInPreview.SetBuilding(_currentBuilding, rayHit.transform, _camera.orthographicSize);
    }

    public override void OnDrag()
    {
        if(_currentBuilding == null)
        {
            base.OnDrag();
        }
        else
        {
            Vector2 pos = _camera.ScreenToWorldPoint(Mouse.current.position.ReadValue());
            Vector3Int gridPos = _manager.Grid.WorldToCell(pos);
            _currentBuilding.transform.localPosition = _manager.Grid.CellToWorld(gridPos);

            _currentBuilding.BuildingEditor.UpdatePreviewTile();
        }
    }

    public override void OnWheel(InputAction.CallbackContext value)
    {
        base.OnWheel(value);
    }
}
