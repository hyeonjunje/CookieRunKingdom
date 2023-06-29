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


    private CookieBundle _cookieBundle;
    private EnemySpawner _enemySpawner;

    [SerializeField] private BattleUI _battleUI;

    [SerializeField] private BaseController[] _cookies;
    [SerializeField] private StageData _stageData;

    public BaseController[] Cookies => _cookies;

    // ���� ������ �� �̰� ���ְ� �� �̵��ؼ� �������
    public void Init(BaseController[] cookies, StageData stageData)
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
        _cookieBundle = FindObjectOfType<CookieBundle>();
        _enemySpawner = FindObjectOfType<EnemySpawner>();

        _cookieBundle.StartBattle(_cookies);
        _enemySpawner.Init(_stageData);
        _enemySpawner.SpawnEnemy();  // �ϴ� ������ �̷��� �ϰ� ���߿� �ٲ�. �̵��Ѱſ� ���� ���� �����ǰ�

        // ���߿� UIManager�� ����� �Ұ�
        _battleUI.gameObject.SetActive(true);
        _battleUI.Show();
    }
}
