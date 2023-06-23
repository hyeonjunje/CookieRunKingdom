using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomManager : MonoBehaviour
{
    private KingdomStateFactory _factory;

    [SerializeField] private GameObject _kingdomManagerUI;
    [SerializeField] private GameObject _kingdomEditUI;

    public GameObject KingdomManagerUI => _kingdomManagerUI;
    public GameObject KingdomEditUI => _kingdomEditUI;

    private void Awake()
    {
        _factory = new KingdomStateFactory(this);
    }

    private void Update()
    {
        _factory.CurrentKingdomState.Update();
    }

    #region 버튼에 넣을 메소드들!!
    public void ChangeState(int index)
    {
        _factory.ChangeState((EKingdomState)index);
    }
    #endregion
}
