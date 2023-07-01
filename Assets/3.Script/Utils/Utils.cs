using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class Utils
{
    public static readonly Vector3 Dir = new Vector3(7.72f, 3.86f, 0);

    /// <summary>
    /// 모든 자기의 자식들을 Destroy해주는 함수
    /// </summary>
    /// <param name="parent">자식을 다 없애줄 부모 오브젝트</param>
    public static void DestroyAllChild(this Transform parent)
    {
        foreach (Transform child in parent)
        {
            if (!child.Equals(parent))
                GameObject.Destroy(child.gameObject);
        }
    }

    /// <summary>
    /// 정해준 index부터 모든 자식을 Destory해주는 함수
    /// </summary>
    /// <param name="parent">자식을 없애줄 부모 오브젝트</param>
    /// <param name="index">몇번째 자식부터 없애줄지 결정</param>
    public static void DestroyChildren(this Transform parent, int index)
    {
        int currentIndex = 0;

        foreach (Transform child in parent)
        {
            if (!child.Equals(parent))
            {
                if (currentIndex >= index)
                    GameObject.Destroy(child.gameObject);

                currentIndex++;
            }
        }
    }

    /// <summary>
    /// 초를 넣으면 시간 문자열로 반환해주는 메소드
    /// </summary>
    /// <param name="time">초</param>
    /// <returns>초를 변환한 시간 문자열</returns>
    public static string GetTimeText(float time)
    {
        float hour = (int)time / 3600;
        time %= 3600;
        float min = (int)time / 60;
        time %= 60;
        float sec = time;

        string result = "";

        if (hour != 0)
            result += hour + "시간 ";
        if (min != 0)
            result += min + "분 ";

        result += sec + "초";

        return result;
    }
}
