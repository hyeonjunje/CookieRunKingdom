using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomTrainStationUI : BaseUI
{
    [SerializeField] private Train[] trains;


    public override void Show()
    {
        base.Show();

        foreach(Train train in trains)
            train.Init();
    }
}
