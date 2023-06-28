using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ECookieBattleState
{
    CookieBattleIdleState,
    CookieBattleRunState,
    CookieBattleAttackState,
    CookieBattleDeadState,
}

public class CookieBattleStateFactory
{
    private CookieController _controller;
    private Dictionary<ECookieBattleState, CookieBattleBaseState> _dictionary = new Dictionary<ECookieBattleState, CookieBattleBaseState>();
    private  CookieBattleBaseState _currentState = null;

    public CookieBattleBaseState CurrentState => _currentState;

    public CookieBattleIdleState CookieBattleIdle { get; private set; }
    public CookieBattleRunState CookieBattleRun { get; private set; }
    public CookieBattleAttackState CookieBattleAttack { get; private set; }
    public CookieBattleDeadState CookieBattleDead { get; private set; }

    public CookieBattleStateFactory(CookieController controller)
    {
        _controller = controller;
        Init();
    }

    private void Init()
    {
        CookieBattleIdle = new CookieBattleIdleState(this, _controller);
        CookieBattleRun = new CookieBattleRunState(this, _controller);
        CookieBattleAttack = new CookieBattleAttackState(this, _controller);
        CookieBattleDead = new CookieBattleDeadState(this, _controller);

        _dictionary[ECookieBattleState.CookieBattleIdleState] = CookieBattleIdle;
        _dictionary[ECookieBattleState.CookieBattleRunState] = CookieBattleRun;
        _dictionary[ECookieBattleState.CookieBattleAttackState] = CookieBattleAttack;
        _dictionary[ECookieBattleState.CookieBattleDeadState] = CookieBattleDead;

        ChangeState(ECookieBattleState.CookieBattleIdleState);
    }

    public void ChangeState(ECookieBattleState state)
    {
        if(_currentState != null)
        {
            _currentState.Exit();
        }

        _currentState = _dictionary[state];

        _currentState.Enter();
    }
}
