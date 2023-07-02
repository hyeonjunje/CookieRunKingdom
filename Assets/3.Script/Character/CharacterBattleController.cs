using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CharacterBattleController : MonoBehaviour
{
    private Slider _hpBar = null;
    private bool _isDead = false;
    public bool IsDead => _isDead;

    [SerializeField] private int maxHp = 10000;
    public int MaxHp => maxHp;

    private int _currentHp;
    public int CurrentHp
    {
        get { return _currentHp; }
        set
        {
            _currentHp = value;

            _currentHp = Mathf.Clamp(_currentHp, 0, maxHp);

            UpdateHpbar();

            if (_currentHp <= 0)
                if(!_isDead)
                    Dead();
        }
    }

    // ��Ű�� ���� ��ġ (�������� �ƴ� ���� �� ��ġ�� ����ؾ� ��)
    public CookieBundle CookieBundle { get; private set; }
    public Transform OffsetPosition { get; private set; }
    public LayerMask myLayer { get; private set; }
    public LayerMask enemyLayer { get; private set; }

    protected BaseController _baseController;
    protected CharacterData _characterData;
    protected BattleStateFactory _factory;
    private Coroutine _coUpdate = null;

    public bool IsForward { get; private set; }

    public void Init(BaseController baseController, CharacterData characterData)
    {
        _isDead = false;

        _baseController = baseController;
        _characterData = characterData;
        CurrentHp = maxHp;
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

        _baseController.BaseSkill.SetLayer(layer);
    }

    public void SetPosition(CookieBundle cookieBundle, Transform pos)
    {
        CookieBundle = cookieBundle;
        OffsetPosition = pos;
    }

    /// <summary>
    /// ���� ���۽� �����ϴ� �޼ҵ�
    /// </summary>
    /// <param name="isForward">���� ���ϰ� �ֳ�</param>
    public void StartBattle(bool isForward = true)
    {
        IsForward = isForward;
        _baseController.CharacterAnimator.AdjustmentAnimationName(isForward);

        _factory = new BattleStateFactory(_baseController);

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
        if (_hpBar == null && _currentHp < maxHp)
        {
            _hpBar = FindObjectOfType<HpBarController>().GetHpBar(IsForward);
        }
        else if (_hpBar != null && _currentHp == maxHp)
        {
            _hpBar.gameObject.SetActive(false);
            _hpBar = null;
        }

        if (_hpBar != null)
            _hpBar.value = (float)_currentHp / maxHp;
    }

    private IEnumerator CoUpdate()
    {
        while (true)
        {
            yield return null;

            _factory.CurrentState.Update();

            if(_hpBar != null)
                _hpBar.transform.position = Camera.main.WorldToScreenPoint(transform.position + Vector3.up * 2);
        }
    }

    protected virtual void Dead()
    {
        _factory.ChangeState(EBattleState.BattleDeadState);
        _hpBar.gameObject.SetActive(false);
        _hpBar = null;
        _isDead = true;
    }

    public virtual void Disappear()
    {

    }
}
