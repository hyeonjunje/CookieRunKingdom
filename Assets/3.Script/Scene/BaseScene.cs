using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class BaseScene : MonoBehaviour
{
    // init�� ������ �ε�â
    private void Awake()
    {
        GameManager.Instance.Init();
        Init();
    }

    protected abstract void Init();
}
