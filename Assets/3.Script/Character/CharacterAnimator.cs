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
    private BaseSkill _baseSkill;

    private string[] _animationNames;
    public string[] attackEvent;

    public void Init(BaseController baseController, CharacterData characterData)
    {
        _characterController = baseController;
        _characterData = characterData;

        _animation = GetComponentInChildren<SkeletonAnimation>();
        _renderer = _animation.GetComponent<Renderer>();
        _baseSkill = baseController.BaseSkill;

        _animationNames = characterData.AnimationData.Init();

        _animation.Initialize(false);
        _animation.AnimationState.Event += OnSpineEvent;
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
            _animation.Initialize(false);
            _animation.AnimationState.SetAnimation(0, _animationNames[(int)animationName], true);
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            Debug.LogError(name + " 에 " + _animationNames[(int)animationName] + " 애니메이션 없습니다.");
        }
    }

    public void PlayAnimation(string animationName)
    {
        try
        {
            _animation.Initialize(false);
            _animation.AnimationState.SetAnimation(0, animationName, true);
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            Debug.LogError(name + " 에 " + animationName + " 애니메이션 없습니다.");
        }
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
        // 기본공격
        for(int i = 0; i < _baseSkill.attackEvent.Length; i++)
        {
            if(e.Data.Name == _baseSkill.attackEvent[i])
            {
                _baseSkill.NormalAttack();
                return;
            }
        }

        // 스킬 공격
        for(int i = 0; i < _baseSkill.skillEvent.Length; i++)
        {
            if (e.Data.Name == _baseSkill.skillEvent[i])
            {
                _baseSkill.OnSkillEvent(i);
                return;
            }
        }
    }

    private string GetAnimationName(ECookieAnimation cookieAnimation)
    {
        return _animationNames[(int)cookieAnimation];
    }
}
