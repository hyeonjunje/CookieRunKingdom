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
    /// 기차 출발
    /// </summary>
    public void TrySendTrain()
    {
        if(CheckAllDelivery())
        {
            // dotween으로 열차 출발 다하고 시간 나타내는 UI 생성
        }
    }

    /// <summary>
    /// 모든 물자가 체크되면 true, 아니면 false
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
