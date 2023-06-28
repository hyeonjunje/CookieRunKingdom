using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieBattleController : MonoBehaviour
{
    private CookieController _cookieController;
    private CookieData _cookieData;
    private CookieBattleStateFactory _factory;
    private Coroutine _coUpdate = null;

    public void Init(CookieController cookieController, CookieData cookieData)
    {
        _cookieController = cookieController;
        _cookieData = cookieData;

        _factory = new CookieBattleStateFactory(cookieController);
        
        // 일단은 여기서 하는데 나중에 바꿔야ㅕ 해
        StartBattle();
    }

    public void StartBattle()
    {
        if (_coUpdate != null)
            StopCoroutine(_coUpdate);
        _coUpdate = StartCoroutine(CoUpdate());
    }

    private IEnumerator CoUpdate()
    {
        while(true)
        {
            yield return null;
            _factory.CurrentState.Update();
        }
    }
}
