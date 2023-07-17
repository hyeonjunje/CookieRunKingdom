using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cysharp.Threading.Tasks;

public class GameManager : Singleton<GameManager>
{
    private SQLManager _sql = new SQLManager();

    private FileManager _file = new FileManager();
    private SceneManagerEx _scene = new SceneManagerEx();
    private UIManager _ui = new UIManager();
    private GameManagerEx _game = new GameManagerEx();

    public static SQLManager SQL => Instance._sql;
    public static FileManager File => Instance._file;
    public static SceneManagerEx Scene => Instance._scene;
    public static UIManager UI => Instance._ui;
    public static GameManagerEx Game => Instance._game;

    private bool _isLoad = false;

    public bool _isDone = false;

    public async UniTask LoadData()
    {
        if(!_isLoad)
        {
            _isLoad = true;

            await UniTask.SwitchToThreadPool();
            _sql.Init().Forget();
            await UniTask.SwitchToMainThread();

            while (true)
            {
                await UniTask.Yield();
                if (_isDone)
                    break;
            }
            _file.Init();
            _scene.Init();
            _ui.Init();
            _game.Init();
        }
    }

    // 데이터 싹다 가져와야 해
    // 데이터베이스에서 말야
    // 그 오프닝 씬에서 해야겠네


    protected override void OnApplicationQuit()
    {
        Debug.Log("꺼지고 저장합니다.");

        Game.SaveData();
        SQL.SaveDataBase();

        base.OnApplicationQuit();
    }
}
