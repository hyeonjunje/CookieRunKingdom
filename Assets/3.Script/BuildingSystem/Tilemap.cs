using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tilemap : MonoBehaviour
{
    // ��ġ
    public float x { get; private set; }
    public float y { get; private set; }

    // Order in Layer
    public int order { get; private set; }

    // ����ִ���
    public bool isEmpty = true;


    private SpriteRenderer spriteRenderer;

    private void Awake()
    {
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    // tilemap �ʱ�ȭ
    public void SetInfo(float x, float y, int order)
    {
        this.x = x;
        this.y = y;
        this.order = order;
        isEmpty = true;

        transform.localPosition = new Vector3(x, y, 0);
        transform.localRotation = Quaternion.identity;
        spriteRenderer.sortingOrder = -401;
    }

    // sprite �ʱ�ȭ
    public void SetSprite(Sprite sprite)
    {
        spriteRenderer.sprite = sprite;
    }
}
