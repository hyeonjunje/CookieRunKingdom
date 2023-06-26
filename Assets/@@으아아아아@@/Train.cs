using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Train : MonoBehaviour
{
    [SerializeField] private TrainCar[] trainCars;

    public void Init()
    {
        foreach(TrainCar trainCar in trainCars)
        {
            trainCar.Init(this);
        }
    }

    public void DeliveryAtOnce()
    {
        foreach(TrainCar trainCar in trainCars)
        {
            trainCar.OnClickTrainCar();
        }
    }

    /// <summary>
    /// ���� ���
    /// </summary>
    public void TrySendTrain()
    {
        if(CheckAllDelivery())
        {
            // dotween���� ���� ��� ���ϰ� �ð� ��Ÿ���� UI ����
        }
    }

    /// <summary>
    /// ��� ���ڰ� üũ�Ǹ� true, �ƴϸ� false
    /// </summary>
    /// <returns></returns>
    public bool CheckAllDelivery()
    {
        foreach(TrainCar trainCar in trainCars)
            if (!trainCar.IsDone)
                return false;
        return true;
    }
}
