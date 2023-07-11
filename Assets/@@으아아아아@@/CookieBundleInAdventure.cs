using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using Pathfinding;

public class CookieBundleInAdventure : MonoBehaviour
{
    [SerializeField] private Transform[] _poses;
    [SerializeField] private CookiePathFinder[] _cookiePathFinder;

    private KingdomManager _manager;
    private Camera _cam;
    private bool _isCompletePosition;  // bundle이 제대로 위치했는지

    private Path _path;
    private Seeker _seeker;

    private bool isInit = false;

    public void Init()
    {
        if(!isInit)
        {
            _manager = FindObjectOfType<KingdomManager>();
            _seeker = GetComponent<Seeker>();
            _cam = Camera.main;
            isInit = true;
        }

        List<CookieController> allCookies = _manager.allCookies;

        for(int i = 0; i < _cookiePathFinder.Length; i++)
            _cookiePathFinder[i].Init(null, null);

        int cookieCount = 0;
        for(int i = 0; i < allCookies.Count; i++)
        {
            if(allCookies[i].CookieStat.IsBattleMember)
            {
                int positionIndex = allCookies[i].CookieStat.BattlePosition;
                _cookiePathFinder[cookieCount++].Init(allCookies[i].Data, _poses[positionIndex]);
            }
        }
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        if (value.started)
        {
            if (!_manager.IsMoveCamera)
                return;

            _isCompletePosition = false;

            Vector3 targetPos = _cam.ScreenToWorldPoint(Mouse.current.position.ReadValue());
            _seeker.StartPath(transform.position, targetPos, OnPathComplete);
        }
    }

    private void OnPathComplete(Path p)
    {
        if (!p.error)
        {
            _path = p;

            Vector3 lastPos = _path.vectorPath[_path.vectorPath.Count - 1];
            Vector3 prevPos = _path.vectorPath[_path.vectorPath.Count - 2];

            float theta = Mathf.Atan((lastPos.y - prevPos.y) / (lastPos.x - prevPos.x)) * Mathf.Rad2Deg;
            if (lastPos.x == prevPos.x)
                theta = 90;

            transform.position = lastPos;
            transform.localEulerAngles = Vector3.forward * theta + Vector3.forward * 90;

            for(int i = 0; i < _cookiePathFinder.Length; i++)
                _cookiePathFinder[i].StartPathFinding();
        }
    }
}



