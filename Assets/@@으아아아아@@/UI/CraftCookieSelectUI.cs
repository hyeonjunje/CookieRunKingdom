using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CraftCookieSelectUI : BaseUI
{
    public System.Action<CookieController> changeWorkerAction = null;

    [SerializeField] private SelectCraftCookieButton _buttonPrefab;
    [SerializeField] private RectTransform _buttonParent;
    [SerializeField] private Button _exitButton;

    private List<SelectCraftCookieButton> _buttonList;
    private KingdomManager _kingdomManager;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Init()
    {
        base.Init();

        _buttonList = new List<SelectCraftCookieButton>();
        _kingdomManager = FindObjectOfType<KingdomManager>();
        List<CookieController> cookies = _kingdomManager.allCookies;

        for (int i = 0; i < cookies.Count; i++)
        {
            SelectCraftCookieButton button = Instantiate(_buttonPrefab, _buttonParent);
            button.InitInfo(cookies[i], (cookie) =>
            {
                changeWorkerAction?.Invoke(cookie);
                GameManager.UI.ExitPopUpUI();
            });
            _buttonList.Add(button);
        }

        _exitButton.onClick.AddListener(() => GameManager.UI.ExitPopUpUI());
    }

    public override void Show()
    {
        base.Show();

        List<CookieController> cookies = _kingdomManager.allCookies;
        int cookieCount = 0;
        // ���� �� �ִ� ��Ű�� �����ֱ�
        for (int i = 0; i < _buttonList.Count; i++)
        {
            if(cookies[i].CookieCitizeon.IsWorking)
            {
                _buttonList[i].gameObject.SetActive(false);
            }
            else
            {
                _buttonList[i].gameObject.SetActive(true);
                _buttonList[i].UpdataInfo();
                cookieCount++;
            }
        }

        _buttonParent.sizeDelta = new Vector2((5 + (205) * cookieCount), _buttonParent.sizeDelta.y);
    }


}
