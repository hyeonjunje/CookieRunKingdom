using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieBundle : MonoBehaviour
{
    /// <summary>
    /// 2 3 1  전방
    /// 5 6 4  중앙
    /// 8 9 7  후방
    /// </summary>
    [SerializeField] private Transform[] cookiePositions;
    private BaseController[] isPosition;
    private List<BaseController> myCookies = new List<BaseController>();
    private int[,] priority = new int[,] { { 0, 1, 2 }, { 1, 2, 0 }, { 2, 1, 0 } };

    public int CookieRunStateCount { get; private set; }

    private float _startSpeed;
    private float _currentSpeed = 0f;

    public void ActiveMove(bool on)
    {
        if (on)
            CookieRunStateCount++;
        else
            CookieRunStateCount--;


        if(CookieRunStateCount == myCookies.Count)
            _currentSpeed = _startSpeed;
        else
            _currentSpeed = 0f;
    }

    private void Update()
    {
        if (myCookies.Count == 0)
            return;

        transform.position += Utils.Dir.normalized * _currentSpeed * Time.deltaTime;
    }

    public void Init(BaseController[] cookies)
    {
        isPosition = cookies;

        for (int i = 0; i < cookies.Length; i++)
        {
            if(cookies[i] != null)
            {
                MovePosition(i);
                myCookies.Add(cookies[i]);
            }
        }

        _startSpeed = myCookies[0].Data.MoveSpeed;

        foreach (BaseController cookie in myCookies)
        {
            cookie.gameObject.layer = LayerMask.NameToLayer("Cookie");
            cookie.CharacterBattleController.StartBattle(true);
            cookie.CharacterBattleController.SetEnemy(LayerMask.NameToLayer("Enemy"));
        }
    }

    private void MovePosition(int index)
    {
        isPosition[index].transform.SetParent(cookiePositions[index]);
        isPosition[index].transform.localPosition = Vector3.zero;
        isPosition[index].transform.SetParent(null);

        isPosition[index].CharacterBattleController.SetPosition(this, cookiePositions[index]);
    }
}
