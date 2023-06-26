using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KingdomInteractionBuilding : MonoBehaviour
{
    [SerializeField] private EKingdomState kingdomState;

    private KingdomManager _kingdomManager;

    private void Awake()
    {
        _kingdomManager = FindObjectOfType<KingdomManager>();
    }

    public void OnClickKingdomInteractionBuilding()
    {
        _kingdomManager.ChangeState(kingdomState);
    }
}
