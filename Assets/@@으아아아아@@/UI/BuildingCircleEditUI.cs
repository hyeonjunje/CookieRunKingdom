using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingCircleEditUI : MonoBehaviour
{
    protected BuildingController _currentBuilding;

    [SerializeField] protected GameObject _buttonsParent;

    [Header("MyButtons")]
    [SerializeField] protected MyButton _exitButton;
    [SerializeField] protected MyButton _storeButton;
    [SerializeField] protected MyButton _checkButton;
    [SerializeField] protected MyButton _sellButton;
    [SerializeField] protected MyButton _rotateButton;
    [SerializeField] protected MyButton _infoButton;

    [Header("UI")]
    [SerializeField] protected BuildingInfoUI _buildingInfoUI;
    [SerializeField] protected KingdomEditUI _kingdomEditUI;
    
    // �ٸ��� ��Ȱ��ȭ�Ǿ� �ִµ� �길 Ȱ��ȭ�Ǿ� �ֱ� ������ ��� �׳� �ڵ�� ã����
    protected KingdomManager _kingdomManager;  

    protected Vector3 _originPos;
    protected bool _originFlip;
    protected bool _currentFlip;

    public GameObject ButtonParent => _buttonsParent;

    private void Awake()
    {
        _kingdomManager = FindObjectOfType<KingdomManager>();

        _exitButton.AddListener(ExitUI);
        _storeButton.AddListener(StoreBuilding);
        _checkButton.AddListener(CheckBuilding);
        _sellButton.AddListener(SellBuilding);
        _rotateButton.AddListener(RotateBuilding);
        _infoButton.AddListener(ShowInfo);
    }

    public virtual void SetPrevBuilding(BuildingController currentBuilding)
    {
        // ���� �ǹ� �����·� ������
        if (_currentBuilding != null && _currentBuilding != currentBuilding)
        {
            _currentBuilding.transform.position = _originPos;
            _currentBuilding.BuildingEditor.PutBuilding();
            _currentBuilding.BuildingAnimator.FlipX(_originFlip);
        }
    }

    public virtual void SetBuilding(BuildingController currentBuilding, Transform parent, float cameraOrthographicSize = 10f)
    {
        _buttonsParent.SetActive(true);

        if (currentBuilding != _currentBuilding)
        {
            _currentBuilding = currentBuilding;
            transform.SetParent(parent);
            transform.localPosition = Vector3.zero;
            transform.localRotation = Quaternion.identity;

            // ���⼭ ���� UI�� �����ϱ� 
            // ���⼭ �ʱⰪ �־��ָ� ��
            _originPos = _currentBuilding.transform.position;
            _originFlip = _currentBuilding.BuildingEditor.IsFlip;
            _currentFlip = _originFlip;

            // Ű�� �� �ڸ� ��������� ��

            if(_currentBuilding.BuildingEditor.IsInstallable() || _currentBuilding.BuildingEditor.IsInstance)
                _currentBuilding.BuildingEditor.UnInstallBuilding();
        }

        transform.localScale = Vector3.one * (cameraOrthographicSize) / 10;
    }

    public virtual void HideUI()
    {
        _buttonsParent.SetActive(false);

        if (_currentBuilding != null)
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
    public virtual void ShowInfo()
    {
        _buildingInfoUI.SetBuilding(_currentBuilding);
        GameManager.UI.ShowPopUpUI(_buildingInfoUI);
    }

    public virtual void ExitUI()
    {
        // ������� ��ġ��Ŵ
        _currentBuilding.transform.position = _originPos;
        _currentBuilding.BuildingAnimator.FlipX(_originFlip);
        _currentBuilding.BuildingEditor.PutBuilding();

        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        _buttonsParent.SetActive(false);

        _currentBuilding = null;
    }

    public virtual void StoreBuilding()
    {
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        _buttonsParent.SetActive(false);

        Debug.Log("�ָӴϿ� �ֱ�");
        _kingdomEditUI.AddBuilding(_currentBuilding);

        // kingdomManager�� ����
        // �ȿ� �ִ� ���ϴ� ��Ű ����
        // �ȿ� ���۵ǰ� �ִ� ���ǵ� �� ����
        // �ȿ� �ִ� UI ����
        // �ı���Ų��.
        _currentBuilding.BuildingEditor.IsInstance = false;
        _kingdomManager.buildingsInKingdom.Remove(_currentBuilding);
        if(_currentBuilding.BuildingWorker.Worker != null)
            _currentBuilding.BuildingWorker.Worker.CookieCitizeon.LeaveWork();
        _currentBuilding.BuildingWorker.InitCraftSlot();

        _currentBuilding.BuildingWorker.SaveBuilding();

        transform.SetParent(null);
        _currentBuilding.gameObject.SetActive(false);
    }

    public virtual void RotateBuilding()
    {
        _currentFlip = !_currentFlip;
        _currentBuilding.BuildingAnimator.FlipX(_currentFlip);
    }

    public virtual void SellBuilding()
    {
        Debug.Log("�ǹ��� �Ȳ���");
    }

    public virtual void CheckBuilding()
    {
        if (_currentBuilding.BuildingEditor.IsInstallable())
        {
            _originPos = _currentBuilding.transform.position;
            _currentBuilding.BuildingEditor.PutBuilding();

            BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
            _buttonsParent.SetActive(false);

            _currentBuilding.BuildingAnimator.FlipX(_currentFlip);
            _currentBuilding.BuildingEditor.IsFlip = _currentFlip;

            if(_currentBuilding.BuildingWorker.Worker != null)
            {
                _currentBuilding.BuildingWorker.Worker.CharacterAnimator.SettingOrder();
            }

            _currentBuilding = null;
        }
        else
        {
            GuideDisplayer.Instance.ShowGuide("�̰��� ��ġ�� �� �����ϴ�.");
        }
    }

    #endregion
}
