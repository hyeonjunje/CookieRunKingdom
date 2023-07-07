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


        // ���⼭ ���� UI�� �����ϱ� 
        // ���⼭ �ʱⰪ �־��ָ� ��
        _originPos = _currentBuilding.transform.position;

        // Ű�� �� �ڸ� ��������� ��
        _currentBuilding.BuildingEditor.UnInstallBuilding();
    }

    public void HideUI()
    {
        buttonsParent.SetActive(false);

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
        Debug.Log(_currentBuilding.name);
    }

    public void ExitUI()
    {
        // ������� ��ġ��Ŵ
        _currentBuilding.transform.position = _originPos;
        _currentBuilding.BuildingEditor.PutBuilding();

        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        buttonsParent.SetActive(false);
    }

    public void StoreBuilding()
    {
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        buttonsParent.SetActive(false);

        Debug.Log("�ָӴϿ� �ֱ�");
    }

    public void RotateBuilding()
    {
        Debug.Log("ȸ��!");
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
            buttonsParent.SetActive(false);
        }
        else
        {
            GuideDisplayer.Instance.ShowGuide("�� �� ���� �ǹ��Դϴ�.");
        }
    }

    #endregion
}
