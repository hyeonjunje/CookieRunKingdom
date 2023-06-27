using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class KingdomTrainStationUI : BaseUI
{
    [SerializeField] private Train[] trains;
    [SerializeField] private GameObject[] trainWoodBoard;
    [SerializeField] private Button[] trainSpeedUpButton;

    private bool isInit = false;

    public override void Show()
    {
        base.Show();

        if(!isInit)
        {
            isInit = true;

            for (int i = 0; i < trains.Length; i++)
            {
                trains[i].Init();

                int index = i;

                trains[i].OnLeaveEvent = () => trainWoodBoard[index].SetActive(true);
                trains[i].OnArriveEvent = () => trainWoodBoard[index].SetActive(false);

                trainSpeedUpButton[i].onClick.AddListener(() => trains[index].ArriveTrain());
            }
        }
    }
}
