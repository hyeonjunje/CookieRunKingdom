using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlacementSystem : MonoBehaviour
{
    [Header("LayerMask")]
    [SerializeField] private LayerMask placementLayermask;
    [SerializeField] private LayerMask buildingLayermask;

    [Header("컴포넌트")]
    [SerializeField] private Grid grid;
    [SerializeField] private KingdomCameraController cameraController;

    [Header("트랜스폼")]
    [SerializeField] private Transform parent;
    [SerializeField] private BuildingSelectUI buildingSelectUI;

    private int touchCount = 0;

    private Vector2 mousePosition = Vector2.zero;
    private Vector3 lastPosition;
    private Building currentObject = null;
    private Camera cam;


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
                Vector2 pos = cam.ScreenToWorldPoint(mousePosition);
                Vector3Int gridPosition = grid.WorldToCell(pos);
                currentObject.transform.localPosition = grid.CellToWorld(gridPosition);
                lastPosition = currentObject.transform.localPosition;

                currentObject.UpdatePreviewTile();
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
                currentObject = hit.transform.gameObject.GetComponent<Building>();

                buildingSelectUI.gameObject.SetActive(true);
                buildingSelectUI.transform.SetParent(hit.transform);
                buildingSelectUI.transform.localPosition = Vector3.zero;
                buildingSelectUI.transform.localRotation = Quaternion.identity;
                buildingSelectUI.transform.localScale = Vector3.one * (cam.orthographicSize) / 10;
                buildingSelectUI.SetBuilding(currentObject);

                currentObject.OnClick();
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
}
