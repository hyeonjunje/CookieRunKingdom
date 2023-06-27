using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Train : MonoBehaviour
{
    public System.Action OnLeaveEvent = null;
    public System.Action OnArriveEvent = null;

    [SerializeField] private TrainCar[] trainCars;
    [SerializeField] private GameObject deliveryAtOnceObject;

    private Vector3 initPos = Vector3.zero;
    private Sequence leaveSeq;
    private Sequence arriveSeq;
    private Sequence fillSeq;


    private void Awake()
    {
        initPos = transform.position;

        leaveSeq = DOTween.Sequence();
        leaveSeq.Pause().SetAutoKill(false).AppendCallback(() =>
        {
            deliveryAtOnceObject.SetActive(false);
        })
            .Append(transform.DOMoveX(transform.position.x + 600f, 2f))
            .AppendCallback(() =>
            {
                OnLeaveEvent?.Invoke();
            });

        arriveSeq = DOTween.Sequence();
        arriveSeq.Pause().SetAutoKill(false).AppendCallback(() =>
        {
            deliveryAtOnceObject.SetActive(false);
            OnArriveEvent?.Invoke();
        })
            .Append(transform.DOMove(initPos, 2f));


        fillSeq = DOTween.Sequence();
        fillSeq.Pause().SetAutoKill(false).Append(transform.DOMoveX(transform.position.x + 600f, 2f))
            .AppendCallback(() =>
            {
                foreach (TrainCar trainCar in trainCars)
                {
                    deliveryAtOnceObject.SetActive(true);
                    OnArriveEvent?.Invoke();
                    trainCar.SetFillInItem();
                }
            })
            .AppendCallback(() => transform.position -= Vector3.right * 1200f)
            .Append(transform.DOMove(initPos, 2f));
    }

    public void Init()
    {
        foreach(TrainCar trainCar in trainCars)
        {
            trainCar.Init(this);
        }
    }

    // ��ư�� �Ҵ�
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
        // dotween���� ���� ��� ���ϰ� �ð� ��Ÿ���� UI ����
        if (CheckTrainCar(ETrainState.Done))
        {
            leaveSeq.Restart();
        }

        else if(CheckTrainCar(ETrainState.Empty))
        {
            fillSeq.Restart();
        }
    }

    public void ArriveTrain()
    {
        transform.position -= Vector3.right * 1200f;

        foreach (TrainCar trainCar in trainCars)
        {
            trainCar.SetFillInReward();
        }

        arriveSeq.Restart();
    }


    /// <summary>
    /// ��� ���ڰ� üũ�Ǹ� true, �ƴϸ� false
    /// </summary>
    /// <returns></returns>
    private bool CheckTrainCar(ETrainState state)
    {
        foreach(TrainCar trainCar in trainCars)
            if (trainCar.state != state)
                return false;
        return true;
    }
}
