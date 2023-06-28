using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieController : MonoBehaviour
{
    [Header("������")]
    [SerializeField] private CookieData _cookieData;

    // ������Ʈ
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
