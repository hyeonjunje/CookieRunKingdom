using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomEditState : KingdomBaseState
{
    private Building _currentBuilding = null;
    private Vector3 _lastPos = Vector3.zero;

    public KingdomEditState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {
    }

    private void Init()
    {
        _touchCount = 0;
        _currentBuilding = null;
        _lastPos = Vector3.zero;
        _isActiveCameraControll = true;
    }

    public override void Enter()
    {
        Init();
        GameManager.UI.PushUI(_manager.KingdomEditUI);
    }

    public override void Exit()
    {
        _manager.BuildingSelectUI.HideUI();
        GameManager.UI.ClearUI();

        // ���� �� previewTile ������� ��
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
    }

    public override void Update()
    {

    }

    public override void OnClick(InputAction.CallbackContext value)
    {
        base.OnClick(value);

        if (value.started)
        {
            // ���� ���õ� �Ͽ�¡ �������� ������ �װ� ��ġ�ؾ� ��
            if(_manager.KingdomEditUI.CurrentHousingItemData)
            {
                _currentBuilding = null;

                var rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Ground"));

                if (!rayHit.collider)
                    return;

                // ���õ� �Ͽ�¡ �������� Ÿ���̶��
                if(_manager.KingdomEditUI.CurrentHousingItemData.IsTile)
                {
                    Tilemap tile = rayHit.transform.GetComponent<Tilemap>();
                    tile.SetSprite(_manager.KingdomEditUI.CurrentHousingItemData.HousingItemImage);
                }
                else
                {
                    Debug.Log("���߿� �� ��~~");
                }
            }
            // ���� ���õ� �Ͽ�¡ �������� ���ٸ�
            else
            {
                // �ձ��� ��ġ�� ������ ������ ��
                var rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("Building"));

                if (!rayHit.collider)
                {
                    _currentBuilding = null;
                    return;
                }

                _currentBuilding = rayHit.transform.GetComponent<Building>();

                if (_currentBuilding == null)
                    return;

                _currentBuilding.OnClickEditMode();
                _manager.BuildingSelectUI.SetBuilding(_currentBuilding, rayHit.transform, _camera.orthographicSize);
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
            _lastPos = _currentBuilding.transform.localPosition;

            _currentBuilding.UpdatePreviewTile();
        }
    }

    public override void OnWheel(InputAction.CallbackContext value)
    {
        base.OnWheel(value);
    }
}
