using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlacementSystem : MonoBehaviour
{
    [SerializeField] private LayerMask placementLayermask;
    [SerializeField] private LayerMask buildingLayermask;
    [SerializeField] private Grid grid;
    [SerializeField] private Transform parent;
    [SerializeField] private Transform buildingSelectUI;
    [SerializeField] private KingdomCameraController cameraController;

    private Vector2 mousePosition = Vector2.zero;

    private GameObject currentObject = null;
    private Vector3 lastPosition;
    private Camera cam;

    private int touchCount = 0;

    private void Awake()
    {
        cam = Camera.main;
    }

    public void OnDraw(InputAction.CallbackContext value)
    {
        if (value.performed)
        {
            mousePosition = value.ReadValue<Vector2>();

            // 오브젝트가 선택되었다면
            if(currentObject != null && touchCount == 1)
            {
                Vector3 mousePos = new Vector3(mousePosition.x, mousePosition.y, cam.nearClipPlane);
                Ray ray = cam.ScreenPointToRay(mousePos);

                Vector3 targetPos = Vector3.zero;
                if (Physics.Raycast(ray, out RaycastHit hit, 100, placementLayermask))
                {
                    targetPos = hit.point;
                }

                Vector3Int gridPosition = grid.WorldToCell(targetPos);
                currentObject.transform.localPosition = grid.CellToWorld(gridPosition);
                lastPosition = currentObject.transform.localPosition;
            }
        }
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        // 클릭 시
        if (value.started)
        {
            cameraController.IsActive(true);

            touchCount++;

            Vector2 pos = cam.ScreenToWorldPoint(mousePosition);
            RaycastHit2D hit = Physics2D.Raycast(pos, Vector2.zero, 0f, buildingLayermask);

            // 건물 클릭 시
            if (hit.collider != null)
            {
                cameraController.IsActive(false);

                buildingSelectUI.gameObject.SetActive(true);
                buildingSelectUI.SetParent(hit.transform);
                buildingSelectUI.localPosition = Vector3.zero;
                buildingSelectUI.localRotation = Quaternion.identity;

                buildingSelectUI.localScale = Vector3.one * (cam.orthographicSize) / 10;

                currentObject = hit.transform.gameObject;
            }
            else
            {
                currentObject = null;
            }
        }

        else if(value.canceled)
        {
            cameraController.IsActive(true);

            touchCount--;
        }
    }

    private void Update()
    {
        Debug.Log(touchCount);
    }
}
