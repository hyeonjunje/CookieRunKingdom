using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

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


    public List<CookieController> CookieInStartList { get; private set; }
    public List<CookieController> CookiesInBattleList { get; private set; } 
    public StageData StageData { get; private set; }
    public bool IsBattleOver { get; private set; } = false;


    private int _cookieCount = 0;

    private void Update()
    {
        Debug.Log(CookieInStartList.Count + "   " + CookiesInBattleList.Count);
    }

    // ���� ������ �� �̰� ���ְ� �� �̵��ؼ� �������
    public void SetStage(List<CookieController> cookies, StageData stageData)
    {
        CookieInStartList = cookies;
        CookiesInBattleList = cookies;

        StageData = stageData;
    }

    // �� �̵� �� �ٷ� �̰� ������
    public void Init()
    {
        IsBattleOver = false;

        // ��ġ �ʱ�ȭ
        _enemyCountInStage = 0;
        _currentWaveIndex = 0;
        _distanceIndex = 0;

        _cookieBundle = FindObjectOfType<CookieBundle>();
        _enemySpawner = FindObjectOfType<EnemySpawner>();

        _cookieBundle.Init();
        _enemySpawner.Init(StageData);

        // �̹� ���������� ��� �� ���� ����.
        for(int i = 0; i < StageData.WaveInfo.Length; i++)
            for(int j = 0; j < StageData.WaveInfo[i].enemies.Length; j++)
                if (StageData.WaveInfo[i].enemies[j] != null)
                    _enemyCountInStage++;
    }

    public void StartBattle()
    {
        // ��� ��Ű���� �޷�����.
        foreach (BaseController cookie in CookieInStartList)
            cookie.CharacterBattleController.ChangeState(EBattleState.BattleRunState);
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

        if(_distanceIndex != 1)
            _battleUI.SetBattleGauge((float)_distanceIndex / (StageData.WaveInfo[StageData.WaveInfo.Length - 1].distance + 2));
    }

    // �츮 ��Ű�� ���� ������ �� �޼ҵ带 ����
    public void CheckGameOver()
    {
        _cookieCount++;

        if (_cookieCount == CookiesInBattleList.Count)
            GameOver();
    }

    // ���� ���� ������ �� �޼ҵ带 ����
    public void CheckGameClear()
    {
        _enemyCountInStage--;

        if(_enemyCountInStage == 0)
            GameClear();
    }

    // ���� ���� �� 
    private void GameOver()
    {
        IsBattleOver = true;

        ChangeUI(_battleDefeatUI);
    }

    // ���� Ŭ���� ��
    private void GameClear()
    {
        IsBattleOver = true;

        _battleUI.SetBattleGauge(1);
        // ���� ���� �� ���ο�� �����ְ�
        foreach (BaseController cookie in CookiesInBattleList)
            cookie.CharacterBattleController.ChangeState(EBattleState.BattleIdleState);

        ChangeUI(_battleVictoryUI);
    }

    private void ChangeUI(BaseUI ui)
    {
        Sequence seq = DOTween.Sequence();

        seq.AppendCallback(() => Time.timeScale = 0.5f)
            .AppendInterval(2f)
            .AppendCallback(() => Time.timeScale = 1f)
            .AppendInterval(1f)
            .OnComplete(() =>
            {
                foreach (BaseController cookie in CookiesInBattleList)
                    cookie.CharacterBattleController.ChangeState(EBattleState.BattleIdleState);

                GameManager.UI.ClearUI();
                GameManager.UI.PushUI(ui);
            });
    }
}
