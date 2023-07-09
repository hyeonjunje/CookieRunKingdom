using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SaveData
{
    public int money, dia, jelly, maxJelly;

    public string prevCraftTime; 

    public List<CookieInfo> ownedCookies;
    public List<BuildingInfo> ownedBuildings;


    public SaveData()
    {
        // 처음 하면 주어지는 재화를 정해주자
        money = 0;
        dia = 0;
        maxJelly = 40;
        jelly = maxJelly;

        prevCraftTime = DateTime.Now.ToString("yyyyMMddHHmmss");

        ownedCookies = new List<CookieInfo>();
        ownedBuildings = new List<BuildingInfo>();

        // 처음하면 주어지는 쿠키들과 건물들은 정해주자
        // 처음하면 주어지는 쿠키는
        // 0 : 용감한 쿠키
        // 1 : 딸기맛 쿠키
        // 2 : 마법사맛 쿠키
        // 6 : 칠리맛 쿠키
        // 8 : 커스터드 3세맛 쿠키
        ownedCookies.Add(new CookieInfo(0, 1, 1, 0, true));
        ownedCookies.Add(new CookieInfo(1, 1, 1, 0, true));
        ownedCookies.Add(new CookieInfo(2, 1, 1, 0, true));
        ownedCookies.Add(new CookieInfo(6, 1, 1, 0, true));
        ownedCookies.Add(new CookieInfo(8, 1, 1, 0, true));

        // 처음하면 주어지는 건물은
        // 0 : 나무꾼의 집
        // 1 : 젤리빈 농장
        // 2 : 각설탕 채석장
        ownedBuildings.Add(new BuildingInfo(0, 4));
        ownedBuildings.Add(new BuildingInfo(1, 4));
        ownedBuildings.Add(new BuildingInfo(2, 4));
    }
}

[System.Serializable]
public class CookieInfo
{
    // 쿠키의 인덱스
    public int cookieIndex;
    
    // 능력치
    public int cookieLevel;
    public int skillLevel;
    public int evolutionCount;

    // 상태
    public Vector3 lastKingdomPosition;
    public bool isBattleMember;

    public CookieInfo(int cookieIndex, int cookieLevel, int skillLevel, int evolutionCount, bool isBattleMember)
    {
        this.cookieIndex = cookieIndex;
        this.cookieLevel = cookieLevel;
        this.skillLevel = skillLevel;
        this.evolutionCount = evolutionCount;
        this.isBattleMember = isBattleMember;
    }
}

/// <summary>
/// dateTime <-> string
/// https://boxwitch.tistory.com/entry/%EC%9C%A0%EB%8B%88%ED%8B%B0%EC%97%90%EC%84%9C-DateTime-%EC%8B%9C%EA%B0%84%EC%9D%84-string%EC%9C%BC%EB%A1%9C-%EB%B3%80%ED%99%98-%EB%B9%84%EA%B5%90
/// </summary>
[System.Serializable]
public class BuildingInfo
{
    // 건물 인덱스
    public int buildingIndex;

    // 제작 슬롯 개수
    public int slotCount;

    // 제작 현황
    public List<CraftingItemData> craftingItemData = new List<CraftingItemData>();

    // 일하는 쿠키의 인덱스
    public int cookieWorkerIndex;

    // 설치가 되었는가?
    public bool isInstall;

    // 설치된 장소
    public Vector3 installationPosition;

    // 마지막으로 확인된 제작시간
    public string lastTime;

    public BuildingInfo(int buildingIndex, int slotCount)
    {
        this.buildingIndex = buildingIndex;
        this.slotCount = slotCount;

        this.installationPosition = Vector3.zero;
        this.isInstall = false;
        this.cookieWorkerIndex = -1;
        this.craftingItemData = new List<CraftingItemData>(slotCount);
    }
}