using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BTDebugUI : MonoBehaviour
{
    [SerializeField] private BehaviorTree _tree;
    [SerializeField] private Text _debugText;

    private void Start()
    {
        _debugText.text = "";
    }


    private void Update()
    {
        _debugText.text = _tree.GetDebugText();
    }

}
