using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : Singleton<GameManager>
{
    private SceneManagerEx _scene = new SceneManagerEx();
    private UIManager _ui = new UIManager();
    private GameManagerEx _game = new GameManagerEx();
    public static SceneManagerEx Scene => Instance._scene;
    public static UIManager UI => Instance._ui;
    public static GameManagerEx Game => Instance._game;

    private bool _isInit = false;

    public void Init()
    {
        if (!_isInit)
        {
            _isInit = true;

            _scene.Init();
            _ui.Init();
            _game.Init();
        }
    }

    // 데이터 싹다 가져와야 해
    // 데이터베이스에서 말야
    // 그 오프닝 씬에서 해야겠네
}
