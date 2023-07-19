using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class CookieBundle : MonoBehaviour
{
    /// <summary>
    /// 2 3 1  ����
    /// 5 6 4  �߾�
    /// 8 9 7  �Ĺ�
    /// </summary>
    [SerializeField] private Transform[] cookiePositions;

    private List<CookieController> Cookies => BattleManager.instance.CookieList;
    private Camera _camera;
    private Tweener _cameraTween;


    private void Update()
    {
        // ����ִ� ��Ű���� �� �ٴ� ���¶�� �̵��ϰ� �ƴϸ� 0
       float  currentSpeed = 0;

        for (int i = 0; i < Cookies.Count; i++)
        {
            if(!Cookies[i].CharacterBattleController.IsDead)
            {
                if(!Cookies[i].CharacterBattleController.CheckState(EBattleState.BattleRunState))
                    break;
                currentSpeed = Cookies[i].Data.MoveSpeed;
            }
        }

        if(currentSpeed == 0)
            _cameraTween.ChangeEndValue(5.0f, 1.5f, true).Restart();
        else
            _cameraTween.ChangeEndValue(6.5f, 1.5f, true).Restart();

        transform.position += Utils.Dir.normalized * currentSpeed * Time.deltaTime;
    }

    public void Init()
    {
        _camera = Camera.main;
        _cameraTween = _camera.DOOrthoSize(5.5f, 1.5f).SetAutoKill(false);

        for (int i= 0; i < Cookies.Count; i++)
            MovePosition(Cookies[i]);

        foreach (BaseController cookie in Cookies)
        {
            cookie.gameObject.layer = LayerMask.NameToLayer("Cookie");
            cookie.CharacterBattleController.StartBattle(true);
            cookie.CharacterBattleController.SetEnemy(LayerMask.NameToLayer("Enemy"));
        }
    }

    private void MovePosition(CookieController cookie)
    {
        int battlePosition = cookie.CookieStat.BattlePosition;

        cookie.transform.SetParent(cookiePositions[battlePosition]);
        cookie.transform.localPosition = Vector3.zero;
        cookie.transform.SetParent(null);
        cookie.CharacterBattleController.SetPosition(this, cookiePositions[battlePosition]);
    }
}
