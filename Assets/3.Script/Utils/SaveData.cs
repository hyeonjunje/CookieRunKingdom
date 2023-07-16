using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SaveData
{
    // ��ȭ
    public int money, dia, jelly, maxJelly;

    // ���۽ð�
    public string prevCraftTime; 

    public List<CookieInfo> allCookies;
    public List<BuildingInfo> ownedCraftableBuildings;

    public SaveData()
    {
        // ó�� �ϸ� �־����� ��ȭ�� ��������
        money = 0;
        dia = 0;
        maxJelly = 40;
        jelly = maxJelly;

        prevCraftTime = DateTime.Now.ToString("yyyyMMddHHmmss");

        allCookies = new List<CookieInfo>();
        ownedCraftableBuildings = new List<BuildingInfo>();

        // ó���ϸ� �־����� ��Ű��� �ǹ����� ��������
        // ó���ϸ� �־����� ��Ű��
        // 0 : �밨�� ��Ű
        // 1 : ����� ��Ű
        // 2 : ������� ��Ű
        // 6 : ĥ���� ��Ű
        // 8 : Ŀ���͵� 3���� ��Ű

        for (int i = 0; i < 10; i++)
        {
            allCookies.Add(new CookieInfo(i, false, false));
        }

        allCookies[0] = new CookieInfo(0, true, true, 0);
        allCookies[1] = new CookieInfo(1, true, true, 1);
        allCookies[2] = new CookieInfo(2, true, true, 3);
        allCookies[6] = new CookieInfo(6, true, true, 4);
        allCookies[8] = new CookieInfo(8, true, true, 8);


        // ó���ϸ� �־����� �ǹ���
        // 0 : �������� ��
        // 1 : ������ ����
        // 2 : ������ ä����
        ownedCraftableBuildings.Add(new BuildingInfo(0, 4, true));
        ownedCraftableBuildings.Add(new BuildingInfo(1, 4, true));
        ownedCraftableBuildings.Add(new BuildingInfo(2, 4, true));

        for(int i = 3; i <= 19; i++)
        {
            ownedCraftableBuildings.Add(new BuildingInfo(i, 4, true));
        }


        // ó���ϸ� �־����� �ǹ���
        ownedCraftableBuildings.Add(new BuildingInfo(20, 0, true));  // ��Ű�Ͽ콺
    }
}

[System.Serializable]
public class CookieInfo
{
    // ��Ű�� �ε���
    public int cookieIndex;
    
    // �ɷ�ġ
    public int cookieLevel;
    public int evolutionCount;
    public int evolutionGauge;
    public int evolutionMaxGauge;

    // ����
    public Vector3 lastKingdomPosition;
    public int battlePosition;
    public bool isBattleMember;
    public bool isHave;

    public CookieInfo(int cookieIndex, bool isBattleMember, bool isHave, int battlePosition = -1)
    {
        this.cookieIndex = cookieIndex;
        this.isBattleMember = isBattleMember;
        this.isHave = isHave;
        this.battlePosition = battlePosition;

        cookieLevel = 1;
        evolutionCount = 0;
        evolutionGauge = 0;
        evolutionMaxGauge = 20;
    }
}

/// <summary>
/// dateTime <-> string
/// https://boxwitch.tistory.com/entry/%EC%9C%A0%EB%8B%88%ED%8B%B0%EC%97%90%EC%84%9C-DateTime-%EC%8B%9C%EA%B0%84%EC%9D%84-string%EC%9C%BC%EB%A1%9C-%EB%B3%80%ED%99%98-%EB%B9%84%EA%B5%90
/// </summary>
[System.Serializable]
public class BuildingInfo
{
    // �ǹ� �ε���
    public int buildingIndex;

    // ���� ���� ����
    public int slotCount;

    // ���� ��Ȳ
    public List<CraftingItemData> craftingItemData = new List<CraftingItemData>();

    // ���ϴ� ��Ű�� �ε���
    public int cookieWorkerIndex;

    // ������ �� �ִ°�?
    public bool isCraftable;

    // ��ġ�� �Ǿ��°�?
    public bool isInstall;

    // ��ġ�� ���
    public Vector3 installationPosition;

    // ���������� Ȯ�ε� ���۽ð�
    public string lastTime;

    public bool isFlip;

    public BuildingInfo(int buildingIndex, int slotCount, bool isCraftable)
    {
        this.buildingIndex = buildingIndex;
        this.slotCount = slotCount;
        this.isCraftable = isCraftable;

        this.installationPosition = Vector3.zero;
        this.isInstall = false;
        this.cookieWorkerIndex = -1;
        this.craftingItemData = new List<CraftingItemData>();
        this.isFlip = false;
        for (int i = 0; i < slotCount; i++)
        {
            this.craftingItemData.Add(new CraftingItemData(ECraftingState.empty, null));
        }
    }
}
