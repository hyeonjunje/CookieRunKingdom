using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Spine.Unity;
using Spine;

public class CharacterAnimator : MonoBehaviour
{
    private BaseController _controller;

    private SkeletonAnimation _animation;
    private Renderer _renderer;
    private BaseSkill _baseSkill;

    private string[] _animationNames;

    public void Init(BaseController baseController)
    {
        _controller = baseController;

        _animation = GetComponentInChildren<SkeletonAnimation>();
        _renderer = _animation.GetComponent<Renderer>();
        _baseSkill = baseController.BaseSkill;

        _animationNames = _controller.Data.AnimationData.Init();

        _animation.Initialize(true);
        _animation.AnimationState.Event += OnSpineEvent;
    }

    /// <summary>
    /// �ִϸ��̼��� ��������� Ȯ���ϴ� �޼ҵ�
    /// </summary>
    /// <returns>������̶�� true, �ƴϸ� false</returns>
    public bool IsPlayingAnimation()
    {
        return !_animation.AnimationState.GetCurrent(0).IsComplete;
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

    public void PlayAnimation(ECookieAnimation animationName)
    {
        try
        {
            // ���� �̸��� ������ return;
            if (_animationNames[(int)animationName] == _animation.AnimationState.GetCurrent(0).Animation.Name)
                return;

            _animation.AnimationState.SetAnimation(0, _animationNames[(int)animationName], true);
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            Debug.LogError(name + " �� " + _animationNames[(int)animationName] + " �ִϸ��̼� �����ϴ�.");
        }
    }

    public void PlayAnimation(string animationName, bool isLoop = true)
    {
        try
        {
            // ���� �̸��� ������ return;
            if (animationName == _animation.AnimationState.GetCurrent(0).Animation.Name)
                return;

            _animation.AnimationState.SetAnimation(0, animationName, isLoop);
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            Debug.LogError(name + " �� " + animationName + " �ִϸ��̼� �����ϴ�.");
        }
    }

    public void FlipX(bool isFlip)
    {
        _animation.initialFlipX = isFlip;
    }

    public float GetIntervalAnimation()
    {
        return _animation.AnimationState.GetCurrent(0).AnimationEnd -
            _animation.AnimationState.GetCurrent(0).AnimationStart;
    }

    public void SettingOrder(int order)
    {
        _renderer.sortingOrder = order;
    }

    private void OnSpineEvent(TrackEntry trackEntry, Spine.Event e)
    {
        // �⺻����
        for(int i = 0; i < _baseSkill.attackEvent.Length; i++)
        {
            Debug.Log(name + e.Data.Name);
            if(e.Data.Name == _baseSkill.attackEvent[i])
            {
                _baseSkill.NormalAttackEvent();
                return;
            }
        }

        // ��ų ����
        for(int i = 0; i < _baseSkill.skillEvent.Length; i++)
        {
            Debug.Log(name + e.Data.Name);
            if (e.Data.Name == _baseSkill.skillEvent[i])
            {
                _baseSkill.OnSkillEvent(i);
                return;
            }
        }
    }

    public void SettingOrderLayer(bool isHighest)
    {
        if(isHighest)
        {
            _renderer.sortingLayerName = "UIUpper";

        }
        else
        {
            _renderer.sortingLayerName = "Default";
        }
    }
}
