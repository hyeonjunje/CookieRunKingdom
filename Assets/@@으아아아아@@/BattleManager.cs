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


    private CookieBundle _cookieBundle;
    private EnemySpawner _enemySpawner;

    [SerializeField] private BattleUI _battleUI;

    [SerializeField] private BaseController[] _cookies;
    [SerializeField] private StageData _stageData;

    public BaseController[] Cookies => _cookies;

    // 전투 출정할 때 이거 해주고 씬 이동해서 얍얍하자
    public void Init(BaseController[] cookies, StageData stageData)
    {
        _cookies = cookies;
        _stageData = stageData;
    }

    private void Start()
    {
        StartBattle();
    }

    // 씬 이동 후 바로 이거 해주자
    public void StartBattle()
    {
        _cookieBundle = FindObjectOfType<CookieBundle>();
        _enemySpawner = FindObjectOfType<EnemySpawner>();

        _cookieBundle.StartBattle(_cookies);
        _enemySpawner.Init(_stageData);
        _enemySpawner.SpawnEnemy();  // 일단 지금은 이렇게 하고 나중에 바꿔. 이동한거에 따라 몬스터 생성되게

        // 나중에 UIManager로 제대로 할것
        _battleUI.gameObject.SetActive(true);
        _battleUI.Show();
    }
}
