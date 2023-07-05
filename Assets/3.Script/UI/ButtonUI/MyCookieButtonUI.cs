using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class MyCookieButtonUI : MonoBehaviour
{
    [SerializeField] private Button myCookieButton;

    [SerializeField] private Image _portraitImage;
    [SerializeField] private Image _typeImage;
    [SerializeField] private TextMeshProUGUI _levelText;

    [SerializeField] private Slider _evolutionGauge;
    [SerializeField] private TextMeshProUGUI _evolutionGaugeText;
    [SerializeField] private Image _evolutionImage;

    private BaseController _cookie;

    public void InifInfo(BaseController cookie, System.Action<BaseController> action = null)
    {
        _cookie = cookie;
        UpdateInfo();

        myCookieButton.onClick.AddListener(() => action(_cookie));
    }

    public void UpdateInfo()
    {
        _portraitImage.sprite = ((CookieData)_cookie.Data).IdleSprite;
        _typeImage.sprite = ((CookieData)_cookie.Data).TypeSprite;
        _levelText.text = 60.ToString();

        _evolutionGauge.value = (float)41 / 50;
        _evolutionGaugeText.text = "41/50";
        _evolutionImage.sprite = ((CookieData)_cookie.Data).EvolutionSprite;
    }
}
