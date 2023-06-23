using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingSelectUI : MonoBehaviour
{
    private Building currentBuilding;

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

    public void SetBuilding(Building currentBuilding)
    {
        this.currentBuilding = currentBuilding;
    }

    public void ShowInfo()
    {
        Debug.Log(currentBuilding.name);
    }

    public void ExitUI()
    {
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        gameObject.SetActive(false);
    }

    public void StoreBuilding()
    {
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
        currentBuilding.PutBuilding();
    }
}
