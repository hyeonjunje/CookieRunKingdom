using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingSelectUI : MonoBehaviour
{
    private BuildingController _currentBuilding;

    [SerializeField] private GameObject buttonsParent;

    [Header("MyButtons")]
    [SerializeField] private MyButton exitButton;
    [SerializeField] private MyButton storeButton;
    [SerializeField] private MyButton checkButton;
    [SerializeField] private MyButton sellButton;
    [SerializeField] private MyButton rotateButton;
    [SerializeField] private MyButton infoButton;

    private Vector3 _originPos;

    private void Awake()
    {
        exitButton.AddListener(ExitUI);
        storeButton.AddListener(StoreBuilding);
        checkButton.AddListener(CheckBuilding);
        sellButton.AddListener(SellBuilding);
        rotateButton.AddListener(RotateBuilding);
        infoButton.AddListener(ShowInfo);
    }

    public void SetPrevBuilding()
    {
        if(_currentBuilding != null)
        {
            _currentBuilding.transform.position = _originPos;
            _currentBuilding.BuildingEditor.PutBuilding();
        }
    }

    public void SetBuilding(BuildingController currentBuilding, Transform parent, float cameraOrthographicSize = 10f)
    {
        _currentBuilding = currentBuilding;

        buttonsParent.SetActive(true);
        transform.SetParent(parent);
        transform.localPosition = Vector3.zero;
        transform.localRotation = Quaternion.identity;
        transform.localScale = Vector3.one * (cameraOrthographicSize) / 10;


        // 여기서 빌딩 UI가 나오니까 
        // 여기서 초기값 넣어주면 됨
        _originPos = _currentBuilding.transform.position;

        // 키면 내 자리 해제해줘야 해
        _currentBuilding.BuildingEditor.UnInstallBuilding();
    }

    public void HideUI()
    {
        buttonsParent.SetActive(false);

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
        Debug.Log(_currentBuilding.name);
    }

    public void ExitUI()
    {
        // 원래대로 위치시킴
        _currentBuilding.transform.position = _originPos;
        _currentBuilding.BuildingEditor.PutBuilding();

        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        buttonsParent.SetActive(false);
    }

    public void StoreBuilding()
    {
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        buttonsParent.SetActive(false);

        Debug.Log("주머니에 넣기");
    }

    public void RotateBuilding()
    {
        Debug.Log("회전!");
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
            buttonsParent.SetActive(false);
        }
        else
        {
            GuideDisplayer.Instance.ShowGuide("팔 수 없는 건물입니다.");
        }
    }

    #endregion
}
