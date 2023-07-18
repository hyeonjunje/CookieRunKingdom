using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class ProjectileCoffee : BaseProjectile
{
    [SerializeField] private float timePerAttack = 0.3f;

    [SerializeField] private Transform outterCircle;
    [SerializeField] private Transform innerCircle;
    [SerializeField] private Transform coffeebean;

    private Sequence seq;

    public override void Init(int damage, LayerMask targetLayer, Transform parent, Vector3 initPos, CharacterStat characterStat)
    {
        base.Init(damage, targetLayer, parent, initPos, characterStat);
    }

    private void OnDisable()
    {
        seq.Kill();
    }

    protected override void OnEnable()
    {
        base.OnEnable();

       /* _tween = transform.DORotate(new Vector3(0, 0, -360), _rotateSpeed, RotateMode.FastBeyond360)
                .SetLoops(-1, LoopType.Incremental)
                .SetEase(Ease.Linear);*/

        outterCircle.DORotate(new Vector3(0, 0, -360), _rotateSpeed, RotateMode.FastBeyond360)
            .SetLoops(-1, LoopType.Incremental)
            .SetEase(Ease.Linear);

        innerCircle.DORotate(new Vector3(0, 0, 360), _rotateSpeed / 2, RotateMode.FastBeyond360)
            .SetLoops(-1, LoopType.Incremental)
            .SetEase(Ease.Linear);

        coffeebean.DORotate(new Vector3(0, 0, 360), _rotateSpeed / 3, RotateMode.FastBeyond360)
            .SetLoops(-1, LoopType.Incremental)
            .SetEase(Ease.Linear);

        seq = DOTween.Sequence();
        seq.AppendInterval(timePerAttack)
           .AppendCallback(() => _damageBox.gameObject.SetActive(true))
           .AppendInterval(0.2f)
           .AppendCallback(() => _damageBox.gameObject.SetActive(false))
           .SetLoops(-1, LoopType.Incremental)
           .SetEase(Ease.Linear);
    }
}
