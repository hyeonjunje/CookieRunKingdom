using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseController : MonoBehaviour
{
    [Header("데이터")]
    [SerializeField] private CharacterData _data;

    // 컴포넌트
    protected CharacterAnimator _characterAnimator;
    protected CharacterBattleController _characterBattleController;

    public CharacterData Data => _data;
    public CharacterAnimator CharacterAnimator => _characterAnimator;
    public CharacterBattleController CharacterBattleController => _characterBattleController;

    protected virtual void Awake()
    {
        _characterAnimator = GetComponent<CharacterAnimator>();
        _characterBattleController = GetComponent<CharacterBattleController>();

        _characterAnimator.Init(this, _data);
        _characterBattleController.Init(this, _data);
    }
}
