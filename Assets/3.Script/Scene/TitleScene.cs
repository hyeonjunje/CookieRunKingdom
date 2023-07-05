using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;
using Spine;
using UnityEngine.InputSystem;

public class TitleScene : BaseScene
{
    [SerializeField] private SkeletonAnimation _titleAnimation;
    [SerializeField] private SkeletonAnimation _titleLogoAnimation;

    private bool _isReadyToStart = false;

    protected override void Init()
    {
        _isReadyToStart = false;

        StartCoroutine(CoTitle());
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        if(value.started)
        {
            if(_isReadyToStart)
            {
                Debug.Log("넘어가자!");
                GameManager.Scene.LoadScene(ESceneName.Kingdom);
            }
        }
    }

    private IEnumerator CoTitle()
    {
        _titleAnimation.AnimationState.SetAnimation(0, "start", false);

        yield return new WaitUntil(() => _titleAnimation.AnimationState.GetCurrent(0).IsComplete);

        _titleLogoAnimation.gameObject.SetActive(true);
        _titleAnimation.AnimationState.SetAnimation(0, "idle", true);
        _titleLogoAnimation.AnimationState.SetAnimation(0, "ko", false);

        yield return new WaitUntil(() => _titleLogoAnimation.AnimationState.GetCurrent(0).IsComplete);

        _isReadyToStart = true;
    }
}
