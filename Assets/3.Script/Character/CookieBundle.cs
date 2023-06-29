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
    [SerializeField] private BaseController[] cookies;

    private BaseController[] isPosition;
    private List<BaseController> myCookies = new List<BaseController>();
    private int[,] priority = new int[,] { { 0, 1, 2 }, { 1, 2, 0 }, { 2, 1, 0 } };

    private void Update()
    {
        if (myCookies.Count == 0)
            return;

        Vector3 pos = Vector3.zero;

        for(int i = 0; i < myCookies.Count; i++)
            pos += myCookies[i].transform.position;

        pos /= myCookies.Count;
        transform.position = pos;
    }

    public void StartBattle(BaseController[] cookies)
    {
        foreach (BaseController cookie in cookies)
        {
            myCookies.Add(cookie);
            // 자리 기준으로 정렬
            myCookies.Sort(CustomComparison);
            // 재배치
            ReArrange();
        }

        foreach(BaseController cookie in cookies)
        {
            cookie.CharacterBattleController.StartBattle(true);
            cookie.CharacterBattleController.SetEnemy(LayerMask.NameToLayer("Enemy"));
        }
    }
    private int CustomComparison(BaseController x, BaseController y)
    {
        int result = ((CookieData)x.Data).CookiePosition.CompareTo(((CookieData)y.Data).CookiePosition);

        // 같으면 이름순
        if(result == 0)
            result = x.Data.CharacterName.CompareTo(y.Data.CharacterName); 

        return result;
    }

    private void ReArrange()
    {
        isPosition = new BaseController[cookiePositions.Length];

        for (int i = 0; i < myCookies.Count; i++)
        {
            int cookiePosition = (int)((CookieData)myCookies[i].Data).CookiePosition;
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
        // isPosition[index].CharacterAnimator.SettingOrder(index + 100);

        isPosition[index].transform.SetParent(null);
    }
}
