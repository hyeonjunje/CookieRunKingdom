using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieController : MonoBehaviour
{
    [Header("데이터")]
    [SerializeField] private CookieData _cookieData;

    // 컴포넌트
    private CookieAnimator _cookieAnimator;
    private CookieBattleController _cookieBattleController;

    public CookieData Data => _cookieData;
    public CookieAnimator CookieAnim => _cookieAnimator;

    private void Awake()
    {
        _cookieAnimator = GetComponent<CookieAnimator>();
        _cookieBattleController = GetComponent<CookieBattleController>();
        _cookieAnimator.Init(this, _cookieData.CookieAnimationData);
        _cookieBattleController.Init(this, _cookieData);
    }

    public void Act()
    {
        _cookieAnimator.Act();
    }
}
