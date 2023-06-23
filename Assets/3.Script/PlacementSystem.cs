using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlacementSystem : MonoBehaviour
{
    [Header("LayerMask")]
    [SerializeField] private LayerMask placementLayermask;
    [SerializeField] private LayerMask buildingLayermask;

    [Header("������Ʈ")]
    [SerializeField] private Grid grid;
    [SerializeField] private KingdomCameraController cameraController;

    [Header("Ʈ������")]
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

            // ������Ʈ�� ���õǾ��ٸ�
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
        // Ŭ�� ��
        if (value.started)
        {
            cameraController.IsActive(true);
            touchCount++;

            Vector2 pos = cam.ScreenToWorldPoint(mousePosition);
            RaycastHit2D hit = Physics2D.Raycast(pos, Vector2.zero, 0f, buildingLayermask);

            // �ǹ� Ŭ�� ��
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
