using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MapScrolling : MonoBehaviour
{
    [SerializeField] private MapPiece[] mapPieces;
    private Vector3 diffForPieces;

    private LinkedList<Transform> mapList;

    private void Awake()
    {
        diffForPieces = Utils.Dir;

        mapList = new LinkedList<Transform>();

        transform.position -= diffForPieces * 3;

        for (int i = 0; i < mapPieces.Length; i++)
        {
            mapPieces[i].Init(this);

            mapList.AddLast(mapPieces[i].transform);
            mapPieces[i].transform.localPosition += diffForPieces * i;
        }
    }

    /// <summary>
    /// �浹�� �� ������ ������ true�ؼ� ���� ���� ������ ���� ��ġ �����ϰ� �ٽ� ���� �־���
    /// �浹�� �� ������ �ݴ�� false�ؼ� ���� ���߿� ������ ���� ��ġ �����ϰ� �ٽ� ó���� �־���
    /// </summary>
    /// <param name="isDirection"></param>
    public void ReArrange(bool isDirection = true)
    {
        // ������ ���鼭 �ε����� ��
        if(isDirection)
        {
            Debug.Log("������ ����.");

            Transform mapPiece = mapList.First.Value;
            mapList.RemoveFirst();

            // mapPiece ��ġ ����
            mapPiece.localPosition = mapList.Last.Value.localPosition + diffForPieces;

            mapList.AddLast(mapPiece);
        }
        else
        {
            Debug.Log("������ �ݴ��.");

            Transform mapPiece = mapList.Last.Value;
            mapList.RemoveLast();

            // mapPiece ��ġ ����
            mapPiece.localPosition = mapList.First.Value.localPosition - diffForPieces;

            mapList.AddFirst(mapPiece);
        }
    }
}
