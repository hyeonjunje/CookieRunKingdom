using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public abstract class KingdomBaseState
{
    protected KingdomStateFactory _factory;
    protected KingdomManager _manager;
    protected Camera _camera;
    protected bool _isActiveCameraControll = true;
    protected int _touchCount = 0;

    private Vector2 prevPos = Vector3.zero;

    private bool _isOverUI = false;

    public KingdomBaseState(KingdomStateFactory factory, KingdomManager manager)
    {
        _factory = factory;
        _manager = manager;

        _camera = Camera.main;
    }

    public abstract void Enter();
    public abstract void Exit();
    public abstract void Update();

    public virtual void OnWheel(InputAction.CallbackContext value)
    {
        if (!_isActiveCameraControll)
            return;

        if (value.performed)
        {
            float increment = value.ReadValue<Vector2>().y * _manager.CurrentCameraControllerData.CameraZoomSpeed;
            _camera.orthographicSize = Mathf.Clamp(_camera.orthographicSize + increment,
                _manager.CurrentCameraControllerData.CameraZoomMin, _manager.CurrentCameraControllerData.CameraZoomMax);
        }
    }

    public virtual void OnClick(InputAction.CallbackContext value)
    {
        if (value.started)
        {
            if(DetectUI())
                _isOverUI = true;
            else
                _touchCount++;
        }
        else if (value.canceled)
        {
            if(_isOverUI)
                _isOverUI = false;
            else
                _touchCount--;
        }
    }

    public virtual void OnDrag(InputAction.CallbackContext value)
    {
        if (!_isActiveCameraControll)
            return;

        if (!value.performed)
            return;

        if (_touchCount < 1)
            return;

        Vector2 currentPos = Mouse.current.position.ReadValue();

        if (currentPos.Equals(prevPos))
            return;

        Vector3 dir = (currentPos - prevPos).normalized;

        Vector3 targetPos = _camera.transform.position - dir * _manager.CurrentCameraControllerData.CameraMoveSpeed * Time.deltaTime;
        float targetPosX = Mathf.Clamp(targetPos.x,
            _manager.CurrentCameraControllerData.CameraBorder.x, _manager.CurrentCameraControllerData.CameraBorder.y);
        float targetPosY = Mathf.Clamp(targetPos.y,
            _manager.CurrentCameraControllerData.CameraBorder.z, _manager.CurrentCameraControllerData.CameraBorder.w);

        _camera.transform.position = new Vector3(targetPosX, targetPosY, _camera.transform.position.z);
        prevPos = currentPos;
    }

    private GameObject ui_canvas;
    private GraphicRaycaster ui_raycaster;
    private PointerEventData click_data;
    List<RaycastResult> click_results;

    private bool isinit = false;

    protected bool DetectUI()
    {
        if (!isinit)
        {
            ui_canvas = GameObject.Find("KingdomCanvas");
            isinit = true;
            ui_raycaster = ui_canvas.GetComponent<GraphicRaycaster>();
            click_data = new PointerEventData(EventSystem.current);
            click_results = new List<RaycastResult>();
        }

        click_data.position = Mouse.current.position.ReadValue();
        click_results.Clear();

        ui_raycaster.Raycast(click_data, click_results);

        if (click_results.Count != 0)
            return true;
        return false;
    }
}
