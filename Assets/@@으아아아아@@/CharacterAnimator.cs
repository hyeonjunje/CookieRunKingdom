using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Spine.Unity;
using Spine;

public class CharacterAnimator : MonoBehaviour
{
    private BaseController _characterController;
    private CharacterData _characterData;

    private SkeletonAnimation _animation;
    private Renderer _renderer;

    private string[] _animationNames;

    public void Init(BaseController baseController, CharacterData characterData)
    {
        _characterController = baseController;
        _characterData = characterData;

        _animation = GetComponentInChildren<SkeletonAnimation>();
        _renderer = _animation.GetComponent<Renderer>();

        _animationNames = characterData.AnimationData.Init();

        _animation.Initialize(false);
        _animation.AnimationState.Event += OnSpineEvent;

        // AdjustmentAnimationName();
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

    public void AdjustmentAnimationName(bool isForward)
    {
        if(!isForward)
        {
            for(int i = 0; i < _animationNames.Length; i++)
            {
                if(_animationNames[i].Contains("_back"))
                {
                    _animationNames[i] = _animationNames[i].Replace("_back", "");
                }

                else if(_animationNames[i].Contains("back"))
                {
                    _animationNames[i] = _animationNames[i].Replace("back", "");
                }
            }
        }
    }

    public void PlayAnimation(ECookieAnimation cookieAnimation)
    {
        try
        {
            _animation.Initialize(false);
            _animation.AnimationState.SetAnimation(0, _animationNames[(int)cookieAnimation], true);
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            Debug.LogError(name + " 에 " + _animationNames[(int)cookieAnimation] + " 애니메이션 없습니다.");
        }
    }

    public void SettingOrder(int order)
    {
        _renderer.sortingOrder = order;
    }

    private void OnSpineEvent(TrackEntry trackEntry, Spine.Event e)
    {
        Debug.Log(name + " " + e.Data.Name + "  " + GetAnimationName(ECookieAnimation.BattleAttack));
        if(e.Data.Name == GetAnimationName(ECookieAnimation.BattleAttack))
        {
            Debug.Log(name+ " 이 공격!");
        }
    }

    private string GetAnimationName(ECookieAnimation cookieAnimation)
    {
        return _animationNames[(int)cookieAnimation];
    }
}
