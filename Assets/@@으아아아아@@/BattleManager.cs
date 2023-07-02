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

    [Header("Test")]
    [SerializeField] private List<BaseController> _cookies;
    [SerializeField] private StageData _stageData;

    private CookieBundle _cookieBundle;
    private EnemySpawner _enemySpawner;

    private int _enemyCountInStage = 0;  // �̹� ���������� ��� ����
    private int _currentWaveIndex = 0;   // ���� ���������� wave count
    private int _distanceIndex = 0;      // ���� ��Ű���� �޷��� �Ÿ��� int�� ��Ÿ��

    public List<BaseController> Cookies => _cookies;

    // ���� ������ �� �̰� ���ְ� �� �̵��ؼ� �������
    public void Init(List<BaseController> cookies, StageData stageData)
    {
        _cookies = cookies;
        _stageData = stageData;
    }

    private void Start()
    {
        StartBattle();
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
        _enemySpawner.Init(_stageData);

        // �̹� ���������� ��� �� ���� ����.
        for(int i = 0; i < _stageData.WaveInfo.Length; i++)
            for(int j = 0; j < _stageData.WaveInfo[i].enemies.Length; j++)
                if (_stageData.WaveInfo[i].enemies[j] != null)
                    _enemyCountInStage++;

        ChangeUI(_battleUI);
    }

    public void TrySpawnNextWave()
    {
        if (_currentWaveIndex >= _stageData.WaveInfo.Length)
            return;


        if (_distanceIndex++ == _stageData.WaveInfo[_currentWaveIndex].distance)
        {
            _enemySpawner.SpawnEnemy();
            _currentWaveIndex++;
        }
        _battleUI.SetBattleGauge((float)_distanceIndex / (_stageData.WaveInfo[_stageData.WaveInfo.Length - 1].distance + 2));
    }

    public void ChangeUI(BaseUI ui)
    {
        UIManager.instance.ClearUI();
        UIManager.instance.PushUI(ui);
    }

    // ���� ���� ������ �� �޼ҵ带 ����
    public void CheckGameOver(BaseController cookie)
    {
        _cookies.Remove(cookie);

        if (_cookies.Count == 0)
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
        foreach (BaseController cookie in _cookies)
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
