using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class KingdomManageState : KingdomBaseState
{
    private CookieController _currentCookie = null;
    private bool _isDrag = false;
    private Vector3 _cookieOffsetPosition = Vector3.zero;

    public KingdomManageState(KingdomStateFactory factory, KingdomManager manager) : base(factory, manager)
    {

    }

    private void Init()
    {
        _manager.CurrentCameraControllerData = _manager.CameraControllInKingdomData;
        _manager.IsMoveCamera = true;
    }

    public override void Enter()
    {
        Init();
        GameManager.UI.PushUI(_manager.KingdomManagerUI);

        _camera.transform.position = new Vector3(4.6f, 9f, -10f);
        _camera.orthographicSize = 13;

        // ��Ű���� ������
        _manager.allCookies.ForEach(cookie =>
        {
            if(cookie.CookieStat.IsHave)
            {
                cookie.CookieStat.SaveCookie();

                cookie.gameObject.SetActive(true);
                cookie.CookieCitizeon.StartKingdomAI();
            }
        });

        _manager.buildingsInKingdom.ForEach(building =>
        {
            building.BuildingWorker.isRepresentative = false;
            building.BuildingWorker.SaveBuilding();

            building.BuildingWorker.UpdateCraftingItem();

            building.gameObject.SetActive(true);
            building.BuildingWorker.WorkBuilding();
        });

        if (_manager.buildingsInKingdom.Count != 0)
            _manager.buildingsInKingdom[0].BuildingWorker.isRepresentative = true;
    }

    public override void Exit()
    {
        GameManager.UI.ClearUI();

        // ��Ű���� �����
        _manager.allCookies.ForEach(cookie =>
        {
            if(cookie.CookieStat.IsHave)
            {
                cookie.CookieStat.SaveCookie();
                cookie.gameObject.SetActive(false);
            }
        });

        _manager.buildingsInKingdom.ForEach(building =>
        {
            building.BuildingWorker.isRepresentative = true;
            building.BuildingWorker.SaveBuilding();
            building.gameObject.SetActive(false);
        });
    }

    public override void OnClickStart()
    {
        base.OnClickStart();

        Vector2 currentPos = Vector2.zero;
        if (Mouse.current != null && Mouse.current.enabled)
            currentPos = Mouse.current.position.ReadValue();
        else if (Touchscreen.current != null && Touchscreen.current.enabled)
            currentPos = Touchscreen.current.position.ReadValue();

        RaycastHit2D rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(currentPos), 100, 1 << LayerMask.NameToLayer("Cookie"));
        if (rayHit.collider)
        {
            CookieController currentCookie = rayHit.transform.GetComponent<CookieController>();
            if (currentCookie != null)
            {
                if (!currentCookie.CookieCitizeon.IsWorking)
                {
                    _currentCookie = currentCookie;
                }
            }
        }
    }

    public override void OnClick()
    {
        base.OnClick();

        Vector2 currentPos = Vector2.zero;
        if (Mouse.current != null && Mouse.current.enabled)
            currentPos = Mouse.current.position.ReadValue();
        else if (Touchscreen.current != null && Touchscreen.current.enabled)
            currentPos = Touchscreen.current.position.ReadValue();

        RaycastHit2D rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(currentPos), 100, 1 << LayerMask.NameToLayer("Building"));

        // ���� �ǹ��̶�� ��Ȯ�Ѵ�.
        if (rayHit.collider)
        {
            BuildingController currentBuilding = rayHit.transform.GetComponent<BuildingController>();
            if (currentBuilding != null)
            {
                if (!currentBuilding.BuildingWorker.TryHarvest())
                {
                    if (currentBuilding.Data.IsCraftable)
                    {
                        _factory.kingdomCraftState.SetBuilding(currentBuilding);
                        _factory.ChangeState(EKingdomState.Craft);
                    }
                }
            }

            return;
        }

        rayHit = Physics2D.GetRayIntersection(_camera.ScreenPointToRay(currentPos), 100, 1 << LayerMask.NameToLayer("Cookie"));
        // ��Ű��� �λ��Ѵ�.
        if(rayHit.collider)
        {
            _currentCookie = rayHit.transform.GetComponent<CookieController>();
            if(_currentCookie != null)
            {
                if(!_currentCookie.CookieCitizeon.IsWorking)
                {
                    _currentCookie.CookieCitizeon.Hello();
                }
            }
            return;
        }
        _currentCookie = null;
    }

    public override void OnDrag()
    {
        if(_currentCookie != null)
        {
            if (DetectUI()) return;

            if (!_isDrag)
            {
                _cookieOffsetPosition = _currentCookie.transform.position;
                _currentCookie.CookieCitizeon.StopKingdomAI();
                _currentCookie.CharacterAnimator.PlayAnimation("hang");
                _currentCookie.transform.GetChild(0).localPosition += Vector3.up * 3f;
                _isDrag = true;
            }

            Vector2 currentPos = Vector2.zero;
            if (Mouse.current != null && Mouse.current.enabled)
                currentPos = Mouse.current.position.ReadValue();
            else if (Touchscreen.current != null && Touchscreen.current.enabled)
                currentPos = Touchscreen.current.position.ReadValue();

            Vector3 pos = _camera.ScreenToWorldPoint(currentPos);
            _currentCookie.transform.localPosition = new Vector3(pos.x, pos.y, 0);
        }
        else
        {
            base.OnDrag();
        }
    }

    public override void OnDragEnd()
    {
        base.OnDragEnd();

        if(_currentCookie != null)
        {
            _isDrag = false;

            _currentCookie.CookieCitizeon.TeleportValidPosition(_cookieOffsetPosition);
            _currentCookie.transform.GetChild(0).localPosition -= Vector3.up * 3f;
            _currentCookie.CookieCitizeon.StartKingdomAI();

            _currentCookie = null;
        }

    }

    public override void OnWheel(InputAction.CallbackContext value)
    {
        base.OnWheel(value);
    }

    public override void Update()
    {

    }
}
