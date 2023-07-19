using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class AirborneCommand : ICCCommand
{
    private readonly CharacterBattleController _receiver;

    public AirborneCommand(CharacterBattleController receiver)
    {
        _receiver = receiver;
    }

    public bool IsFinish { get; set; }

    private Sequence _seq;
    private Vector3 _originPos;

    public void Execute(Vector3 dir)
    {
        IsFinish = false;

        _originPos = _receiver.transform.position;
        Vector3 endVector = _receiver.transform.position + dir;

        _seq = DOTween.Sequence();
        _seq.Append(_receiver.transform.DOMove(endVector, 0.5f)).SetEase(Ease.OutCubic)
            .Append(_receiver.transform.DOMove(_originPos, 0.5f)).SetEase(Ease.InCubic)
            .OnComplete(Undo);
    }

    public void Undo()
    {
        _receiver.transform.position = _originPos;
        IsFinish = true;
        _seq.Kill();
    }
}
