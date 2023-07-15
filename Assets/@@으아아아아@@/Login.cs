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
            status.text = "아이디 비밀번호를 입력해 주세요.";
            return;
        }

        if (SQLControll.instance.Login(id.text, pw.text))
        {
            // 로그인 성공
            UserInfo2 info = SQLControll.instance.info;
            Debug.Log(info.U_Name + " | " + info.U_Password);
            gameObject.SetActive(false);
            testInfo.gameObject.SetActive(true);
            testInfo.SetInfo();
        }
        else
        {
            // 로그인 실패
            status.text = "아이디 비밀번호를 확인해 주세요.";
            return;
        }
    }

    public void SignUpEvent()
    {
        if (id.text.Equals(string.Empty) || pw.text.Equals(string.Empty))
        {
            status.text = "아이디 비밀번호를 입력해 주세요.";
            return;
        }

        if (SQLControll.instance.Login(id.text, pw.text))
        {
            // 로그인 성공
            UserInfo2 info = SQLControll.instance.info;
            Debug.Log(info.U_Name + " | " + info.U_Password);
            gameObject.SetActive(false);
            testInfo.gameObject.SetActive(true);
            testInfo.SetInfo();
        }
        else
        {
            // 로그인 실패
            SQLControll.instance.SignUp(id.text, pw.text);
            status.text = "계정을 생성했습니다.";
            return;
        }
    }
}
