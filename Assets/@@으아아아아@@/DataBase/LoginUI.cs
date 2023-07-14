using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using DG.Tweening;

public class LoginUI : BaseUI
{
    // �α��� ������ �� ����� �Լ���
    public System.Action onSuccessLogin = null;

    [SerializeField] private TextMeshProUGUI _uiTitle;

    [SerializeField] private TMP_InputField _idField;
    [SerializeField] private TMP_InputField _pwField;

    [SerializeField] private Button _loginButton;
    [SerializeField] private Button _signUpButton;

    [SerializeField] private TextMeshProUGUI _loginButtonText;
    [SerializeField] private TextMeshProUGUI _signUpButtonnText;

    [SerializeField] private TextMeshProUGUI _statusText;

    private Sequence _seq;

    public override void Show()
    {
        base.Show();

        transform.localScale = Vector3.zero;
        transform.DOScale(Vector3.one, 0.5f).SetEase(Ease.OutBack);
    }

    public override void Hide()
    {
        transform.DOScaleY(0, 0.3f).SetEase(Ease.OutBack).OnComplete(base.Hide);
    }

    public override void Init()
    {
        base.Init();

        _uiTitle.text = "�α���";

        _statusText.gameObject.SetActive(false);
        _loginButton.onClick.AddListener(LoginEvent);
        _signUpButton.onClick.AddListener(SignUpEvent);

        _seq = DOTween.Sequence();
        _seq.Pause().SetAutoKill(false).Append(_statusText.transform.DOScale(Vector3.one, 0.2f))
            .SetEase(Ease.OutBack)
            .AppendInterval(0.3f)
            .Append(_statusText.transform.DOScale(Vector3.one, 0.2f))
            .OnComplete(() => _statusText.gameObject.SetActive(false));
    }

    // �α��� ��ư
    public void LoginEvent()
    {
        if(_idField.text.Equals(string.Empty) || _pwField.text.Equals(string.Empty))
        {
            ShowStatus("���̵� ��й�ȣ�� �Է��� �ּ���.");
        }
        else if(!GameManager.SQL.Login(_idField.text, _pwField.text))
        {
            ShowStatus("���̵� ��й�ȣ�� Ȯ���� �ּ���.");
        }
        else
        {
            GameManager.UI.ExitPopUpUI();
            // �α��� ����
            onSuccessLogin?.Invoke();
        }
    }

    // ȸ������ ��ư
    public void SignUpEvent()
    {
        _idField.text = "";
        _pwField.text = "";

        _loginButton.onClick.RemoveAllListeners();
        _signUpButton.onClick.RemoveAllListeners();

        _loginButton.onClick.AddListener(BackEvent);
        _signUpButton.onClick.AddListener(CreateAccount);

        _uiTitle.text = "ȸ������";
        _loginButtonText.text = "���ư���";
        _signUpButtonnText.text = "��������";
    }

    // ���� ���� ��ư
    public void CreateAccount()
    {
        if (_idField.text.Equals(string.Empty) || _pwField.text.Equals(string.Empty))
        {
            ShowStatus("���̵� ��й�ȣ�� �Է��� �ּ���.");
        }
        else if (!GameManager.SQL.Login(_idField.text, _pwField.text))
        {
            ShowStatus("�̹� �����ϴ� �����Դϴ�.");
        }
        else
        {
            ShowStatus("������ �����Ǿ����ϴ�.");
            BackEvent();
        }
    }

    // ���ư��� ��ư
    public void BackEvent()
    {
        _idField.text = "";
        _pwField.text = "";

        _loginButton.onClick.RemoveAllListeners();
        _signUpButton.onClick.RemoveAllListeners();

        _loginButton.onClick.AddListener(LoginEvent);
        _signUpButton.onClick.AddListener(SignUpEvent);

        _uiTitle.text = "�α���";
        _loginButtonText.text = "�α���";
        _signUpButtonnText.text = "ȸ������";
    }


    private void ShowStatus(string content)
    {
        _statusText.text = content;
        _statusText.gameObject.SetActive(true);
        _statusText.transform.localScale = Vector3.zero;
        _seq.Pause();
        _seq.Restart();
    }
}
