using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class InputHandler : MonoBehaviour
{
    private Camera _mainCamera;

    private void Awake()
    {
        _mainCamera = Camera.main;
    }

    public void OnClick(InputAction.CallbackContext context)
    {
        if (!context.started) 
            return;

        var rayHit = Physics2D.GetRayIntersection(_mainCamera.ScreenPointToRay(Mouse.current.position.ReadValue()), 100, 1 << LayerMask.NameToLayer("UI"));
        if (!rayHit.collider)
            return;

        // 오브젝트가 버튼이라면...
        if(rayHit.transform.gameObject.layer == LayerMask.NameToLayer("UI"))
        {
            MyButton button = rayHit.transform.GetComponent<MyButton>();
            if(button != null)
                button.OnClick();
        }
    }
}
