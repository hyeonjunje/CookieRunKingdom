using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EKingdomState
{
    Manage,
    Edit,
    Craft,
    Play,
    Adventure,
    Statue,
    DailyDungeon,
    WishTree,
    TrainStation,
    AirBalloon,
}

public class KingdomStateFactory
{
    private Dictionary<EKingdomState, KingdomBaseState> _dictionary = new Dictionary<EKingdomState, KingdomBaseState>();

    public KingdomBaseState CurrentKingdomState { get; private set; }

    public KingdomManageState kingdomManageState { get; private set; }
    public KingdomEditState kingdomEditState { get; private set; }
    public KingdomCraftState kingdomCraftState { get; private set; }
    public KingdomPlayState kingdomPlayState { get; private set; }

    public KingdomAdventureState kingdomAdventureState { get; private set; }
    public KingdomStatueState kingdomStatueState { get; private set; }
    public KingdomDailyDungeonState kingdomDailyDungeonState { get; private set; }
    public KingdomWishTreeState kingdomWishTreeState { get; private set; }
    public KingdomTrainStationState kingdomTrainStationState { get; private set; }
    public KingdomHotAirBalloonState kingdomHotAirBalloonState { get; private set; }

    public KingdomStateFactory(KingdomManager kingdomManager)
    {
        kingdomManageState = new KingdomManageState(this, kingdomManager);
        kingdomEditState = new KingdomEditState(this, kingdomManager);
        kingdomCraftState = new KingdomCraftState(this, kingdomManager);
        kingdomPlayState = new KingdomPlayState(this, kingdomManager);

        kingdomAdventureState = new KingdomAdventureState(this, kingdomManager);
        kingdomStatueState = new KingdomStatueState(this, kingdomManager);
        kingdomDailyDungeonState = new KingdomDailyDungeonState(this, kingdomManager);
        kingdomWishTreeState = new KingdomWishTreeState(this, kingdomManager);
        kingdomTrainStationState = new KingdomTrainStationState(this, kingdomManager);
        kingdomHotAirBalloonState = new KingdomHotAirBalloonState(this, kingdomManager);


        _dictionary[EKingdomState.Manage] = kingdomManageState;
        _dictionary[EKingdomState.Edit] = kingdomEditState;
        _dictionary[EKingdomState.Craft] = kingdomCraftState;
        _dictionary[EKingdomState.Play] = kingdomPlayState;

        _dictionary[EKingdomState.Adventure] = kingdomAdventureState;
        _dictionary[EKingdomState.Statue] = kingdomStatueState;
        _dictionary[EKingdomState.DailyDungeon] = kingdomDailyDungeonState;
        _dictionary[EKingdomState.WishTree] = kingdomWishTreeState;
        _dictionary[EKingdomState.TrainStation] = kingdomTrainStationState;
        _dictionary[EKingdomState.AirBalloon] = kingdomHotAirBalloonState;

        // 처음에는 관리 상태로 초기화
        ChangeState(EKingdomState.Manage);
    }

    public void ChangeState(EKingdomState newState)
    {
        if(!_dictionary.ContainsKey(newState))
        {
            Debug.LogError("그런 상태는 없습니다!!!");
            return;
        }

        if(CurrentKingdomState != null)
        {
            if(_dictionary[newState].Equals(CurrentKingdomState))
            {
                Debug.LogError("같은 상태입니다");
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
