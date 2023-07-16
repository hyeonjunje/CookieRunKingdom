using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

[RequireComponent(typeof(DamageBox))]
public class BaseProjectile : MonoBehaviour
{
    public System.Action<BaseProjectile> OnDisableEvent = null;

    [SerializeField] protected bool isSelfRotate = false;  // ������ ȸ���ϸ鼭 ���ư���?
    [SerializeField] protected bool isRotate = true;  // Ÿ���� ���ϳ�?
    [SerializeField] protected bool _isPersistence = false;  // ���Ӽ��� �ֳ�?
    [SerializeField] protected bool _isTargetDir = false;    // Ÿ���� ���� ���ư���?
    [SerializeField] protected float _rotateSpeed = 3f;
    [SerializeField] protected float _moveSpeed = 8f;
    [SerializeField] protected float _duration;

    protected float _currentTime = 0f;
    protected Vector3 _dir;
    protected Vector3 _initPos = Vector3.up * 0.8f;
    protected Transform _parent = null;
    protected Rigidbody2D _rigid;
    protected DamageBox _damageBox;

    private Tweener _tween;

    /// <summary>
    /// ����ü�� ������ �ʱ�ȭ�Ѵ�.
    /// </summary>
    /// <param name="damage">����ü�� ������</param>
    /// <param name="targetLayer">����ü�� Ÿ�� ���̾�</param>
    /// <param name="parent">�ش� ����ü�� �θ�</param>
    /// <param name="initPos">�ش� ����ü�� ������ ��ġ</param>
    public virtual void Init(int damage, LayerMask targetLayer, Transform parent, Vector3 initPos, CharacterStat characterStat)
    {
        _rigid = GetComponent<Rigidbody2D>();
        _damageBox = GetComponent<DamageBox>();
        _parent = parent;
        _initPos = initPos;

        if (_damageBox != null)
            _damageBox.Init(damage, targetLayer, characterStat, _isPersistence);
    }

    public void ShootProjectile(Vector3 dir)
    {
        _dir = dir;

        if(isSelfRotate)
        {
            _tween = transform.DORotate(new Vector3(0, 0, -360), _rotateSpeed, RotateMode.FastBeyond360)
                .SetLoops(-1, LoopType.Incremental)
                .SetEase(Ease.Linear);
        }

        if(isRotate)
        {
            transform.eulerAngles = Vector3.forward * (Mathf.Atan2(_dir.y, _dir.x) * Mathf.Rad2Deg - 90);
        }
    }

    private void OnDisable()
    {
        _tween.Pause();
        OnDisableEvent?.Invoke(this);
    }

    protected virtual void OnEnable()
    {
        transform.SetParent(_parent);
        _currentTime = 0;

        transform.localPosition = _initPos;
        transform.SetParent(null);

        _rigid.velocity = _dir * _moveSpeed;
    }

    private void Update()
    {
        _currentTime += Time.deltaTime;

        if (_currentTime >= _duration)
        {
            gameObject.SetActive(false);
        }
    }
}
