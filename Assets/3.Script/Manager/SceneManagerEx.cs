using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public enum ESceneName
{
    Title,
    Kingdom,
    Battle
}

public class SceneManagerEx
{
    // �� �̵��� ������ �Լ���
    public delegate void OnMoveOtherScene();
    public OnMoveOtherScene onMoveOtherScene;

    public ESceneName CurrentScene { get; private set; }

    public void Init()
    {
        CurrentScene = ESceneName.Title;
    }


    public void LoadScene(ESceneName sceneName)
    {
        onMoveOtherScene?.Invoke();
        SceneManager.LoadScene((int)sceneName);

        CurrentScene = sceneName;

        // �� �̵� �� UI�� ����
        GameManager.UI.ClearUI();
    }
}
