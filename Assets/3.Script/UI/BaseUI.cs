using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseUI : MonoBehaviour
{
    public virtual void Show()
    {

    }

    public virtual void Hide()
    {
        gameObject.SetActive(false);
    }
}
