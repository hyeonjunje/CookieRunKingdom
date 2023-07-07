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

    [SerializeField] private GameObject _levelUI;
    [SerializeField] private GameObject _lockedUI;

    private CookieController _cookie;
    private CookieData _data;
    private bool _isOwned = false;

    public void InitInfo(CookieController cookie, System.Action<CookieController, bool> action = null)
    {
        _isOwned = false;
        _cookie = cookie;
        _data = ((CookieData)_cookie.Data);

        List<CookieController> _ownedCookies = DataBaseManager.Instance.OwnedCookies;
        for(int i = 0; i < _ownedCookies.Count; i++)
        {
            if(cookie.Data.CharacterName == _ownedCookies[i].Data.CharacterName)
            {
                _cookie = _ownedCookies[i];
                _isOwned = true;
                break;
            }
        }

        _portraitImage.material = _data.IdleBlackMaterial;
        UpdateInfo();

        myCookieButton.onClick.AddListener(() => action(_cookie, _isOwned));
    }

    public void UpdateInfo()
    {
        // 보유하고 있다면
        if(_isOwned)
        {
            _portraitImage.sprite = _data.IdleSprite;
            _typeImage.sprite = _data.TypeSprite;
            _levelText.text = 60.ToString();

            _evolutionGauge.value = (float)11 / 20;
            _evolutionGaugeText.text = "11/20";
            _evolutionImage.sprite = _data.EvolutionSprite;

            _portraitImage.material.SetFloat("_Saturation", 1);

            _levelUI.SetActive(true);
            _lockedUI.SetActive(false);
        }
        // 보유하고 있지 않다면
        else
        {
            _portraitImage.sprite = _data.IdleSprite;
            _typeImage.sprite = _data.TypeSprite;
            _levelText.text = "";


            _evolutionGauge.value = (float)0 / 20;
            _evolutionGaugeText.text = "0/20";
            _evolutionImage.sprite = _data.EvolutionSprite;

            _portraitImage.material.SetFloat("_Saturation", 0);

            _levelUI.SetActive(false);
            _lockedUI.SetActive(true);
        }
    }
}
