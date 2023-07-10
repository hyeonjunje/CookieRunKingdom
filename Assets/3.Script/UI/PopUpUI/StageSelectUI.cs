using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;  
using TMPro;
using DG.Tweening;

public class StageSelectUI : BaseUI
{
    private StageData _stageData;
    private Vector3 _touchPos;
    private int _starCount;

    [SerializeField] private TextMeshProUGUI _powerAmountText;
    [SerializeField] private BattleCookieButton _battleCookieButtonPrefab;
    [SerializeField] private Transform _cookieParent;

    [SerializeField] private TextMeshProUGUI _stageNameText;
    [SerializeField] private TextMeshProUGUI _stageRecommandPowerText;
    [SerializeField] private GameObject[] _starObjects;

    [SerializeField] private CookieSelectUI _cookieSelectUI;

    private float _prevOrthoSize;
    private Vector3 _prevCameraPos;
    private Camera _camera;

    private KingdomManager _manager;


    public override void Init()
    {
        base.Init();
        _manager = FindObjectOfType<KingdomManager>();
        _camera = Camera.main;
    }

    public void InitStageData(StageData stageData, Vector3 touchPos, int starCount = 3)
    {
        _stageData = stageData;
        _touchPos = touchPos;
        _starCount = starCount;

        _stageNameText.text = stageData.StageName;
        _stageRecommandPowerText.text = stageData.RecommendedPower.ToString("#,##0");

        // 별 채우기
        foreach (GameObject star in _starObjects)
            star.SetActive(false);

        for (int i = 0; i < starCount; i++)
            _starObjects[i].SetActive(true);
    }

    public override void Show()
    {
        base.Show();

        // 카메라 조정
        _manager.IsMoveCamera = false;

        _prevOrthoSize = _camera.orthographicSize;
        _prevCameraPos = _camera.transform.position;

        Sequence seq = DOTween.Sequence();
        seq.Append(_camera.transform.DOMove(_touchPos + _manager.CurrentCameraControllerData.CameraBuildingZoomOffset, 0.5f))
            .Join(_camera.DOOrthoSize(_manager.CurrentCameraControllerData.CameraBuildingZoom, 0.5f));

        // 쿠키 보여주자
        _cookieParent.DestroyAllChild();
        List<CookieController> cookies = _manager.allCookies;
        List<BattleCookieButton> buttons = new List<BattleCookieButton>();
        for(int i = 0; i < 5; i++)
        {
            buttons.Add(Instantiate(_battleCookieButtonPrefab, _cookieParent));
            buttons[i].UpdateInfo(null);
        }

        int count = 0;
        int power = 0;
        for (int i = 0; i < cookies.Count; i++)
        {
            if (cookies[i].CookieStat.IsBattleMember)
            {
                buttons[count++].UpdateInfo(cookies[i]);
                power += cookies[i].CharacterStat.powerStat;
            }
        }
        _powerAmountText.text = power.ToString();
    }

    public override void Hide()
    {
        _manager.IsMoveCamera = true;

        base.Hide();
    }

    #region 버튼에 이벤트로 넣어줄 메소드
    public void ExitUI()
    {
        Sequence seq = DOTween.Sequence();
        seq.Append(_camera.DOOrthoSize(_prevOrthoSize, 0.5f))
            .Join(_camera.transform.DOMove(_prevCameraPos, 0.5f));

        GameManager.UI.ExitPopUpUI();
    }

    public void OnClickBattleReadyButton()
    {
        Camera.main.orthographicSize = _manager.CurrentCameraControllerData.CameraZoomMax;  // 11 

        _cookieSelectUI.InitStageData(_stageData, _prevCameraPos, _prevOrthoSize);

        GameManager.UI.PopUI();
        GameManager.UI.PushUI(_cookieSelectUI);
    }
    #endregion
}
