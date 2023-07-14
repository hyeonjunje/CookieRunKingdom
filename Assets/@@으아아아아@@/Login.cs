using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class Login : MonoBehaviour
{
    public TMP_InputField id;
    public TMP_InputField pw;

    [SerializeField] private TextMeshProUGUI status;
    [SerializeField] private TestInfo testInfo;

    public void LoginEvent()
    {
        if (id.text.Equals(string.Empty) || pw.text.Equals(string.Empty))
        {
            status.text = "���̵� ��й�ȣ�� �Է��� �ּ���.";
            return;
        }

        if (SQLControll.instance.Login(id.text, pw.text))
        {
            // �α��� ����
            UserInfo2 info = SQLControll.instance.info;
            Debug.Log(info.U_Name + " | " + info.U_Password);
            gameObject.SetActive(false);
            testInfo.gameObject.SetActive(true);
            testInfo.SetInfo();
        }
        else
        {
            // �α��� ����
            status.text = "���̵� ��й�ȣ�� Ȯ���� �ּ���.";
            return;
        }
    }

    public void SignUpEvent()
    {
        if (id.text.Equals(string.Empty) || pw.text.Equals(string.Empty))
        {
            status.text = "���̵� ��й�ȣ�� �Է��� �ּ���.";
            return;
        }

        if (SQLControll.instance.Login(id.text, pw.text))
        {
            // �α��� ����
            UserInfo2 info = SQLControll.instance.info;
            Debug.Log(info.U_Name + " | " + info.U_Password);
            gameObject.SetActive(false);
            testInfo.gameObject.SetActive(true);
            testInfo.SetInfo();
        }
        else
        {
            // �α��� ����
            SQLControll.instance.SignUp(id.text, pw.text);
            status.text = "������ �����߽��ϴ�.";
            return;
        }
    }
}
