using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieSelectUI : BaseUI
{
    /// <summary>
    /// 8 5 2
    /// 9 6 3
    /// 7 4 1
    /// </summary>
    [SerializeField] private Transform[] cookiePositions;
    private List<BaseController> _cookies = new List<BaseController>();
    private BaseController[] isPosition;
    private int[,] priority = new int[,] { { 0, 1, 2 }, { 1, 2, 0 }, { 2, 1, 0 } };

    private KingdomManager _manager;

    private Camera _camera;
    private StageData _stageData;
    private Vector3 _prevCameraPos;
    private float _prevOrthosize;


    private void Awake()
    {
        _manager = FindObjectOfType<KingdomManager>();
        _camera = Camera.main;
    }

    public void InitStageData(StageData stageData, Vector3 prevCameraPos, float prevOrthoSize)
    {
        _stageData = stageData;
        _prevCameraPos = prevCameraPos;
        _prevOrthosize = prevOrthoSize;
    }

    public override void Hide()
    {
        _manager.IsMoveCamera = true;
        _camera.orthographicSize = _prevOrthosize;
        _camera.transform.position = _prevCameraPos;

        _cookies.ForEach(cookie => Destroy(cookie.gameObject));

        base.Hide();
    }

    public override void Show()
    {
        base.Show();
        _cookies = new List<BaseController>();
        _manager.IsMoveCamera = false;
        _camera.transform.position = new Vector3(0, 0, _camera.transform.position.z);


        if(GameManager.Game.BattleCookies == null)
        {
            BaseController[] defaultCookies = DataBaseManager.Instance.DefaultCookie;
            // 제일 처음 없으면 용쿠덱으로 초기화
            for (int i = 0; i < defaultCookies.Length; i++)
            {
                AddCookie(defaultCookies[i]);
            }
        }
        else
        {
            for(int i = 0; i < GameManager.Game.BattleCookies.Length; i++)
                if (GameManager.Game.BattleCookies[i] != -1)
                    AddCookie(DataBaseManager.Instance.AllCookies[GameManager.Game.BattleCookies[i]]);
        }
    }

    #region 쿠키 배치
    private void AddCookie(BaseController cookiePrefab)
    {
        if (_cookies.Count >= 5)
            return;

        BaseController cookie = Instantiate(cookiePrefab, transform);
        cookie.CharacterAnimator.SettingOrderLayer(true);
        cookie.CharacterAnimator.PlayAnimation("battle_idle");

        _cookies.Add(cookie);
        _cookies.Sort(CustomComparison);
        ReArrange();
    }

    private void RemoveCookie(BaseController cookie)
    {
        _cookies.Remove(cookie);
        Destroy(cookie.gameObject);
        _cookies.Sort(CustomComparison);
        ReArrange();
    }

    private int CustomComparison(BaseController x, BaseController y)
    {
        int result = ((CookieData)x.Data).CookiePosition.CompareTo(((CookieData)y.Data).CookiePosition);

        // 같으면 이름순
        if (result == 0)
            result = x.Data.CharacterName.CompareTo(y.Data.CharacterName);

        return result;
    }

    private void ReArrange()
    {
        isPosition = new BaseController[cookiePositions.Length];

        for (int i = 0; i < _cookies.Count; i++)
        {
            int cookiePosition = (int)((CookieData)_cookies[i].Data).CookiePosition;
            bool isArrange = false;

            for (int j = 0; j < priority.GetLength(1); j++)
            {
                int startIndex = priority[cookiePosition, j] * priority.GetLength(1);
                int endIndex = startIndex + priority.GetLength(1) - 1;

                for (int h = startIndex; h < endIndex; h++)
                {
                    if (isPosition[h] == null)
                    {
                        isPosition[h] = _cookies[i];
                        isArrange = true;
                        break;
                    }
                }
                if (isArrange)
                    break;
            }
        }


        for (int i = 0; i < priority.GetLength(0); i++)
        {
            int count = 0;
            int index = 0;

            int startIndex = i * priority.GetLength(1);
            int endIndex = startIndex + priority.GetLength(1) - 1;

            for (int j = startIndex; j < endIndex; j++)
            {
                if (isPosition[j])
                {
                    index = j;
                    count++;
                }
            }

            if (count == 1)
            {
                isPosition[endIndex] = isPosition[index];
                isPosition[index] = null;
            }
        }

        for (int i = 0; i < isPosition.Length; i++)
        {
            if (isPosition[i] != null)
            {
                isPosition[i].transform.SetParent(cookiePositions[i]);
                isPosition[i].transform.localPosition = Vector3.zero;
                isPosition[i].transform.localScale = Vector3.one * 100f;
            }
        }
    }
    #endregion


    #region 버튼에 이벤트로 넣어줄 메소드
    public void ExitUI()
    {
        GameManager.UI.PopUI();
    }

    public void OnClickBattleStartButton()
    {
        // 고기 젤리 확인하고

        // 출전할 쿠키가 하나도 없으면 무시
        if(_cookies.Count == 0)
        {
            Debug.Log("혹시 이거 해?");
            return;
        }

        // 초기화
        GameManager.Game.BattleCookies = new int[cookiePositions.Length];
        for (int i = 0; i < GameManager.Game.BattleCookies.Length; i++)
            GameManager.Game.BattleCookies[i] = -1;

        for (int i = 0; i < isPosition.Length; i++)
        {
            if(isPosition[i] != null)
            {
                int cookieIndex = 0;
                for(int j = 0; j < DataBaseManager.Instance.AllCookies.Length; j++)
                {
                    if(isPosition[i].Data.CharacterName == DataBaseManager.Instance.AllCookies[j].Data.CharacterName)
                    {
                        cookieIndex = j;
                        break;
                    }
                }

                GameManager.Game.BattleCookies[i] = cookieIndex;
            }
        }

        GameManager.Game.StageData = _stageData;

        GameManager.Scene.LoadScene(ESceneName.Battle);
    }
    #endregion
}
