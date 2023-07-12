using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class Utils
{
    public static readonly float TouchTime = 0.3f;  // ��ġ�� �νĵǴ� �ð�

    public static readonly int JellyTime = 5;

    public static readonly Vector3 Dir = new Vector3(7.72f, 3.86f, 0);

    public static readonly float SKillLevelUpInterest = 1.04f;
    public static readonly float LevelUpInterest = 1.045f;
    public static readonly float EvolutionInterest = 1.05f;

    public static readonly Vector2 MapStartPoint = new Vector2(-100, -100);
    public static readonly Vector2 MapEndPoint = new Vector2(100, 100);

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
    public static string GetTimeText(int time, bool isString = true)
    {
        int hour = time / 3600;
        time %= 3600;
        int min = time / 60;
        time %= 60;
        int sec = time;

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


    /// <summary>
    /// �ش� Ʈ�������� ��ġ�� �׸��忡 ���缭 �̵���ŵ�ϴ�.
    /// </summary>
    /// <param name="transform">�̵���ų Ʈ������</param>
    public static void SetGridTransform(this Transform transform)
    {
        Vector3Int pos = GridManager.Instance.Grid.WorldToCell(transform.position);
        transform.position = GridManager.Instance.Grid.CellToWorld(pos);
    }

    /// <summary>
    /// ��������Ʈ�� �ؽ���2D�� ��ȯ���ִ� �޼ҵ�
    /// </summary>
    /// <param name="sprite">��ȯ�� ��������Ʈ</param>
    /// <returns>��ȯ�� �ؽ���2D</returns>
    public static Texture2D TextureFromSprite(Sprite sprite)
    {
        if (sprite.rect.width != sprite.texture.width)
        {
            Texture2D newText = new Texture2D((int)sprite.rect.width, (int)sprite.rect.height);
            Color[] newColors = sprite.texture.GetPixels((int)sprite.textureRect.x,
                                                         (int)sprite.textureRect.y,
                                                         (int)sprite.textureRect.width,
                                                         (int)sprite.textureRect.height);
            newText.SetPixels(newColors);
            newText.Apply();
            return newText;
        }
        else
            return sprite.texture;
    }

}
