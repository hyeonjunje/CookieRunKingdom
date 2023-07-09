using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieStat : MonoBehaviour
{
    public int cookieLevel;
    public int skillLevel;
    public int evolutionCount;
    public bool isBattleMember;

    private CookieController _controller;

    public void Init(CookieController controller)
    {
        _controller = controller;
    }
}
