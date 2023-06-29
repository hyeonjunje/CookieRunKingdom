using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CharacterBattleController : MonoBehaviour
{
    private Slider _hpBar = null;

    public int maxHp = 10000;
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
            {
                _factory.ChangeState(EBattleState.BattleDeadState);
                _hpBar.gameObject.SetActive(false);
                _hpBar = null;
            }
        }
    }

    private BaseController _baseController;
    private CharacterData _characterData;
    private BattleStateFactory _factory;
    private DetectRange _detectRange;
    private Coroutine _coUpdate = null;

    public bool IsForward { get; private set; }

    public void Init(BaseController baseController, CharacterData characterData)
    {
        _baseController = baseController;
        _characterData = characterData;
        _detectRange = GetComponentInChildren<DetectRange>();
        CurrentHp = maxHp;
    }

    public void SetEnemy(LayerMask layer)
    {
        _detectRange.Init(layer);
    }

    /// <summary>
    /// 전투 시작시 실행하는 메소드
    /// </summary>
    /// <param name="isForward">앞을 향하고 있나</param>
    public void StartBattle(bool isForward = true)
    {
        IsForward = isForward;
        _baseController.CharacterAnimator.AdjustmentAnimationName(isForward);

        _factory = new BattleStateFactory(_baseController);

        if (_coUpdate != null)
            StopCoroutine(_coUpdate);
        _coUpdate = StartCoroutine(CoUpdate());
    }

    public void Attack()
    {
        if (_detectRange.enemies.Count != 0)
            _detectRange.enemies[0].CurrentHp -= 1000;
    }

    // 범위 내에 적이 있으면 true, 없으면 false
    public CharacterBattleController DetectEnemy()
    {
        if (_detectRange.enemies.Count != 0)
            return _detectRange.enemies[0];
        return null;
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
}
