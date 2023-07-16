using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class CookieBundle : MonoBehaviour
{
    /// <summary>
    /// 2 3 1  전방
    /// 5 6 4  중앙
    /// 8 9 7  후방
    /// </summary>
    [SerializeField] private Transform[] cookiePositions;
    private int[,] priority = new int[,] { { 0, 1, 2 }, { 1, 2, 0 }, { 2, 1, 0 } };

    private List<CookieController> Cookies => BattleManager.instance.CookiesInBattleList;
    private int _cookieRunStateCount; 

    private float _startSpeed;
    private float _currentSpeed = 0f;
    private Camera _camera;

    private Tweener _cameraTween;

    public void ActiveMove(bool on)
    {
        if (on)
            _cookieRunStateCount++;
        else
            _cookieRunStateCount--;


        if(_cookieRunStateCount == Cookies.Count)
        {
            _currentSpeed = _startSpeed;
            _cameraTween.ChangeEndValue(6.5f, 1.5f, true).Restart();
        }
        else
        {
            _currentSpeed = 0f;
            _cameraTween.ChangeEndValue(5.0f, 1.5f, true).Restart();
        }
    }

    private void Update()
    {
        if (Cookies.Count == 0)
            return;

        transform.position += Utils.Dir.normalized * _currentSpeed * Time.deltaTime;
    }

    public void Init()
    {
        _camera = Camera.main;
        _cameraTween = _camera.DOOrthoSize(5.5f, 1.5f).SetAutoKill(false);

        for (int i= 0; i < Cookies.Count; i++)
            MovePosition(Cookies[i]);

        _startSpeed = Cookies[0].Data.MoveSpeed;

        foreach (BaseController cookie in Cookies)
        {
            cookie.gameObject.layer = LayerMask.NameToLayer("Cookie");
            cookie.CharacterBattleController.StartBattle(true);
            cookie.CharacterBattleController.SetEnemy(LayerMask.NameToLayer("Enemy"));
        }
    }

    private void MovePosition(CookieController cookie)
    {
        int battlePosition = cookie.CookieStat.BattlePosition;

        cookie.transform.SetParent(cookiePositions[battlePosition]);
        cookie.transform.localPosition = Vector3.zero;
        cookie.transform.SetParent(null);
        cookie.CharacterBattleController.SetPosition(this, cookiePositions[battlePosition]);
    }
}
