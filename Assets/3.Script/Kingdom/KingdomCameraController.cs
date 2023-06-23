using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;

public class KingdomCameraController : MonoBehaviour
{
    [SerializeField] private Text testText;

    [Header("Data")]
    [SerializeField] private float cameraMoveSpeed = 150f;
    [SerializeField] private float cameraZoomSpeed = 0.01f;
    [SerializeField] private float cameraZoomMin = 10f, cameraZoomMax = 20f;
    [SerializeField] private Vector4 cameraBorder = new Vector4(-9, 70, -40, 30);  // 하상좌우

    private int touchCount = 0;
    private Vector2 prevPos = Vector2.zero;
    private Camera cam;

    // 카메라 이동 활성화 비활성화
    private bool isActive = true;

    private void Awake()
    {
        cam = Camera.main;
    }

    public void IsActive(bool flag)
    {
        isActive = flag;
    }

    #region PC

    public void OnWheel(InputAction.CallbackContext value)
    {
        if (!isActive)
            return;

        if(value.performed)
        {
            float increment = value.ReadValue<Vector2>().y * cameraZoomSpeed;
            cam.orthographicSize = Mathf.Clamp(cam.orthographicSize + increment, cameraZoomMin, cameraZoomMax);
        }
    }

    public void OnTouchPC(InputAction.CallbackContext value)
    {
        if (value.started)
        {
            touchCount++;
        }
        else if (value.canceled)
        {
            prevPos = Vector2.zero;
            touchCount--;
        }
    }

    public void OnDragPC(InputAction.CallbackContext value)
    {
        if (!isActive)
            return;

        if (value.performed)
        {
            if (touchCount < 1)
                return;

            Vector2 currentPos = value.ReadValue<Vector2>();
            Vector3 dir = (currentPos - prevPos).normalized;

            Vector3 targetPos = cam.transform.position - dir * cameraMoveSpeed * Time.deltaTime;
            float targetPosX = Mathf.Clamp(targetPos.x, cameraBorder.x, cameraBorder.y);
            float targetPosY = Mathf.Clamp(targetPos.y, cameraBorder.z, cameraBorder.w);

            cam.transform.position = new Vector3(targetPosX, targetPosY, cam.transform.position.z);
            prevPos = currentPos;
        }
    }

    #endregion


    #region Mobile
    public void OnTouch0Contact(InputAction.CallbackContext value)
    {
        if (value.started)
        {
            testText.text = "OnTouch0Contact : Started";
            Debug.Log("OnTouch0Contact : Started");
        }

        if (value.canceled)
        {
            testText.text = "OnTouch0Contact : Canceled";
            Debug.Log("OnTouch0Contact : Canceled");
        }

        if (value.performed)
        {
            testText.text = "OnTouch0Contact : Performed";
            Debug.Log("OnTouch0Contact : Performed");
        }
    }

    public void OnTouch1Contact(InputAction.CallbackContext value)
    {
        if (value.started)
        {
            testText.text = "OnTouch1Contact : Started";
            Debug.Log("OnTouch1Contact : Started");
        }

        if (value.canceled)
        {
            testText.text = "OnTouch1Contact : Canceled";
            Debug.Log("OnTouch1Contact : Canceled");
        }

        if (value.performed)
        {
            testText.text = "OnTouch1Contact : Performed";
            Debug.Log("OnTouch1Contact : Performed");
        }
    }

    public void OnTouch0Pos(InputAction.CallbackContext value)
    {
        if (value.started)
        {
            testText.text = "OnTouch0Pos : Started";
            Debug.Log("OnTouch0Pos : Started");
        }

        if (value.canceled)
        {
            testText.text = "OnTouch0Pos : Canceled";
            Debug.Log("OnTouch0Pos : Canceled");
        }


        if (value.performed)
        {
            testText.text = "OnTouch0Pos : Performed";
            Debug.Log("OnTouch0Pos : Performed");
        }
    }

    public void OnTouch1Pos(InputAction.CallbackContext value)
    {
        if (value.started)
        {
            testText.text = "OnTouch1Pos : Started";
            Debug.Log("OnTouch1Pos : Started");
        }

        if (value.canceled)
        {
            testText.text = "OnTouch1Pos : Canceled";
            Debug.Log("OnTouch1Pos : Canceled");
        }

        if (value.performed)
        {
            testText.text = "OnTouch1Pos : Performed";
            Debug.Log("OnTouch1Pos : Performed");
        }
    }
    #endregion
}
