using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Train : MonoBehaviour
{
    [SerializeField] private TrainCar[] trainCars;
    
    public void Init()
    {
        foreach(TrainCar trainCar in trainCars)
        {
            trainCar.Init();
        }
    }

    public void DeliveryAtOnce()
    {
        foreach(TrainCar trainCar in trainCars)
        {
            trainCar.OnClickTrainCar();
        }
    }
}
