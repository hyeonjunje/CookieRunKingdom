using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Spine.Unity;
using Spine;
using UnityEngine.InputSystem;

public class TTTETTEETET : MonoBehaviour
{
    [SerializeField] private string[] s;
    [SerializeField] private string ss;
    public SkeletonAnimation animation;
    public int idx = 0;

    private void Start()
    {
        animation = GetComponent<SkeletonAnimation>();

        animation.Initialize(true);

        /*animation.AnimationState.End += (entry) =>
        {
            idx++;
            if(idx >= s.Length)
            {
                idx = 0;
            }
            animation.AnimationState.SetAnimation(0, s[idx], false);
        };*/
    }

    private float currentTime = 0;
    private bool isFl = false;

    private void Update()
    {
        /*currentTime += Time.deltaTime;
        if(currentTime >= 3 && !isFl)
        {
            isFl = true;
            animation.AnimationState.SetAnimation(0, ss, true);
        }*/
    }

    public void OnClick(InputAction.CallbackContext value)
    {
        if(value.started)
        {
            animation.AnimationState.SetAnimation(0, s[idx++], false);
            Debug.Log(animation.AnimationState.GetCurrent(0).AnimationTime);
            Debug.Log(animation.AnimationState.GetCurrent(0).AnimationLast);
            Debug.Log(animation.AnimationState.GetCurrent(0).AnimationEnd - animation.AnimationState.GetCurrent(0).AnimationStart);
        }
    }
}
