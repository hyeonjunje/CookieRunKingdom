using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIManager
{
    public void Init()
    {

    }

    private Stack<BaseUI> uiStack = new Stack<BaseUI>();

    public void ShowPopUpUI(BaseUI ui)
    {
        uiStack.Push(ui);
        uiStack.Peek().gameObject.SetActive(true);
        uiStack.Peek().Show();
    }

    public void ExitPopUpUI()
    {
        if (uiStack.Count != 0)
        {
            uiStack.Peek().Hide();
            uiStack.Pop();
        }
    }

    public void PushUI(BaseUI ui)
    {
        if (uiStack.Count != 0)
            uiStack.Peek().Hide();

        uiStack.Push(ui);
        uiStack.Peek().gameObject.SetActive(true);
        uiStack.Peek().Show();
    }

    public void PopUI()
    {
        if(uiStack.Count == 0)
        {
            Debug.LogError("���̻� UI�� �����ϴ�.");
            return;
        }

        uiStack.Peek().Hide();
        uiStack.Pop();

        if(uiStack.Count != 0)
        {
            uiStack.Peek().gameObject.SetActive(true);
            uiStack.Peek().Show();
        }
    }

    public void ClearUI()
    {
        while(uiStack.Count != 0)
        {
            uiStack.Peek().Hide();
            uiStack.Pop();
        }
    }
}
