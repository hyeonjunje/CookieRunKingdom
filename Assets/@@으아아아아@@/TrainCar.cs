using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

/// <summary>
/// Waiting ���´� ���� �޴°� ����ϴ°�
/// Done�� ���� �����ؼ� üũǥ�� ���ִ°�
/// Reward�� ���� �ư� ����ϰ� �ִ°�
/// </summary>
public enum ETrainState { Waiting, Done, Reward, Empty }

public class TrainCar : MonoBehaviour
{
    [SerializeField] private Sprite checkSprite;
    [SerializeField] private Image trainCarImage;
    [SerializeField] private TextMeshProUGUI trainCarCapacity;

    private Train _train;
    private ItemData _necessaryItemData = null;
    private ItemData _rewardItemData = null;
    private int _necessaryItemAmount = 0;
    private int _rewardItemAmount = 0;

    public ETrainState state = ETrainState.Waiting;

    public void Init(Train train)
    {
        _train = train;

        SetFillInItem();
    }

    public void OnClickTrainCar()
    {
        if(state == ETrainState.Waiting)
        {
            // �ʿ䰳������ ���� �� ���� ������ �ִٸ�
            if (CheckMyItem(_necessaryItemData) >= _necessaryItemAmount)
            {
                state = ETrainState.Done;

                // ������ ���� ���ְ�
                DataBaseManager.instance.AddItem(_necessaryItemData, -_necessaryItemAmount);
                trainCarImage.sprite = checkSprite;
                trainCarCapacity.text = "";

                _train.TrySendTrain();
            }
        }
        else if(state == ETrainState.Reward)
        {
            state = ETrainState.Empty;

            // ������ ȹ���ϰ�
            DataBaseManager.instance.AddItem(_rewardItemData, _rewardItemAmount);
            trainCarImage.sprite = null;

            _train.TrySendTrain();
        }
    }

    // �������� ä����
    public void SetFillInReward()
    {
        state = ETrainState.Reward;

        _necessaryItemData = null;
        _rewardItemData = DataBaseManager.instance.AllItemData[Random.Range(0, DataBaseManager.instance.AllItemData.Length)];
        _rewardItemAmount = Random.Range(1, 5);

        trainCarImage.sprite = _rewardItemData.ItemImage;
        trainCarCapacity.text = _rewardItemAmount.ToString();
    }

    // �䱸�ϴ� ���������� ä����
    public void SetFillInItem()
    {
        state = ETrainState.Waiting;

        _rewardItemData = null;
        _necessaryItemData = DataBaseManager.instance.AllItemData[Random.Range(0, DataBaseManager.instance.AllItemData.Length)];
        _necessaryItemAmount = Random.Range(1, 5);

        int ownedCount = CheckMyItem(_necessaryItemData);
        trainCarImage.sprite = _necessaryItemData.ItemImage;
        trainCarCapacity.text = ownedCount + "/" + _necessaryItemAmount;
    }

    private int CheckMyItem(ItemData item)
    {
        if (DataBaseManager.instance.MyDataBase.itemDataBase.ContainsKey(_necessaryItemData))
            return DataBaseManager.instance.MyDataBase.itemDataBase[_necessaryItemData];
        return 0;
    }
}
