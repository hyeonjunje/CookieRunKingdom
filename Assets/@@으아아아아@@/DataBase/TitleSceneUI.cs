using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using TMPro;

public class TitleSceneUI : BaseUI
{
    [SerializeField] private LoginUI _loginUI;
    [SerializeField] private CreateNameUI _createNameUI;

    [SerializeField] private TextMeshProUGUI _touchToStartText;
    [SerializeField] private Button _cinematicPlayButton;
    [SerializeField] private Button _screenButton;

    public override void Hide()
    {
        base.Hide();
    }

    public override void Init()
    {
        base.Init();

        _touchToStartText.gameObject.SetActive(false);
        _cinematicPlayButton.gameObject.SetActive(false);
        _screenButton.gameObject.SetActive(false);

        _loginUI.onSuccessLogin += OnAfterLoginEvent;
        _createNameUI.onAfterUI += ReadyToStartGame;
        _screenButton.onClick.AddListener(() => StartGame());
    }

    public override void Show()
    {
        base.Show();
        GameManager.UI.ShowPopUpUI(_loginUI);
    }

    private void OnAfterLoginEvent()
    {
        GameManager.Game.LoadData();
        DataBaseManager.Instance.LoadData();

        if (GameManager.Game.IsFirst)
        {
            GameManager.Game.IsFirst = false;
            GameManager.UI.ShowPopUpUI(_createNameUI);
        }
        else
        {
            ReadyToStartGame();
        }
    }

    private void ReadyToStartGame()
    {
        _touchToStartText.gameObject.SetActive(true);
        _cinematicPlayButton.gameObject.SetActive(true);
        _screenButton.gameObject.SetActive(true);
        _touchToStartText.DOColor(new Color(0.3f, 0.3f, 0.3f), 1).SetLoops(-1, LoopType.Yoyo);
    }

    private void StartGame()
    {
        Debug.Log("넘어가자!");
        GameManager.Scene.LoadScene(ESceneName.Kingdom);
    }
}
