using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterBattleController : MonoBehaviour
{
    public CharacterBattleController[] target = null;

    private BaseController _baseController;
    private CharacterData _characterData;
    private BattleStateFactory _factory;
    private Coroutine _coUpdate = null;

    public bool IsForward { get; private set; }

    public void Init(BaseController baseController, CharacterData characterData)
    {
        _baseController = baseController;
        _characterData = characterData;
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

    private IEnumerator CoUpdate()
    {
        while (true)
        {
            yield return null;
            _factory.CurrentState.Update();
        }
    }
}
