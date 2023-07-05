using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomScene : BaseScene
{
    [SerializeField] private KingdomManager _kingdomManager;
    [SerializeField] private List<BaseController> _myCookies = new List<BaseController>();

    protected override void Init()
    {
        // �ձ� ��ġ

        // ��Ű ����
        ArrangeCookies();


        // �ձ� ��������
        _kingdomManager.Init();
    }

    private void ArrangeCookies()
    {
        List<BaseController> myCookies = DataBaseManager.Instance.OwnedCookies;
        for(int i = 0; i < myCookies.Count; i++)
        {
            BaseController cookie = Instantiate(myCookies[i]);
            _myCookies.Add(cookie);
        }
    }
}
