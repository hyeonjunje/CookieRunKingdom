using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine;
using Spine.Unity;
using UnityEngine.InputSystem;

public class CookieController : MonoBehaviour
{
    private SkeletonAnimation _animation;

    [SerializeField] private CookieAnimationData data;

    [SpineAnimation]
    private ExposedList<Spine.Animation> animations;
    private int idx = 0;

    private void Awake()
    {
        _animation = GetComponent<SkeletonAnimation>();
        // GetAllNames();
    }

    private void GetAllNames()
    {
        SkeletonData skeletonData = _animation.Skeleton.Data;
        animations = skeletonData.Animations;
    }

    public void Act()
    {
        _animation.AnimationState.SetAnimation(0, animations.Items[idx++].Name, true);

        if (idx == animations.Count)
            idx = 0;
    }
}
