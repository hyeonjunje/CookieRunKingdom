using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class TrainCar : MonoBehaviour
{
    [SerializeField] private Sprite checkSprite;
    [SerializeField] private Image trainCarImage;
    [SerializeField] private TextMeshProUGUI trainCarCapacity;

    private ItemData _currentItemData = null;
    private int _amount = 0;

    public bool IsDone { get; private set; } = false;

    public void Init()
    {
        _currentItemData = DataBaseManager.instance.AllItemData[Random.Range(0, DataBaseManager.instance.AllItemData.Length)];
        _amount = Random.Range(1, 5);

        trainCarImage.sprite = _currentItemData.ItemImage;

        int ownedCount = CheckMyItem(_currentItemData);

        trainCarCapacity.text = ownedCount + "/" + _amount;
    }

    public void OnClickTrainCar()
    {
        // �ʿ䰳������ ���� �� ���� ������ �ִٸ�
        if(CheckMyItem(_currentItemData) >= _amount)
        {
            // ������ ���� ���ְ�
            DataBaseManager.instance.AddItem(_currentItemData, -_amount);
            trainCarImage.sprite = checkSprite;
        }
    }

    private int CheckMyItem(ItemData item)
    {
        if (DataBaseManager.instance.MyDataBase.itemDataBase.ContainsKey(_currentItemData))
            return DataBaseManager.instance.MyDataBase.itemDataBase[_currentItemData];
        return 0;
    }
}
