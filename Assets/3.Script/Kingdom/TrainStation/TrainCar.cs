using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

/// <summary>
/// Waiting 상태는 물건 받는거 대기하는거
/// Done은 물건 제출해서 체크표시 되있는거
/// Reward는 보상 싣고 대기하고 있는거
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
            // 필요개수보다 내가 더 많이 가지고 있다면
            if (CheckMyItem(_necessaryItemData) >= _necessaryItemAmount)
            {
                state = ETrainState.Done;

                // 아이템 개수 빼주고
                DataBaseManager.instance.AddItem(_necessaryItemData, -_necessaryItemAmount);
                trainCarImage.sprite = checkSprite;
                trainCarCapacity.text = "";

                _train.TrySendTrain();
            }
        }
        else if(state == ETrainState.Reward)
        {
            state = ETrainState.Empty;

            // 아이템 획득하고
            DataBaseManager.instance.AddItem(_rewardItemData, _rewardItemAmount);
            trainCarImage.sprite = null;

            _train.TrySendTrain();
        }
    }

    // 보상으로 채워줌
    public void SetFillInReward()
    {
        state = ETrainState.Reward;

        _necessaryItemData = null;
        _rewardItemData = DataBaseManager.instance.AllItemData[Random.Range(0, DataBaseManager.instance.AllItemData.Length)];
        _rewardItemAmount = Random.Range(1, 5);

        trainCarImage.sprite = _rewardItemData.ItemImage;
        trainCarCapacity.text = _rewardItemAmount.ToString();
    }

    // 요구하는 아이템으로 채워줌
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
