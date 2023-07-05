using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class Utils
{
    public static readonly Vector3 Dir = new Vector3(7.72f, 3.86f, 0);

    public static readonly float LevelUpInterest = 1.045f;
    public static readonly float EvolutionInterest = 1.05f;


    /// <summary>
    /// ��� �ڱ��� �ڽĵ��� Destroy���ִ� �Լ�
    /// </summary>
    /// <param name="parent">�ڽ��� �� ������ �θ� ������Ʈ</param>
    public static void DestroyAllChild(this Transform parent)
    {
        foreach (Transform child in parent)
        {
            if (!child.Equals(parent))
                GameObject.Destroy(child.gameObject);
        }
    }

    /// <summary>
    /// ������ index���� ��� �ڽ��� Destory���ִ� �Լ�
    /// </summary>
    /// <param name="parent">�ڽ��� ������ �θ� ������Ʈ</param>
    /// <param name="index">���° �ڽĺ��� �������� ����</param>
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
    /// �ʸ� ������ �ð� ���ڿ��� ��ȯ���ִ� �޼ҵ�
    /// </summary>
    /// <param name="time">��</param>
    /// <returns>�ʸ� ��ȯ�� �ð� ���ڿ�</returns>
    public static string GetTimeText(float time, bool isString = true)
    {
        float hour = (int)time / 3600;
        time %= 3600;
        float min = (int)time / 60;
        time %= 60;
        float sec = time;

        string result = "";

        if(isString)
        {
            if (hour != 0)
                result += hour + "�ð� ";
            if (min != 0)
                result += min + "�� ";

            result += sec + "��";
        }
        else
        {
            if (min < 10)
                result += "0" + min;
            else
                result += min.ToString();

            result += ":";

            if (sec < 10)
                result += "0" + sec;
            else
                result += sec.ToString();
        }

        return result;
    }
}
