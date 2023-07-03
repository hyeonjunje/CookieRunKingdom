using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseProjectile : MonoBehaviour
{
    [SerializeField] protected bool _isPersistence = false;  // 지속성이 있나?
    [SerializeField] protected bool _isTargetDir = false;    // 타겟을 향해 날아가나?
    [SerializeField] protected float moveSpeed;
    [SerializeField] protected float _duration;

    protected float _currentTime = 0f;
    protected Vector3 _dir;
    protected Vector3 _initPos = Vector3.up * 0.8f;
    protected Transform _parent = null;
    protected Rigidbody2D _rigid;
    protected DamageBox _damageBox;

    private BaseRangeSkill _pool = null;

    /// <summary>
    /// 투사체의 정보를 초기화한다.
    /// </summary>
    /// <param name="damage">투사체의 데미지</param>
    /// <param name="targetLayer">투사체의 타겟 레이어</param>
    /// <param name="parent">해당 투사체의 부모</param>
    /// <param name="initPos">해당 투사체가 등장할 위치</param>
    public virtual void Init(int damage, LayerMask targetLayer, Transform parent, Vector3 initPos)
    {
        _rigid = GetComponent<Rigidbody2D>();
        _damageBox = GetComponent<DamageBox>();
        _parent = parent;
        _initPos = initPos;

        if(_damageBox != null)
            _damageBox.Init(damage, targetLayer, _isPersistence);
    }

    public void SetPool(BaseRangeSkill pool)
    {
        _pool = pool;
    }

    public void ShootProjectile(Vector3 dir)
    {
        _dir = dir;
    }

    private void OnDisable()
    {
        if(_pool != null)
            _pool.ReturnProjectile(this);
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
