using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : Singleton<GameManager>
{
    private SceneManagerEx _scene = new SceneManagerEx();
    private UIManager _ui = new UIManager();

    public static SceneManagerEx Scene => Instance._scene;
    public static UIManager UI => Instance._ui;

    private bool _isInit = false;

    public void Init()
    {

        if (!_isInit)
        {
            _isInit = true;

            _scene.Init();
            _ui.Init();
        }
    }
}
