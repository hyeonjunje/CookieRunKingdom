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
        // ���� �ǹ� �����·� ������
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

            // ���⼭ ���� UI�� �����ϱ� 
            // ���⼭ �ʱⰪ �־��ָ� ��
            _originPos = _currentBuilding.transform.position;
            _originFlip = _currentBuilding.BuildingEditor.IsFlip;
            _currentFlip = _originFlip;
        }

        _buttonsParent.SetActive(true);

        // Ű�� �� �ڸ� ��������� ��
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
    /// exitButton => ��������� ����ϴ°� => �ǹ��� ������� ���ư� => UI�� ������
    /// storeButton => �����ڸ��� �ٷ� â�� ��
    /// checkButton => ��ġ�� �� ������ �ٷ� ��ġ�ϰ� UI������
    /// sellButton => ���� UI�� �� ����
    /// rotateButton => �׳� ���⸸ �� => �̰� InitialFlipX �ϸ� �ɵ�
    /// infoButton => ���� UI�� �� ����
    /// </summary>

    #region ��ư OnClick �޼ҵ�
    public void ShowInfo()
    {
        _buildingInfoUI.SetBuilding(_currentBuilding);
        GameManager.UI.ShowPopUpUI(_buildingInfoUI);
    }

    public void ExitUI()
    {
        // ������� ��ġ��Ŵ
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

        Debug.Log("�ָӴϿ� �ֱ�");
    }

    public void RotateBuilding()
    {
        _currentFlip = !_currentFlip;
        _currentBuilding.BuildingAnimator.FlipX(_currentFlip);
    }

    public void SellBuilding()
    {
        Debug.Log("�ǹ��� �Ȳ���");
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
            GuideDisplayer.Instance.ShowGuide("�� �� ���� �ǹ��Դϴ�.");
        }
    }

    #endregion
}
