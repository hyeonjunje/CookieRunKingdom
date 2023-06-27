using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomAdventureUI : BaseUI
{
    [SerializeField] private GameObject _cookigKingdom;
    [SerializeField] private GameObject _world1;

    public override void Show()
    {
        base.Show();

        _cookigKingdom.SetActive(false);
        _world1.SetActive(true);
        // 월드 보이게
    }

    public override void Hide()
    {
        // 월드 안 보이게
        _cookigKingdom.SetActive(true);
        _world1.SetActive(false);

        base.Hide();
    }
}
