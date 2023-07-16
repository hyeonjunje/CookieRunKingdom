using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using DG.Tweening;
using Spine.Unity;
using UnityEngine.InputSystem;


public class GachaCookieAppear : BaseUI
{
    [SerializeField] private GameObject _cookieAppearUI;
    [SerializeField] private SkeletonGraphic _skeletonGrapic;
    [SerializeField] private Transform _cookieBubbleSpeech;
    [SerializeField] private TextMeshProUGUI _cookiebubbleSpeechText;
    [SerializeField] private TextMeshProUGUI _cookieSpeechText;

    [SerializeField] private Image _cookieGradeImage;
    [SerializeField] private TextMeshProUGUI _cookieNameText;

    private CookieData _cookieData;

    private KingdomManager _manager;
    private Camera _camera;
    private Vector3 _originPos;
    private float _orthographicSize;

    private Sequence _speechSeq;
    private Sequence _appearSeq;

    private int _clickCount;

    private bool _isSkip = false;

    public int ClickCount
    {
        get { return _clickCount; }
        set
        {
            _clickCount = value;

            if (_clickCount == 0)
            {
                _cookieSpeechText.transform.localScale = Vector3.zero;
                _cookieSpeechText.text = _cookieData.AppearSpeech;

                _appearSeq.Pause();
                _speechSeq.Restart();
            }
            else if(_clickCount == 1)
            {
                _cookieAppearUI.SetActive(true);
                _skeletonGrapic.skeletonDataAsset = _cookieData.CookiePortrait;
                _skeletonGrapic.Initialize(true);
                _skeletonGrapic.AnimationState.SetAnimation(0, "idle", true);
                _cookiebubbleSpeechText.text = _cookieData.BubbleSpeech;
                _cookieGradeImage.sprite = _cookieData.CookieGradeSprite;
                _cookieNameText.text = _cookieData.CharacterName;

                _cookieBubbleSpeech.transform.localScale = Vector3.zero;
                _speechSeq.Pause();
                _appearSeq.Restart();
            }
            else if(_clickCount == 2)
            {
                _appearSeq.Pause();
                _cookieAppearUI.SetActive(false);
                GameManager.UI.PopUI();
            }
        }
    }

    public void InitCookie(CookieData cookieData)
    {
        _cookieData = cookieData;
    }

    public override void Hide()
    {
        base.Hide();

        _manager.IsMoveCamera = true;
        _camera.transform.position = _originPos;
        _camera.orthographicSize = _orthographicSize;
    }

    public override void Init()
    {
        base.Init();

        _camera = Camera.main;
        _manager = FindObjectOfType<KingdomManager>();

        _speechSeq = DOTween.Sequence();
        _appearSeq = DOTween.Sequence();

        // speechSeq�� ��� ������ �� �Ѹ��� �� 4��
        // appearSeq�� ĳ���� ������ ��ǳ�������� => ���콺 �Է��� �־�߸� ���� �� ����

        _speechSeq.SetAutoKill(false).Pause()
            .AppendInterval(0.05f)
            .AppendCallback(() => _isSkip = true)
            .Append(_cookieSpeechText.transform.DOScale(Vector3.one, 0.8f))
            .AppendInterval(2f)
            .Append(_cookieSpeechText.transform.DOScale(Vector3.zero, 0.5f))
            .OnComplete(() => ClickCount = 1);

        _appearSeq.SetAutoKill(false).Pause()
            .Append(_cookieBubbleSpeech.DOScale(new Vector3(-1, 1, 1), 0.3f))
            .SetEase(Ease.InBounce);
    }

    public override void Show()
    {
        base.Show();

        ClickCount = 0;
        _isSkip = false;

        _manager.IsMoveCamera = false;
        _originPos = _camera.transform.position;
        _orthographicSize = _camera.orthographicSize;

        _camera.transform.position = Vector3.forward * -10;
        _camera.orthographicSize = 12.3f;
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        if(value.canceled && _isSkip)
        {
            ClickCount++;
        }
    }
}
