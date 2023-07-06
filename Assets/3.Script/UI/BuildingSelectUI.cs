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

    private void Awake()
    {
        exitButton.AddListener(ExitUI);
        storeButton.AddListener(StoreBuilding);
        checkButton.AddListener(CheckBuilding);
        sellButton.AddListener(SellBuilding);
        rotateButton.AddListener(RotateBuilding);
        infoButton.AddListener(ShowInfo);
    }

    public void SetBuilding(BuildingController currentBuilding, Transform parent, float cameraOrthographicSize = 10f)
    {
        _currentBuilding = currentBuilding;

        buttonsParent.SetActive(true);
        transform.SetParent(parent);
        transform.localPosition = Vector3.zero;
        transform.localRotation = Quaternion.identity;
        transform.localScale = Vector3.one * (cameraOrthographicSize) / 10;
    }

    public void HideUI()
    {
        buttonsParent.SetActive(false);
    }

    public void ShowInfo()
    {
        Debug.Log(_currentBuilding.name);
    }

    public void ExitUI()
    {
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        buttonsParent.SetActive(false);
    }

    public void StoreBuilding()
    {
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
        _currentBuilding.BuildingEditor.PutBuilding();
    }
}
