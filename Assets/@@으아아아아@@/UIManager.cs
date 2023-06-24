using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIManager : MonoBehaviour
{
    public static UIManager instance = null;

    private void Awake()
    {
        if(instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(gameObject);
        }
    }

    private Stack<GameObject> uiStack = new Stack<GameObject>();

    public void PushUI(GameObject ui)
    {
        if (uiStack.Count != 0)
            uiStack.Peek().gameObject.SetActive(false);

        uiStack.Push(ui);
        uiStack.Peek().gameObject.SetActive(true);
    }

    public void PopUI()
    {
        if(uiStack.Count == 0)
        {
            Debug.LogError("더이상 UI가 없습니다.");
            return;
        }

        uiStack.Peek().SetActive(false);
        uiStack.Pop();

        if(uiStack.Count != 0)
        {
            uiStack.Peek().SetActive(true);
        }
    }

    public void ClearUI()
    {
        while(uiStack.Count != 0)
        {
            uiStack.Peek().SetActive(false);
            uiStack.Pop();
        }
    }
}
