using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingSelectUI : MonoBehaviour
{
    private BuildingController _currentBuilding;

    [SerializeField] private GameObject _buttonsParent;

    [Header("MyButtons")]
    [SerializeField] private MyButton _exitButton;
    [SerializeField] private MyButton _storeButton;
    [SerializeField] private MyButton _checkButton;
    [SerializeField] private MyButton _sellButton;
    [SerializeField] private MyButton _rotateButton;
    [SerializeField] private MyButton _infoButton;

    [SerializeField] private BuildingInfoUI _buildingInfoUI;

    private Vector3 _originPos;
    private bool _originFlip;

    private bool _currentFlip;

    private void Awake()
    {
        _exitButton.AddListener(ExitUI);
        _storeButton.AddListener(StoreBuilding);
        _checkButton.AddListener(CheckBuilding);
        _sellButton.AddListener(SellBuilding);
        _rotateButton.AddListener(RotateBuilding);
        _infoButton.AddListener(ShowInfo);
    }

    public void SetEmpty()
    {
        _currentBuilding = null;
    }

    public void SetPrevBuilding(BuildingController currentBuilding)
    {
        // 이전 건물 원상태로 돌리기
        if(_currentBuilding != null && _currentBuilding != currentBuilding)
        {
            _currentBuilding.transform.position = _originPos;
            _currentBuilding.BuildingEditor.PutBuilding();
            _currentBuilding.BuildingAnimator.FlipX(_originFlip);
        }
    }

    public void SetBuilding(BuildingController currentBuilding, Transform parent, float cameraOrthographicSize = 10f)
    {
        if(currentBuilding != _currentBuilding)
        {
            _currentBuilding = currentBuilding;
            _buttonsParent.SetActive(true);
            transform.SetParent(parent);
            transform.localPosition = Vector3.zero;
            transform.localRotation = Quaternion.identity;

            // 여기서 빌딩 UI가 나오니까 
            // 여기서 초기값 넣어주면 됨
            _originPos = _currentBuilding.transform.position;
            _originFlip = _currentBuilding.BuildingEditor.IsFlip;
            _currentFlip = _originFlip;
        }

        _buttonsParent.SetActive(true);

        // 키면 내 자리 해제해줘야 해
        _currentBuilding.BuildingEditor.UnInstallBuilding();
        transform.localScale = Vector3.one * (cameraOrthographicSize) / 10;
    }

    public void HideUI()
    {
        _buttonsParent.SetActive(false);

        if(_currentBuilding != null)
            ExitUI();
    }


    /// <summary>
    /// exitButton => 변경사항을 취소하는거 => 건물은 원래대로 돌아감 => UI도 없어짐
    /// storeButton => 누르자마자 바로 창고에 들어감
    /// checkButton => 설치할 수 있으면 바로 설치하고 UI없어짐
    /// sellButton => 전용 UI가 또 나와
    /// rotateButton => 그냥 돌기만 해 => 이건 InitialFlipX 하면 될듯
    /// infoButton => 전용 UI가 또 나와
    /// </summary>

    #region 버튼 OnClick 메소드
    public void ShowInfo()
    {
        _buildingInfoUI.SetBuilding(_currentBuilding);
        GameManager.UI.ShowPopUpUI(_buildingInfoUI);
    }

    public void ExitUI()
    {
        // 원래대로 위치시킴
        _currentBuilding.transform.position = _originPos;
        _currentBuilding.BuildingAnimator.FlipX(_originFlip);
        _currentBuilding.BuildingEditor.PutBuilding();

        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        _buttonsParent.SetActive(false);

        _currentBuilding = null;
    }

    public void StoreBuilding()
    {
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        _buttonsParent.SetActive(false);

        Debug.Log("주머니에 넣기");
    }

    public void RotateBuilding()
    {
        _currentFlip = !_currentFlip;
        _currentBuilding.BuildingAnimator.FlipX(_currentFlip);
    }

    public void SellBuilding()
    {
        Debug.Log("건물을 팔꺼야");
    }

    public void CheckBuilding()
    {
        if(_currentBuilding.BuildingEditor.IsInstallable())
        {
            _originPos = _currentBuilding.transform.position;
            _currentBuilding.BuildingEditor.PutBuilding();

            BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
            _buttonsParent.SetActive(false);

            _currentBuilding.BuildingAnimator.FlipX(_currentFlip);
            _currentBuilding.BuildingEditor.IsFlip = _currentFlip;

            _currentBuilding = null;
        }
        else
        {
            GuideDisplayer.Instance.ShowGuide("팔 수 없는 건물입니다.");
        }
    }

    #endregion
}
