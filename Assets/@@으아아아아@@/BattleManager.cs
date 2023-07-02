using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleManager : MonoBehaviour
{
    // ���߿� �̱��� ����� �ض�
    #region �̱���
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

    private int _enemyCountInStage = 0;  // �̹� ���������� ��� ����
    private int _currentWaveIndex = 0;   // ���� ���������� wave count
    private int _distanceIndex = 0;      // ���� ��Ű���� �޷��� �Ÿ��� int�� ��Ÿ��


    private BaseController[] _cookies;

    public List<BaseController> Cookies { get; private set; }
    public StageData StageData { get; private set; }

    // ���� ������ �� �̰� ���ְ� �� �̵��ؼ� �������
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

    // �� �̵� �� �ٷ� �̰� ������
    public void StartBattle()
    {
        // ��ġ �ʱ�ȭ
        _enemyCountInStage = 0;
        _currentWaveIndex = 0;
        _distanceIndex = 0;

        _cookieBundle = FindObjectOfType<CookieBundle>();
        _enemySpawner = FindObjectOfType<EnemySpawner>();

        _cookieBundle.StartBattle(_cookies);
        _enemySpawner.Init(StageData);

        // �̹� ���������� ��� �� ���� ����.
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

    // ���� ���� ������ �� �޼ҵ带 ����
    public void CheckGameOver(BaseController cookie)
    {
        Cookies.Remove(cookie);

        if (Cookies.Count == 0)
            GameOver();
    }

    // �츮 ��Ű�� ���� ������ �� �޼ҵ带 ����
    public void CheckGameClear()
    {
        _enemyCountInStage--;

        if(_enemyCountInStage == 0)
            GameClear();
    }

    // ���� ���� �� 
    private void GameOver()
    {
        ChangeUI(_battleDefeatUI);
    }

    // ���� Ŭ���� ��
    private void GameClear()
    {
        _battleUI.SetBattleGauge(1);
        // ���� ���� �� ���ο�� �����ְ�
        foreach (BaseController cookie in Cookies)
            cookie.CharacterBattleController.ChangeState(EBattleState.BattleIdleState);
        Invoke("s", 2f);

        /*// �� �� �� �ؿ� �ִ°� �������ֶ�
        ChangeUI(_battleVictoryUI);*/
    }

    private void s()
    {
        // �� �� �� �ؿ� �ִ°� �������ֶ�

        ChangeUI(_battleVictoryUI);
    }
}
