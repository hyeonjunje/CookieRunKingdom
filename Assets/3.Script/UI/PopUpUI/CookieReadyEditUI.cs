using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CookieReadyEditUI : BaseUI
{
    [Header("UI")]
    [SerializeField] private CookieReadyAdventureUI _cookieReadyAdventrueUI;
    [SerializeField] private Button _exitButton;
    [SerializeField] private Button _allOffCookiesButton;

    [Header("Prefab")]
    [SerializeField] private RectTransform _cookieButtonTransform;
    [SerializeField] private EditCookieButton _cookieButton;

    [SerializeField] private Transform _cookiePosition;

    
    private CookieSelectUI _cookieSelectUI;
    private Vector3 _cookiePositionArrange;
    private List<EditCookieButton> _editCookieButtons;

    private List<BaseController> SelectedCookies => _cookieSelectUI.SelectedCookies;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Init()
    {
        base.Init();

        _cookieSelectUI = FindObjectOfType<CookieSelectUI>();

        _cookiePositionArrange = _cookiePosition.position + Vector3.right * 7.5f;
        BindingButton();
    }

    public override void Show()
    {
        base.Show();

        _cookiePosition.position = _cookiePositionArrange;

        _cookieButtonTransform.DestroyAllChild();
        _editCookieButtons = new List<EditCookieButton>();

        BaseController[] cookies = DataBaseManager.Instance.AllCookies;
        _cookieButtonTransform.sizeDelta = new Vector2(20 + cookies.Length * 200, _cookieButtonTransform.sizeDelta.y);
        for(int i = 0; i < cookies.Length; i++)
        {
            EditCookieButton cookieButton = Instantiate(_cookieButton, _cookieButtonTransform);
            _editCookieButtons.Add(cookieButton);
            cookieButton.UpdateUI(cookies[i]);
        }
    }

    private void BindingButton()
    {
        _exitButton.onClick.AddListener(() =>
        {
            GameManager.UI.ExitPopUpUI();
            GameManager.UI.ShowPopUpUI(_cookieReadyAdventrueUI);
        });

        _allOffCookiesButton.onClick.AddListener(() =>
        {
            while(SelectedCookies.Count != 0)
            {
                _cookieSelectUI.RemoveCookie(SelectedCookies[0]);
            }

            foreach(EditCookieButton button in _editCookieButtons)
            {
                button.InitUI();
            }
        });
    }
}
