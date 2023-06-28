using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TTEESTEST : MonoBehaviour
{
    [SerializeField] private Transform[] cookie;

    private void Awake()
    {
        for(int i = 0; i < cookie.Length; i++)
        {
            string parentName = cookie[i].name.Substring(cookie[i].name.Length - 5, 4);
            Transform parent = new GameObject("Cookie" + parentName).transform;

            cookie[i].SetParent(parent);

            parent.position = cookie[i].position;
            cookie[i].localPosition = Vector3.zero; 
        }
    }
}
