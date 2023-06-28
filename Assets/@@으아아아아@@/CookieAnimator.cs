using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Spine.Unity;
using Spine;

public enum ECookieAnimation
{
    BattleIdle,
    BattleRun,
    BattleAttack,
    Dead,
    Victory,
    Defeat,
}

public class CookieAnimator : MonoBehaviour
{
    private CookieController _cookieController;
    private CookieAnimationData _data;
    private bool _isTest;

    private SkeletonAnimation _animation;
    private Renderer _renderer;
    private ExposedList<Spine.Animation> _allAnimationNames;

    private string[] _animationNames;
    private int _idx = 0;


    public void Init(CookieController cookieController, CookieAnimationData data , bool isTest = false)
    {
        _cookieController = cookieController;
        _data = data;
        _isTest = isTest;

        _animation = GetComponentInChildren<SkeletonAnimation>();
        _renderer = _animation.GetComponent<Renderer>();

        _animationNames = _data.Init();

        GetAllNames();
        AdjustmentAnimationName();
    }
    private void GetAllNames()
    {
        SkeletonData skeletonData = _animation.Skeleton.Data;
        _allAnimationNames = skeletonData.Animations;
    }

    // 쿠키마다 애니메이션 이름이 다른 경우가 있습니다.
    // 이를 하나하나 다 적기에는 너무 부담입니다.
    // 그래서 해당 이름이 있는지 확인하고
    // 없으면 재조정합니다.
    private void AdjustmentAnimationName()
    {
        SkeletonData skeletonData = _animation.skeletonDataAsset.GetSkeletonData(true);
        for (int i = 0; i < _animationNames.Length; i++)
            if (skeletonData.FindAnimation(_animationNames[i]) == null)
                _animationNames[i] = _animationNames[i].Replace("_", "");
    }

    public void Act()
    {
        if (_isTest)
        {
            _animation.AnimationState.SetAnimation(0, _allAnimationNames.Items[_idx++].Name, true);

            if (_idx == _allAnimationNames.Count)
                _idx = 0;
        }
        else
        {
            try
            {
                _animation.AnimationState.SetAnimation(0, _animationNames[_idx++], true);

                if (_idx == _animationNames.Length)
                    _idx = 0;
            }
            catch (Exception e)
            {
                Debug.Log(name);
            }
        }
    }

    public void PlayAnimation(ECookieAnimation cookieAnimation)
    {
        try
        {
            _animation.AnimationState.SetAnimation(0, _animationNames[(int)cookieAnimation], true);
        }
        catch
        {
            Debug.LogError(name + " 에 " + _animationNames[(int)cookieAnimation] + " 애니메이션 없습니다.");
        }
    }

    public void SettingOrder(int order)
    {
        _renderer.sortingOrder = order;
    }
}
