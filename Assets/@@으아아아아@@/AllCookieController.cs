using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class AllCookieController : MonoBehaviour
{
    [SerializeField] private CookieController[] cookies;

    public void OnClick(InputAction.CallbackContext value)
    {
        if(value.started)
        {
            foreach(CookieController cookie in cookies)
            {
                cookie.Act();
            }
        }
    }
}
