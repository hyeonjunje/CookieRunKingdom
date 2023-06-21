using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlacementSystem : MonoBehaviour
{
    [SerializeField] private Transform testObject;
    [SerializeField] private LayerMask placementLayermask;
    [SerializeField] private Grid grid;
    private Vector3 lastPosition;
    private Camera cam;

    private void Awake()
    {
        cam = Camera.main;
    }

    public void OnDraw(InputAction.CallbackContext value)
    {
        if(value.performed)
        {
            Vector2 val = value.ReadValue<Vector2>();
            Vector3 mousePos = new Vector3(val.x, val.y, cam.nearClipPlane);
            Vector3 targetpos = cam.ScreenToWorldPoint(mousePos);
            targetpos.z = 0;
            Vector3 dir = (targetpos - cam.transform.position).normalized;

/*            if (Physics.Raycast(cam.transform.position, dir, out RaycastHit hit, 100f, placementLayermask))
            {
                lastPosition = hit.point;
                Debug.Log("이거 해요??  " + lastPosition);
            }*/

            Vector3Int gridPosition = grid.WorldToCell(targetpos);
            testObject.position = grid.CellToWorld(gridPosition);
        }
    }
}
