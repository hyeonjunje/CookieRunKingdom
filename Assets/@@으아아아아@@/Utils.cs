using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class Utils
{
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
}
