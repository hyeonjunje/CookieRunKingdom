using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : Singleton<GameManager>
{
    private FileManager _file = new FileManager();
    private SceneManagerEx _scene = new SceneManagerEx();
    private UIManager _ui = new UIManager();
    private GameManagerEx _game = new GameManagerEx();

    public static FileManager File => Instance._file;
    public static SceneManagerEx Scene => Instance._scene;
    public static UIManager UI => Instance._ui;
    public static GameManagerEx Game => Instance._game;

    private bool _isInit = false;

    public void Init()
    {
        if (!_isInit)
        {
            _isInit = true;

            _file.Init();
            _scene.Init();
            _ui.Init();
            _game.Init();
        }
    }

    // ������ �ϴ� �����;� ��
    // �����ͺ��̽����� ����
    // �� ������ ������ �ؾ߰ڳ�


    protected override void OnApplicationQuit()
    {
        Debug.Log("������ �����մϴ�.");
        Game.SetSaveData();

        base.OnApplicationQuit();
    }
}
