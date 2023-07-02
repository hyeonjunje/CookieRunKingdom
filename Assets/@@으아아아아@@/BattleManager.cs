using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleManager : MonoBehaviour
{
    // 나중에 싱글톤 제대로 해라
    #region 싱글톤
    public static BattleManager instance = null;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(gameObject);
        }
    }
    #endregion 

    [Header("UI")]
    [SerializeField] private BattleUI _battleUI;
    [SerializeField] private BattleVictoryUI _battleVictoryUI;
    [SerializeField] private BattleDefeatUI _battleDefeatUI;

    private CookieBundle _cookieBundle;
    private EnemySpawner _enemySpawner;

    private int _enemyCountInStage = 0;  // 이번 스테이지의 모든 적수
    private int _currentWaveIndex = 0;   // 현재 스테이지의 wave count
    private int _distanceIndex = 0;      // 현재 쿠키들이 달려온 거리를 int로 나타냄


    private BaseController[] _cookies;

    public List<BaseController> Cookies { get; private set; }
    public StageData StageData { get; private set; }

    // 전투 출정할 때 이거 해주고 씬 이동해서 얍얍하자
    public void Init(int[] cookiesData, StageData stageData)
    {
        _cookies = new BaseController[cookiesData.Length];
        Cookies = new List<BaseController>();

        for (int i = 0; i < cookiesData.Length; i++)
            if(cookiesData[i] != -1)
            {
                _cookies[i] = Instantiate(DataBaseManager.Instance.AllCookies[cookiesData[i]]);
                Cookies.Add(_cookies[i]);
            }

        StageData = stageData;
    }

    // 씬 이동 후 바로 이거 해주자
    public void StartBattle()
    {
        // 수치 초기화
        _enemyCountInStage = 0;
        _currentWaveIndex = 0;
        _distanceIndex = 0;

        _cookieBundle = FindObjectOfType<CookieBundle>();
        _enemySpawner = FindObjectOfType<EnemySpawner>();

        _cookieBundle.StartBattle(_cookies);
        _enemySpawner.Init(StageData);

        // 이번 스테이지의 모든 적 수를 센다.
        for(int i = 0; i < StageData.WaveInfo.Length; i++)
            for(int j = 0; j < StageData.WaveInfo[i].enemies.Length; j++)
                if (StageData.WaveInfo[i].enemies[j] != null)
                    _enemyCountInStage++;
    }

    public void TrySpawnNextWave()
    {
        if (_currentWaveIndex >= StageData.WaveInfo.Length)
            return;


        if (_distanceIndex++ == StageData.WaveInfo[_currentWaveIndex].distance)
        {
            _enemySpawner.SpawnEnemy();
            _currentWaveIndex++;
        }
        _battleUI.SetBattleGauge((float)_distanceIndex / (StageData.WaveInfo[StageData.WaveInfo.Length - 1].distance + 2));
    }

    public void ChangeUI(BaseUI ui)
    {
        GameManager.UI.ClearUI();
        GameManager.UI.PushUI(ui);
    }

    // 적이 죽을 때마다 이 메소드를 실행
    public void CheckGameOver(BaseController cookie)
    {
        Cookies.Remove(cookie);

        if (Cookies.Count == 0)
            GameOver();
    }

    // 우리 쿠키가 죽을 때마다 이 메소드를 실행
    public void CheckGameClear()
    {
        _enemyCountInStage--;

        if(_enemyCountInStage == 0)
            GameClear();
    }

    // 게임 오버 시 
    private void GameOver()
    {
        ChangeUI(_battleDefeatUI);
    }

    // 게임 클리어 시
    private void GameClear()
    {
        _battleUI.SetBattleGauge(1);
        // 게임 종료 시 슬로우로 보여주고
        foreach (BaseController cookie in Cookies)
            cookie.CharacterBattleController.ChangeState(EBattleState.BattleIdleState);
        Invoke("s", 2f);

        /*// 몇 초 후 밑에 있는거 실행해주라
        ChangeUI(_battleVictoryUI);*/
    }

    private void s()
    {
        // 몇 초 후 밑에 있는거 실행해주라

        ChangeUI(_battleVictoryUI);
    }
}
