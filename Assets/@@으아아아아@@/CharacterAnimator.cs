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

    // ��Ű���� �ִϸ��̼� �̸��� �ٸ� ��찡 �ֽ��ϴ�.
    // �̸� �ϳ��ϳ� �� ���⿡�� �ʹ� �δ��Դϴ�.
    // �׷��� �ش� �̸��� �ִ��� Ȯ���ϰ�
    // ������ �������մϴ�.
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
            Debug.LogError(name + " �� " + _animationNames[(int)cookieAnimation] + " �ִϸ��̼� �����ϴ�.");
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
            Debug.Log(name+ " �� ����!");
        }
    }

    private string GetAnimationName(ECookieAnimation cookieAnimation)
    {
        return _animationNames[(int)cookieAnimation];
    }
}
