using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieSelectUI : BaseUI
{
    [SerializeField] private CookieReadyAdventureUI _cookieReadyAdventureUI;


    /// <summary>
    /// 8 5 2
    /// 9 6 3
    /// 7 4 1
    /// </summary>
    /// 

    [SerializeField] private Transform[] cookiePositions;

    private CookieController[] isPosition;
    private int[,] priority = new int[,] { { 0, 1, 2 }, { 1, 2, 0 }, { 2, 1, 0 } };

    private KingdomManager _manager;

    private Camera _camera;
    private StageData _stageData;
    private Vector3 _prevCameraPos;
    private float _prevOrthosize;

    public List<CookieController> SelectedTempCookies { get; private set; }


    public override void Init()
    {
        base.Init();

        _manager = FindObjectOfType<KingdomManager>();
        _camera = Camera.main;
    }


    public void InitStageData(StageData stageData, Vector3 prevCameraPos, float prevOrthoSize)
    {
        _stageData = stageData;
        GameManager.Game.StageData = _stageData;
        _prevCameraPos = prevCameraPos;
        _prevOrthosize = prevOrthoSize;
    }

    public override void Hide()
    {
        _manager.IsMoveCamera = true;
        _camera.orthographicSize = _prevOrthosize;
        _camera.transform.position = _prevCameraPos;

        SelectedTempCookies.ForEach(cookie => Destroy(cookie.gameObject));

        base.Hide();
    }

    public override void Show()
    {
        base.Show();
        SelectedTempCookies = new List<CookieController>();
        _manager.IsMoveCamera = false;
        _camera.transform.position = new Vector3(0, 0, _camera.transform.position.z);

        List<CookieController> allCookies = _manager.allCookies;

        for (int i = 0; i < allCookies.Count; i++)
            if (allCookies[i].CookieStat.IsBattleMember)
                AddCookie(allCookies[i]);

        // BattleCookies 다 설정하면 CookieReadyAdventure UI 켜주기
        GameManager.UI.ShowPopUpUI(_cookieReadyAdventureUI);
    }

    #region 쿠키 배치
    public void AddCookie(CookieController cookiePrefab)
    {
        if (SelectedTempCookies.Count >= 5)
            return;

        CookieController cookie = Instantiate(cookiePrefab, transform);
        cookie.gameObject.SetActive(true);

        cookie.CharacterAnimator.PlayAnimation("battle_idle");
        cookie.CharacterAnimator.SettingOrderLayer(true);

        SelectedTempCookies.Add(cookie);
        SelectedTempCookies.Sort(CustomComparison);

        foreach (CookieController realCookie in _manager.allCookies)
            if (realCookie.Data.CharacterName == cookie.Data.CharacterName)
                realCookie.CookieStat.SetBattle(true, -1);

        ReArrange();
    }

    public void RemoveCookie(CookieController cookie)
    {
        foreach(CookieController selectedCookie in SelectedTempCookies)
        {
            if(cookie.Data.CharacterName == selectedCookie.Data.CharacterName)
            {
                SelectedTempCookies.Remove(selectedCookie);
                Destroy(selectedCookie.gameObject);
                SelectedTempCookies.Sort(CustomComparison);
                ReArrange();

                foreach (CookieController realCookie in _manager.allCookies)
                    if (realCookie.Data.CharacterName == cookie.Data.CharacterName)
                        realCookie.CookieStat.SetBattle(false, -1);

                return;
            }
        }
    }

    private int CustomComparison(CookieController x, CookieController y)
    {
        // 후방, 중앙, 전방
        int result = ((CookieData)x.Data).CookiePosition.CompareTo(((CookieData)y.Data).CookiePosition);

        // 같으면 index 순
        if (result == 0)
            result = ((CookieData)x.Data).CookieIndex.CompareTo(((CookieData)x.Data).CookieIndex);

        return result;
    }

    private void ReArrange()
    {
        isPosition = new CookieController[cookiePositions.Length];

        for (int i = 0; i < SelectedTempCookies.Count; i++)
        {
            int cookiePosition = (int)((CookieData)SelectedTempCookies[i].Data).CookiePosition;
            bool isArrange = false;

            for (int j = 0; j < priority.GetLength(1); j++)
            {
                int startIndex = priority[cookiePosition, j] * priority.GetLength(1);
                int endIndex = startIndex + priority.GetLength(1) - 1;

                for (int h = startIndex; h < endIndex; h++)
                {
                    if (isPosition[h] == null)
                    {
                        isPosition[h] = SelectedTempCookies[i];
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

        SetPosition();
    }

    private void SetPosition()
    {
        for(int i = 0; i < isPosition.Length; i++)
            if (isPosition[i] != null)
                foreach(CookieController cookie in _manager.allCookies)
                    if(cookie.Data.CharacterName == isPosition[i].Data.CharacterName)
                        cookie.CookieStat.SetBattle(true, i);
    }
    #endregion


    #region 버튼에 이벤트로 넣어줄 메소드
    public void OnClickBattleStartButton()
    {
        // 고기 젤리 확인하고
        if(GameManager.Game.Jelly >= _stageData.Jelly)
        {
            GameManager.Game.Jelly -= _stageData.Jelly;
        }
        else
        {
            Debug.Log("젤리가 부족합니다.");
            return;
        }

        // 출전할 쿠키가 하나도 없으면 무시
        if(SelectedTempCookies.Count == 0)
            return;

        // 씬전환시 데이터 저장
        _manager.allCookies.ForEach(cookie => cookie.CookieStat.SaveCookie());

        GameManager.Scene.LoadScene(ESceneName.Battle);
    }
    #endregion
}
