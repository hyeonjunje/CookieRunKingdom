using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;
using UnityEngine.InputSystem;

public class TitleScene : BaseScene
{
    [SerializeField] private SkeletonAnimation _titleAnimation;
    [SerializeField] private SkeletonAnimation _titleLogoAnimation;
    [SerializeField] private TitleSceneUI _titleSceneUI;

    protected override void Init()
    {
        StartCoroutine(CoTitle());
    }


    private IEnumerator CoTitle()
    {
        _titleAnimation.AnimationState.SetAnimation(0, "start", false);

        yield return new WaitUntil(() => _titleAnimation.AnimationState.GetCurrent(0).IsComplete);

        _titleLogoAnimation.gameObject.SetActive(true);
        _titleAnimation.AnimationState.SetAnimation(0, "idle", true);
        _titleLogoAnimation.AnimationState.SetAnimation(0, "ko", false);

        yield return new WaitUntil(() => _titleLogoAnimation.AnimationState.GetCurrent(0).IsComplete);

        GameManager.UI.PushUI(_titleSceneUI);
    }
}
