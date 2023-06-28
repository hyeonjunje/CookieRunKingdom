using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MapScrolling : MonoBehaviour
{
    [SerializeField] private MapPiece[] mapPieces;
    [SerializeField] private Vector3 diffForPieces = new Vector3(7.72f, 3.86f, 0f);

    private LinkedList<Transform> mapList;

    private void Awake()
    {
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
    /// 충돌할 때 방향이 같으면 true해서 제일 먼저 넣은걸 빼고 위치 조정하고 다시 끝에 넣어줌
    /// 충돌할 때 방향이 반대면 false해서 제일 나중에 넣은걸 빼서 위치 조정하고 다시 처음에 넣어줌
    /// </summary>
    /// <param name="isDirection"></param>
    public void ReArrange(bool isDirection = true)
    {
        // 앞으로 가면서 부딪혔을 때
        if(isDirection)
        {
            Debug.Log("방향이 같다.");

            Transform mapPiece = mapList.First.Value;
            mapList.RemoveFirst();

            // mapPiece 위치 조정
            mapPiece.localPosition = mapList.Last.Value.localPosition + diffForPieces;

            mapList.AddLast(mapPiece);
        }
        else
        {
            Debug.Log("방향이 반대다.");

            Transform mapPiece = mapList.Last.Value;
            mapList.RemoveLast();

            // mapPiece 위치 조정
            mapPiece.localPosition = mapList.First.Value.localPosition - diffForPieces;

            mapList.AddFirst(mapPiece);
        }
    }
}
