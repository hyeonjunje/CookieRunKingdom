using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieBattleRunState : CookieBattleBaseState
{
    private Collider2D _col = null;

    public CookieBattleRunState(CookieBattleStateFactory factory, CookieController controller) : base(factory, controller)
    {
    }

    public override void Enter()
    {
        _col = null;
        _controller.CookieAnim.PlayAnimation(ECookieAnimation.BattleRun);
    }

    public override void Exit()
    {

    }

    public override void Update()
    {
        _controller.transform.position += new Vector3(7.72f, 3.68f, 0f).normalized * Time.deltaTime * _controller.Data.MoveSpeed;

        // 목표물 세팅
        if (_col == null)
            _col = Physics2D.OverlapCircle(_controller.transform.position, _controller.Data.DetectRange, 1 << LayerMask.NameToLayer("Enemy"));

        // 목표물이 있으면 이동 후 공격범위까지 가면 공격
        if(_col != null)
        {
            _col = Physics2D.OverlapCircle(_controller.transform.position, _controller.Data.AttackRange, 1 << LayerMask.NameToLayer("Enemy"));
            if(_col != null)
            {
                _factory.CookieBattleAttack.SetTarget(_col);
                _factory.ChangeState(ECookieBattleState.CookieBattleAttackState);
            }
        }
    }
}
