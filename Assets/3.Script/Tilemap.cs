using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tilemap : MonoBehaviour
{
    // ��ġ
    private float x;
    private float y;
    
    // Order in Layer
    private int order;

    // ���� sprite
    private Sprite currentSprite;

    private SpriteRenderer sr;

    private void Awake()
    {
        sr = GetComponent<SpriteRenderer>();
    }

    // tilemap �ʱ�ȭ
    public void SetInfo(int x, int y, int order)
    {
        this.x = x;
        this.y = y;
        this.order = order;

        transform.localPosition = new Vector3(x, y, 0);
        transform.localRotation = Quaternion.identity;
        sr.sortingOrder = this.order;
    }

    // sprite �ʱ�ȭ
    public void SetSprite(Sprite sprite)
    {
        currentSprite = sprite;
        sr.sprite = sprite;
    }
}
