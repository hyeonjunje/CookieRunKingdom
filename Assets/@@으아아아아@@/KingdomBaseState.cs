using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public abstract class KingdomBaseState
{
    protected KingdomStateFactory _factory;
    protected KingdomManager _manager;
    protected Camera _camera;
    protected bool _isActiveCameraControll = true;
    protected int _touchCount = 0;

    private Vector2 prevPos = Vector3.zero;

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
            float increment = value.ReadValue<Vector2>().y * _manager.CameraControllData.CameraZoomSpeed;
            _camera.orthographicSize = Mathf.Clamp(_camera.orthographicSize + increment,
                _manager.CameraControllData.CameraZoomMin, _manager.CameraControllData.CameraZoomMax);
        }
    }

    public virtual void OnClick(InputAction.CallbackContext value)
    {
        if (value.started)
            _touchCount++;
        else if (value.canceled)
            _touchCount--;
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

        Vector3 targetPos = _camera.transform.position - dir * _manager.CameraControllData.CameraMoveSpeed * Time.deltaTime;
        float targetPosX = Mathf.Clamp(targetPos.x,
            _manager.CameraControllData.CameraBorder.x, _manager.CameraControllData.CameraBorder.y);
        float targetPosY = Mathf.Clamp(targetPos.y,
            _manager.CameraControllData.CameraBorder.z, _manager.CameraControllData.CameraBorder.w);

        _camera.transform.position = new Vector3(targetPosX, targetPosY, _camera.transform.position.z);
        prevPos = currentPos;
    }
}
