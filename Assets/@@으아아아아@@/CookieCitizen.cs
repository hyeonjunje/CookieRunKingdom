using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PathFindingAgent))]
public class CookieCitizen : MonoBehaviour
{
    private CookieController _controller;
    private PathFindingAgent _agent;

    public void Init(CookieController controller)
    {
        _controller = controller;
        _agent = GetComponent<PathFindingAgent>();

        _agent.Init();

        Invoke("WalkInKingdom", 1f);
    }



    public void WalkInKingdom()
    {
        _agent.PathFinding(new Vector3(3, -10, 0));
    }

    public void WalkInAdventure()
    {

    }
}
