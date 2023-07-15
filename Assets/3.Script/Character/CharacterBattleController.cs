using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CharacterBattleController : MonoBehaviour
{
    public System.Action OnDeadEvent = null;
    public System.Action OnHitEvent = null;

    private Slider _hpBar = null;
    private bool _isDead = false;
    public bool IsDead => _isDead;

    public int MaxHp => _controller.CharacterStat.hpStat.ResultStat;

    private int _currentHp;
    public int CurrentHp
    {
        get { return _currentHp; }
        set
        {
            _currentHp = value;

            _currentHp = Mathf.Clamp(_currentHp, 0, MaxHp);

            UpdateHpbar();
            OnHitEvent?.Invoke();

            if (_currentHp <= 0)
                if(!_isDead)
                    Dead();
        }
    }

    // 쿠키들 원래 위치 (전투중이 아닐 때는 이 위치를 고수해야 함)
    public CookieBundle CookieBundle { get; private set; }
    public Transform OffsetPosition { get; private set; }
    public LayerMask myLayer { get; private set; }
    public LayerMask enemyLayer { get; private set; }

    protected BaseController _controller;
    protected BattleStateFactory _factory;
    private Coroutine _coUpdate = null;

    public bool IsForward { get; private set; }

    private void OnDisable()
    {
        StopAllCoroutines();
    }

    public void Init(BaseController controller)
    {
        _isDead = false;

        _controller = controller;
        CurrentHp = MaxHp;
    }

    public void SetEnemy(LayerMask layer)
    {
        if(layer == LayerMask.NameToLayer("Enemy"))
        {
            myLayer = LayerMask.NameToLayer("Cookie");
            enemyLayer = LayerMask.NameToLayer("Enemy");
        }
        else if(layer == LayerMask.NameToLayer("Cookie"))
        {
            myLayer = LayerMask.NameToLayer("Enemy");
            enemyLayer = LayerMask.NameToLayer("Cookie");
        }

        _controller.BaseSkill.SetLayer(layer);
    }

    public void SetPosition(CookieBundle cookieBundle, Transform pos)
    {
        CookieBundle = cookieBundle;
        OffsetPosition = pos;
    }

    /// <summary>
    /// 전투 시작시 실행하는 메소드
    /// </summary>
    /// <param name="isForward">앞을 향하고 있나</param>
    public void StartBattle(bool isForward = true)
    {
        IsForward = isForward;
        _controller.CharacterAnimator.AdjustmentAnimationName(isForward);

        _factory = new BattleStateFactory(_controller);

        if (_coUpdate != null)
            StopCoroutine(_coUpdate);
        _coUpdate = StartCoroutine(CoUpdate());
    }

    public void ChangeState(EBattleState state)
    {
        _factory.ChangeState(state);
    }

    private void UpdateHpbar()
    {
        if (_hpBar == null && _currentHp < MaxHp)
        {
            _hpBar = FindObjectOfType<HpBarController>().GetHpBar(IsForward);
        }
        else if (_hpBar != null && _currentHp == MaxHp)
        {
            _hpBar.gameObject.SetActive(false);
            _hpBar = null;
        }

        if (_hpBar != null)
            _hpBar.value = (float)_currentHp / MaxHp;
    }

    private IEnumerator CoUpdate()
    {
        while (true)
        {
            yield return null;

            _factory.CurrentState.Update();

            float zPos = (transform.position.x + transform.position.y) / 1000f;
            transform.position = new Vector3(transform.position.x, transform.position.y, zPos);

            if (_hpBar != null)
            {
                _hpBar.transform.position = Camera.main.WorldToScreenPoint(transform.position + Vector3.up * 2);
            }
        }
    }

    protected virtual void Dead()
    {
        OnDeadEvent?.Invoke();

        _factory.ChangeState(EBattleState.BattleDeadState);
        _hpBar.gameObject.SetActive(false);
        _hpBar = null;
        _isDead = true;
    }


    public virtual void Disappear()
    {

    }
}
