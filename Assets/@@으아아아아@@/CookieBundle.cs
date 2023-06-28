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

    [Header("Test")]
    [SerializeField] private CookieController[] cookies;
    [SerializeField] private Vector3 diffForPieces = new Vector3(7.72f, 3.86f, 0f);
    [SerializeField] private float speed = 5f;

    private List<CookieController> myCookies = new List<CookieController>();

    private CookieController[] isPosition;
    private int[,] priority = new int[,] { { 0, 1, 2 }, { 1, 2, 0 }, { 2, 1, 0 } };

    // 원래는 start에서 하면 안됨
    private void Start()
    {
        StartBattle(cookies);
    }

    private void Update()
    {
        transform.position += diffForPieces.normalized * speed * Time.deltaTime;
    }

    public void StartBattle(CookieController[] cookies)
    {
        foreach (CookieController cookie in cookies)
        {
            myCookies.Add(cookie);
            // 자리 기준으로 정렬
            myCookies.Sort(CustomComparison);
            // 재배치
            ReArrange();
        }
    }

    private int CustomComparison(CookieController x, CookieController y)
    {
        int result = x.Data.CookiePosition.CompareTo(y.Data.CookiePosition);

        // 같으면 이름순
        if(result == 0)
            result = x.Data.CookieName.CompareTo(y.Data.CookieName); 

        return result;
    }

    private void ReArrange()
    {
        isPosition = new CookieController[cookiePositions.Length];

        for (int i = 0; i < myCookies.Count; i++)
        {
            int cookiePosition = (int)myCookies[i].Data.CookiePosition;
            bool isArrange = false;

            for(int j = 0; j < priority.GetLength(1); j++)
            {
                int startIndex = priority[cookiePosition, j] * priority.GetLength(1);
                int endIndex = startIndex + priority.GetLength(1) - 1;

                for (int h = startIndex; h < endIndex; h++)
                {
                    if (isPosition[h] == null)
                    {
                        isPosition[h] = myCookies[i];
                        isArrange = true;
                        break;
                    }
                }
                if (isArrange)
                    break;
            }
        }


        for(int i = 0; i < priority.GetLength(0); i++)
        {
            int count = 0;
            int index = 0;

            int startIndex = i * priority.GetLength(1);
            int endIndex = startIndex + priority.GetLength(1) - 1;

            for(int j = startIndex; j < endIndex; j++)
            {
                if (isPosition[j])
                {
                    index = j;
                    count++;
                }
            }

            if(count == 1)
            {
                isPosition[endIndex] = isPosition[index];
                isPosition[index] = null;
            }
        }

        for (int i = 0; i < isPosition.Length; i++)
        {
            if (isPosition[i] != null)
            {
                MovePosition(i);
            }
        }
    }

    private void MovePosition(int index)
    {
        isPosition[index].transform.SetParent(cookiePositions[index]);
        isPosition[index].transform.localPosition = Vector3.zero;
        isPosition[index].CookieAnim.SettingOrder(index + 100);
    }
}
