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

        BaseController[] allCookies = DataBaseManager.Instance.AllCookies;
        allCookieButton = new MyCookieButtonUI[allCookies.Length];

        for (int i = 0; i < allCookies.Length; i++)
        {
            MyCookieButtonUI cookieButtonUI = Instantiate(_cookieButtonUIPrefab, _cookieButtonTransform);
            int index = i;
            cookieButtonUI.InifInfo(allCookies[index], (cookie, isOwned) =>
            {
                _cookieInfoUI.SetCookie(cookie, isOwned);
                GameManager.UI.ShowPopUpUI(_cookieInfoUI);
            });
            allCookieButton[i] = cookieButtonUI;
        }

        _cookieButtonTransform.sizeDelta = new Vector2(_cookieButtonTransform.sizeDelta.x, 20 + 310 * (allCookies.Length / 5 + 1));
    }

    public override void Show()
    {
        base.Show();

        _manager.IsMoveCamera = false;

        for (int i = 0; i < allCookieButton.Length; i++)
        {
            allCookieButton[i].UpdateInfo();
        }
    }

    public void Exit()
    {
        GameManager.UI.ExitPopUpUI();
    }
}
