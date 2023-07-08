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
        _touchCount = 0;
        _currentBuilding = null;
        _isActiveCameraControll = true;

        GameManager.UI.PushUI(_manager.KingdomEditUI);

        _manager.KingdomGrid.gameObject.SetActive(true);

        _manager.buildingsInKingdom.ForEach(building => building.gameObject.SetActive(true));
    }

    public override void Exit()
    {
        _manager.BuildingCircleEditUI.HideUI();
        _manager.BuildingCircleEditUIInPreview.HideUI();

        GameManager.UI.ClearUI();

        _manager.KingdomGrid.gameObject.SetActive(false);

        // 나갈 때 previewTile 없애줘야 해
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();

        _manager.buildingsInKingdom.ForEach(building => building.gameObject.SetActive(false));
    }

    public override void Update()
    {

    }

    public override void OnClick(InputAction.CallbackContext value)
    {
        base.OnClick(value);

        if (DetectUI())
            return;

        if (value.started)
        {
            // 선택된게 타일이라면
            if (_manager.KingdomEditUI.CurrentHousingItemData != null)
            {
                var rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Ground"));
                if (!rayHit.collider)
                    return;

                Tilemap tile = rayHit.transform.GetComponent<Tilemap>();
                tile.SetSprite(_manager.KingdomEditUI.CurrentHousingItemData.HousingItemImage);
            }
            // 현재 선택된 하우징 아이템이 없다면
            else
            {
                // 왕국에 설치된 빌딩을 눌렀을 때
                var rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Building"));

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
        }

        else if(value.canceled)
        {
            _isActiveCameraControll = true;
        }
    }

    public override void OnDrag(InputAction.CallbackContext value)
    {
        base.OnDrag(value);

        if(value.performed)
        {
            if (_currentBuilding == null || _touchCount == 0)
                return;

            _isActiveCameraControll = false;

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
