using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(DamageBox))]
public class BaseProjectile : MonoBehaviour
{
    public System.Action<BaseProjectile> OnDisableEvent = null;

    [SerializeField] protected bool isRotate = true;
    [SerializeField] protected bool _isPersistence = false;  // ���Ӽ��� �ֳ�?
    [SerializeField] protected bool _isTargetDir = false;    // Ÿ���� ���� ���ư���?
    [SerializeField] protected float moveSpeed;
    [SerializeField] protected float _duration;

    protected float _currentTime = 0f;
    protected Vector3 _dir;
    protected Vector3 _initPos = Vector3.up * 0.8f;
    protected Transform _parent = null;
    protected Rigidbody2D _rigid;
    protected DamageBox _damageBox;

    /// <summary>
    /// ����ü�� ������ �ʱ�ȭ�Ѵ�.
    /// </summary>
    /// <param name="damage">����ü�� ������</param>
    /// <param name="targetLayer">����ü�� Ÿ�� ���̾�</param>
    /// <param name="parent">�ش� ����ü�� �θ�</param>
    /// <param name="initPos">�ش� ����ü�� ������ ��ġ</param>
    public virtual void Init(int damage, LayerMask targetLayer, Transform parent, Vector3 initPos)
    {
        _rigid = GetComponent<Rigidbody2D>();
        _damageBox = GetComponent<DamageBox>();
        _parent = parent;
        _initPos = initPos;

        if(_damageBox != null)
            _damageBox.Init(damage, targetLayer, _isPersistence);
    }

    public void ShootProjectile(Vector3 dir)
    {
        _dir = dir;

        if(isRotate)
        {
            transform.eulerAngles = Vector3.forward * (Mathf.Atan2(_dir.y, _dir.x) * Mathf.Rad2Deg - 90);
        }
    }

    private void OnDisable()
    {
        OnDisableEvent?.Invoke(this);
    }

    protected virtual void OnEnable()
    {
        transform.SetParent(_parent);
        _currentTime = 0;

        transform.localPosition = _initPos;
        transform.SetParent(null);

        _rigid.velocity = _dir * moveSpeed;
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
