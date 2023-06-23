using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EKingdomState
{
    Manage,
    Edit
}

public class KingdomStateFactory
{
    private Dictionary<EKingdomState, KingdomBaseState> _dictionary = new Dictionary<EKingdomState, KingdomBaseState>();

    public KingdomBaseState CurrentKingdomState { get; private set; }

    public KingdomStateFactory(KingdomManager kingdomManager)
    {
        KingdomBaseState kingdomManageState = new KingdomManageState(this, kingdomManager);
        KingdomBaseState kingdomEditState = new KingdomEditState(this, kingdomManager);

        _dictionary[EKingdomState.Manage] = kingdomManageState;
        _dictionary[EKingdomState.Edit] = kingdomEditState;

        // ó������ ���� ���·� �ʱ�ȭ
        ChangeState(EKingdomState.Manage);
    }

    public void ChangeState(EKingdomState newState)
    {
        if(!_dictionary.ContainsKey(newState))
        {
            Debug.LogError("�׷� ���´� �����ϴ�.");
            return;
        }

        if(CurrentKingdomState != null)
        {
            if(_dictionary[newState].Equals(CurrentKingdomState))
            {
                Debug.LogError("���� �����Դϴ�");
                return;
            }
            else
            {
                CurrentKingdomState.Exit();
            }
        }

        CurrentKingdomState = _dictionary[newState];
        CurrentKingdomState.Enter();
    }
}
