using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class SelectCraftCookieButton : MonoBehaviour
{
    [SerializeField] private Button _selectCraftCookieButton;

    [SerializeField] private Image _portraitImage;
    [SerializeField] private Image _typeImage;
    [SerializeField] private TextMeshProUGUI _levelText;

    private CookieController _cookie;
    private CookieData _data;

    public void InitInfo(CookieController cookie, System.Action<CookieController> action = null)
    {
        _cookie = cookie;
        _data = ((CookieData)_cookie.Data);

        UpdataInfo();

        // 버튼 온클릭 재할당
        _selectCraftCookieButton.onClick.RemoveAllListeners();
        _selectCraftCookieButton.onClick.AddListener(() => action(_cookie));
    }

    public void UpdataInfo()
    {
        _portraitImage.sprite = _data.IdleSprite;
        _typeImage.sprite = _data.TypeSprite;
        _levelText.text = 60.ToString();
    }
}
