using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieBattleAward : MonoBehaviour
{
    [SerializeField] private Transform _hpBarController;
    [SerializeField] private Transform _pivotTransform;
    [SerializeField] private float _margin;

    public void ShowResult()
    {
        _hpBarController.DestroyAllChild();

        List<CookieController> cookies = BattleManager.instance.CookieInStartList;

        SetPosition(cookies);

        foreach (BaseController cookie in cookies)
        {
            cookie.CharacterAnimator.SettingOrderLayer(true);

            if(cookie.CharacterBattleController.IsDead)
            {
                cookie.gameObject.SetActive(true);
                cookie.CharacterAnimator.PlayAnimation("lose");
            }
            else
            {
                cookie.CharacterAnimator.PlayAnimation("joy");
            }
        }
    }

    private void SetPosition(List<CookieController> cookies)
    {
        Vector3 startPoint = Vector3.zero;

        if (cookies.Count % 2 == 1)
            startPoint = _pivotTransform.localPosition - Vector3.right * (cookies.Count / 2) * _margin;
        else
            startPoint = _pivotTransform.localPosition - Vector3.right * (cookies.Count / 2 - 0.5f) * _margin;

        for (int i = 0; i < cookies.Count; i++)
        {
            Transform pos = new GameObject("pos" + (i + 1)).transform;
            pos.SetParent(transform);
            pos.localPosition = startPoint + Vector3.right * _margin * i;
            pos.localScale = Vector3.one * 100f;
            cookies[i].transform.SetParent(pos);
        }

        for(int i = 0; i < cookies.Count; i++)
        {
            cookies[i].transform.localPosition = Vector3.zero;
            cookies[i].transform.localScale = Vector3.one;
        }
    }
}
