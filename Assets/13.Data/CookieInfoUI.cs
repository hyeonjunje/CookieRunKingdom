using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CookieInfoUI : BaseUI
{
    [Header("UI")]
    [SerializeField] private GameObject _kingdomManageUI;
    [SerializeField] private GameObject _myCookieUI;

    [Header("Right")]
    [SerializeField] private Image _cookieGradeImage;
    [SerializeField] private TextMeshProUGUI _cookieNameText;
    [SerializeField] private TextMeshProUGUI _cookieLevelText;
    [SerializeField] private Image _cookieTypeImage;
    [SerializeField] private TextMeshProUGUI _cookieTypeText;

    [SerializeField] private Color _originColor;
    [SerializeField] private Color[] _positionColors;  // 전방, 중앙, 후방
    [SerializeField] private Image[] _positionImages;
    [SerializeField] private TextMeshProUGUI _cookiePositionText;

    [Header("Center")]
    [SerializeField] private Transform _instantiateParent;
    [SerializeField] private Button _cookieInteractionButton;

    [Header("Left")]
    [SerializeField] private Image _cookieSKillImage;

    private BaseController _cookie;
    private CookieData _data;
    private Camera _camera;

    private float _prevCameraOrthoSize;
    private Vector3 _prevCameraPosition;
    private Coroutine _coTouch = null;

    public void SetCookie(BaseController cookie)
    {
        _cookie = cookie;
        _data = (CookieData)(_cookie.Data);
    }

    public override void Hide()
    {
        base.Hide();

        _myCookieUI.SetActive(true);
        _kingdomManageUI.SetActive(true);

        _camera.orthographicSize = _prevCameraOrthoSize;
        _camera.transform.position = _prevCameraPosition;

        _instantiateParent.DestroyAllChild();
    }

    public override void Init()
    {
        base.Init();

        _camera = Camera.main;
    }

    public override void Show()
    {
        base.Show();

        _myCookieUI.SetActive(false);
        _kingdomManageUI.SetActive(false);

        _prevCameraOrthoSize = _camera.orthographicSize;
        _prevCameraPosition = _camera.transform.position;

        _camera.orthographicSize = 11;
        _camera.transform.position = new Vector3(0, 0, -10);

        // 왼쪽
        _cookieGradeImage.sprite = _data.CookieGradeSprite;
        _cookieNameText.text = _data.CharacterName;
        _cookieLevelText.text = "60/75";
        _cookieTypeImage.sprite = _data.TypeSprite;

        for(int i = 0; i < _positionImages.Length; i++)
        {
            if(i == (int)_data.CookiePosition)
            {
                _positionImages[i].color = _positionColors[i];
                _cookiePositionText.color = _positionColors[i];
            }
            else
            {
                _positionImages[i].color = _originColor;
            }
        }

        _cookiePositionText.text = _data.CookiePositionName;

        // 중앙
        BaseController cookie = Instantiate(_cookie, _instantiateParent);
        cookie.CharacterAnimator.SettingOrderLayer(true);
        TouchCookie(cookie);
        cookie.transform.localScale = Vector3.one * 150;

        _cookieInteractionButton.onClick.AddListener(() => TouchCookie(cookie));

        // 오른쪽
        _cookieSKillImage.sprite = _data.SKillSprite;
    }

    public void Exit()
    {
        GameManager.UI.ExitPopUpUI();
    }


    private void TouchCookie(BaseController cookie)
    {
        // 터치하면 touch 애니메이션 실행하고 (대사까지 쳐주면 완벽)
        // 애니메이션이 끝나면 standard 애니메이션 무한재생
        if (_coTouch != null)
            StopCoroutine(_coTouch);
        _coTouch = StartCoroutine(CoTouch(cookie));
    }

    private IEnumerator CoTouch(BaseController cookie)
    {
        cookie.CharacterAnimator.PlayAnimation("touch", false);

        while (true)
        {
            if(cookie.CharacterAnimator.IsPlayingAnimation())
                yield return null;
            else
                break;
        }

        cookie.CharacterAnimator.PlayAnimation("standard");
    }
}
