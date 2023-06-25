using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class TimeTest : MonoBehaviour
{
    private string currentTime;

    private DateTime d;

    private int diffSec = 0;

    private void Awake()
    {
        d = DateTime.Now;
    }

    private void Update()
    {
        Debug.Log((DateTime.Now - d).TotalSeconds);
    }
}
