using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieController : BaseController
{
    protected CookieCitizen _cookieCitizen;

    public CookieCitizen CookieCitizeon => _cookieCitizen;

    protected override void Awake()
    {
        base.Awake();

        _cookieCitizen = GetComponent<CookieCitizen>();

        _cookieCitizen.Init(this);
    }
}
