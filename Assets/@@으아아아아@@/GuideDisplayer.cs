using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using DG.Tweening;

public class GuideDisplayer : MonoBehaviour
{
    private static GuideDisplayer instance = null;
    public static GuideDisplayer Instance
    {
        get
        {
            if (instance == null)
            {
                instance = FindObjectOfType<GuideDisplayer>();
                if (instance == null)
                {
                    GameObject go = new GameObject();
                    go.name = "SingletonController";
                    instance = go.AddComponent<GuideDisplayer>();

                    instance.Init();
                }
            }
            return instance;
        }
    }

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
            Init();
        }
        else
        {
            Destroy(gameObject);
        }
    }


    private Queue<TextMeshProUGUI> _textPool;

    private void Init()
    {
        for(int i = 0; i < 15; i++)
        {
            TextMeshProUGUI text = new GameObject("Text").AddComponent<TextMeshProUGUI>();
            _textPool.Enqueue(text);
            text.gameObject.SetActive(false);
        }
    }


    public void ShowGuide(string content)
    {

    }
}
