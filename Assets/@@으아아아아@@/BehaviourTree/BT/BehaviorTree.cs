using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BehaviorTree : MonoBehaviour
{
    public enum ENodeStatus
    {
        Unknown,
        InProgress,
        Failed,
        Succeeded
    }

    protected BTNodeBase RootNode { get; private set; } = new BTNodeBase("ROOT");

    protected void ResetRootNode()
    {
        RootNode.Reset();
    }

    protected void Tick()
    {
        RootNode.Tick(Time.deltaTime);
    }

    public string GetDebugText()
    {
        return RootNode.GetDebugText();
    }

}
