using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyCookieUI : BaseUI
{
    [SerializeField] private CookieInfoUI _cookieInfoUI;

    [SerializeField] private MyCookieButtonUI _cookieButtonUIPrefab;
    [SerializeField] private RectTransform _cookieButtonTransform;

    private MyCookieButtonUI[] allCookieButton;

    private KingdomManager _manager;

    public override void Hide()
    {
        base.Hide();

        _manager.IsMoveCamera = true;
    }

    public override void Init()
    {
        base.Init();

        _manager = FindObjectOfType<KingdomManager>();

        List<CookieController> allCookies = _manager.allCookies;
        allCookieButton = new MyCookieButtonUI[allCookies.Count];

        List<CookieInfo> allCookieInfo = GameManager.Game.allCookies;
        for (int i = 0; i < allCookieInfo.Count; i++)
        {
            MyCookieButtonUI cookieButtonUI = Instantiate(_cookieButtonUIPrefab, _cookieButtonTransform);
            int index = i;

            cookieButtonUI.InitInfo(allCookies[allCookieInfo[i].cookieIndex], (cookie, isOwned) =>
            {
                _cookieInfoUI.SetCookie(cookie, isOwned);
                GameManager.UI.PushUI(_cookieInfoUI);
                // GameManager.UI.ShowPopUpUI(_cookieInfoUI);
            });
            allCookieButton[i] = cookieButtonUI;
        }

        _cookieButtonTransform.sizeDelta = new Vector2(_cookieButtonTransform.sizeDelta.x, 20 + 310 * (allCookies.Count / 5 + 1));
    }

    public override void Show()
    {
        base.Show();

        _manager.IsMoveCamera = false;

        for (int i = 0; i < allCookieButton.Length; i++)
        {
            Debug.Log("ÀÌ°ÍÁ»");
            allCookieButton[i].UpdateInfo();
        }
    }

    public void Exit()
    {
        GameManager.UI.ExitPopUpUI();
    }
}
