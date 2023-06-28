using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieController : MonoBehaviour
{
    [Header("Å×½ºÆ®")]
    public bool isTest = false;

    [SerializeField] private CookieData _cookieData;

    private CookieAnimator _cookieAnimator;

    public CookieData Data => _cookieData;
    public CookieAnimator CookieAnim => _cookieAnimator;

    private void Awake()
    {
        _cookieAnimator = GetComponent<CookieAnimator>();
        _cookieAnimator.Init(this, _cookieData.CookieAnimationData, isTest);
    }

    public void Act()
    {
        _cookieAnimator.Act();
    }
}
