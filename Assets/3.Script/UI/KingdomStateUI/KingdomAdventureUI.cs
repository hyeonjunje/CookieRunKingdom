using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class KingdomAdventureUI : BaseUI
{
    [Header("Text")]
    [SerializeField] private TextMeshProUGUI _diaText;
    [SerializeField] private TextMeshProUGUI _moneyText;
    [SerializeField] private TextMeshProUGUI _jellyText;


    [SerializeField] private GameObject _cookigKingdom;
    [SerializeField] private GameObject _world1;

    public override void Init()
    {
        base.Init();

        GameManager.Game.OnChangeDia += (() => _diaText.text = GameManager.Game.Dia.ToString("#,##0"));
        GameManager.Game.OnChangeMoney += (() => _moneyText.text = GameManager.Game.Money.ToString("#,##0"));
        GameManager.Game.OnChangeJelly += (() => _jellyText.text = GameManager.Game.Jelly + "/" + GameManager.Game.MaxJelly);
    }

    public override void Show()
    {
        base.Show();

        _cookigKingdom.SetActive(false);
        _world1.SetActive(true);
        // 월드 보이게

        GameManager.Game.UpdateGoods();
    }

    public override void Hide()
    {
        // 월드 안 보이게
        _cookigKingdom.SetActive(true);
        _world1.SetActive(false);

        base.Hide();
    }
}
