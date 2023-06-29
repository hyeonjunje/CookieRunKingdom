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

    [SerializeField] private SkeletonAnimation _animation;
    [SerializeField] private Renderer _renderer;

    private string[] _animationNames;

    public void Init(BaseController baseController, CharacterData characterData)
    {
        _characterController = baseController;
        _characterData = characterData;

        _animationNames = characterData.AnimationData.Init();

        AdjustmentAnimationName();
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
}
