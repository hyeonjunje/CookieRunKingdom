using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieSelectUI : BaseUI
{
    private KingdomManager _manager;

    private Camera _camera;
    private StageData _stageData;
    private Vector3 _prevCameraPos;
    private float _prevOrthosize;

    private void Awake()
    {
        _manager = FindObjectOfType<KingdomManager>();
        _camera = Camera.main;
    }

    public void InitStageData(StageData stageData, Vector3 prevCameraPos, float prevOrthoSize)
    {
        _stageData = stageData;
        _prevCameraPos = prevCameraPos;
        _prevOrthosize = prevOrthoSize;
    }

    public override void Hide()
    {
        _manager.IsMoveCamera = true;
        _camera.orthographicSize = _prevOrthosize;
        _camera.transform.position = _prevCameraPos;

        base.Hide();
    }

    public override void Show()
    {
        base.Show();
        _manager.IsMoveCamera = false;
    }

    #region 버튼에 이벤트로 넣어줄 메소드
    public void ExitUI()
    {
        GameManager.UI.PopUI();
    }
    #endregion
}
