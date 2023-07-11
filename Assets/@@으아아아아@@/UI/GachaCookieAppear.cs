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
    [SerializeField] private TextMeshProUGUI _cookiebubbleSpeech;
    [SerializeField] private TextMeshProUGUI _cookieSpeechText;

    [SerializeField] private Image _cookieGradeImage;
    [SerializeField] private TextMeshProUGUI _cookieNameText;

    private CookieData _cookieData;

    private KingdomManager _manager;
    private Camera _camera;
    private Vector3 _originPos;
    private float _orthographicSize;

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
    }

    public override void Show()
    {
        base.Show();

        _manager.IsMoveCamera = false;
        _originPos = _camera.transform.position;
        _orthographicSize = _camera.orthographicSize;

        _camera.transform.position = Vector3.forward * -10;
        _camera.orthographicSize = 11;

        _cookieSpeechText.transform.localScale = Vector3.zero;
        _cookieSpeechText.text = _cookieData.AppearSpeech;

        Sequence seq = DOTween.Sequence();
        seq.Append(_cookieSpeechText.transform.DOScale(Vector3.one, 0.3f))
            .SetEase(Ease.OutBack)
            .AppendInterval(3f)
            .AppendCallback(() =>
            {
                _cookieAppearUI.SetActive(true);
                _skeletonGrapic.skeletonDataAsset = _cookieData.CookiePortrait;
                _skeletonGrapic.Initialize(true);
                _skeletonGrapic.AnimationState.SetAnimation(0, "idle", true);
                _cookiebubbleSpeech.text = _cookieData.BubbleSpeech;
                _cookieGradeImage.sprite = _cookieData.CookieGradeSprite;
                _cookieNameText.text = _cookieData.CharacterName;
            })
            .AppendInterval(3f)
            .OnComplete(() =>
            {
                _cookieAppearUI.SetActive(false);
                GameManager.UI.PopUI();
            });
    }
}
