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
    protected BaseSkill _baseSkill;

    public CharacterData Data => _data;
    public CharacterAnimator CharacterAnimator => _characterAnimator;
    public CharacterBattleController CharacterBattleController => _characterBattleController;
    public BaseSkill BaseSkill => _baseSkill;

    protected virtual void Awake()
    {
        _characterAnimator = GetComponent<CharacterAnimator>();
        _characterBattleController = GetComponent<CharacterBattleController>();
        _baseSkill = GetComponent<BaseSkill>();

        _characterAnimator.Init(this, _data);
        _characterBattleController.Init(this, _data);
        _baseSkill.Init(this);
    }

    private void Update()
    {
        float zPos = (transform.position.x + transform.position.y) / 100000f;
        transform.position = new Vector3(transform.position.x, transform.position.y, zPos);
    }
}
