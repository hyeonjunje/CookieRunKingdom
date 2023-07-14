using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class TestInfo : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI id;
    [SerializeField] private TextMeshProUGUI pw;
    [SerializeField] private TextMeshProUGUI birth;

    public void SetInfo()
    {
        id.text = SQLControll.instance.info.U_Name;
        pw.text = SQLControll.instance.info.U_Password;
        birth.text = SQLControll.instance.info.U_Birthday;
    }
}
