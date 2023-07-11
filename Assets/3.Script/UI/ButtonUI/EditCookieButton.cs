using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;



public class EditCookieButton : MonoBehaviour
{
    private enum EState { unSelected, selected, Size}

    public System.Action<BaseController> onClickButton = null;

    private CookieController _cookie;
    private CookieData _data;

    [Header("����")]
    [SerializeField] private Button _editCookieButton;
    [SerializeField] private Image _portraitImage;
    [SerializeField] private Image _typeImage;
    [SerializeField] private TextMeshProUGUI _levelText;

    [SerializeField] private RectTransform _starParent;
    [SerializeField] private RectTransform[] _stars;

    [Header("����")]
    [SerializeField] private GameObject _selectedImage;
    [SerializeField] private Button _infoButton;
    [SerializeField] private Button _offButton;

    private CookieSelectUI _cookieSelectUI;
    
    private int _currentIndex;
    private int CurrentIndex
    {
        get
        {
            return _currentIndex;
        }
        set
        {
            _currentIndex = value;

            if (_currentIndex == (int)EState.Size)
                _currentIndex = 0;
        }
    }

    private void Awake()
    {
        _cookieSelectUI = FindObjectOfType<CookieSelectUI>();
    }

    public void UpdateUI(CookieController cookie)
    {
        _cookie = cookie;
        _data = (CookieData)(_cookie.Data);

        _portraitImage.sprite = _data.IdleSprite;
        _typeImage.sprite = _data.TypeSprite;
        _levelText.text = _cookie.CookieStat.CookieLevel.ToString();

        // �ߺ����ִ� ��Ű���
        foreach(BaseController selectedCookie in _cookieSelectUI.SelectedTempCookies)
            if(selectedCookie.Data.CharacterName == _data.CharacterName)
            {
                CurrentIndex = 1;
                _selectedImage.SetActive(true);
            }

        _editCookieButton.onClick.RemoveAllListeners();
        _editCookieButton.onClick.AddListener(() => OnClickEditCookieButton(CurrentIndex++));

        // �� ����ȭ
        for (int i = 0; i < _stars.Length; i++)
            _stars[i].gameObject.SetActive(false);
        for (int i = 0; i < _cookie.CookieStat.EvolutionCount; i++)
            _stars[i].gameObject.SetActive(true);
        _starParent.anchoredPosition = -(Vector3.right * _stars[0].sizeDelta.x * _cookie.CookieStat.EvolutionCount * 0.5f);
    }

    public void InitUI()
    {
        CurrentIndex = 1;
        OnClickEditCookieButton(CurrentIndex++);
    }

    private void OnClickEditCookieButton(int index)
    {
        InitButton();

        EState state = (EState)index; 

        switch (state)
        {
            case EState.unSelected:
                OnClickUnSelected();
                break;
            case EState.selected:
                OnClickOff();
                break;
/*            case EState.info:
                OnClickInfo();
                break;
            case EState.off:
                OnClickOff();
                break; */
        }
    }

    private void InitButton()
    {
        _selectedImage.SetActive(false);
        _infoButton.gameObject.SetActive(false);
        _offButton.gameObject.SetActive(false);
    }

    private void OnClickUnSelected()
    {
        // �̰� ������ üũ �׸� �����ְ�
        // cookieSelectUI�� �ø���.
        _selectedImage.SetActive(true);
        _cookieSelectUI.AddCookie(_cookie);
    }

    private void OnClickSelected()
    {
        // üũ �׸� ���ְ� �ʷϻ� �������� ��ư �����ְ�
        // cookieSelectUI�� �ִ� ��Ű�� ȭ��ǥ�� �����ְ� �����ϱ� ��ư �����ش�.

        _infoButton.gameObject.SetActive(true);
    }

    private void OnClickInfo()
    {
        // �������� ��ư ���ְ� ������ ���� ��ư �����ְ�
        // ���� �����ش�.

        // ȭ��ǥ�� �״�� => �Լ��� ���°� ������

        _offButton.gameObject.SetActive(true);
    }

    private void OnClickOff()
    {
        // ������ ��ư�� ó�� ���·� ���ư���
        // cookieSelectUI�� �����Ѵ�.

        _cookieSelectUI.RemoveCookie(_cookie);
    }
}
