using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SaveData
{
    public int money, dia, jelly, maxJelly;

    public string prevCraftTime; 

    public List<CookieInfo> allCookies;
    public List<BuildingInfo> ownedBuildings;


    public SaveData()
    {
        // ó�� �ϸ� �־����� ��ȭ�� ��������
        money = 0;
        dia = 0;
        maxJelly = 40;
        jelly = maxJelly;

        prevCraftTime = DateTime.Now.ToString("yyyyMMddHHmmss");

        allCookies = new List<CookieInfo>();
        ownedBuildings = new List<BuildingInfo>();

        // ó���ϸ� �־����� ��Ű��� �ǹ����� ��������
        // ó���ϸ� �־����� ��Ű��
        // 0 : �밨�� ��Ű
        // 1 : ����� ��Ű
        // 2 : ������� ��Ű
        // 6 : ĥ���� ��Ű
        // 8 : Ŀ���͵� 3���� ��Ű

        for(int i = 0; i < 10; i++)
        {
            allCookies.Add(new CookieInfo(i, false, false));
        }

        allCookies[0] = new CookieInfo(0, true, true);
        allCookies[1] = new CookieInfo(1, true, true);
        allCookies[2] = new CookieInfo(2, true, true);
        allCookies[6] = new CookieInfo(6, true, true);
        allCookies[8] = new CookieInfo(8, true, true);


        // ó���ϸ� �־����� �ǹ���
        // 0 : �������� ��
        // 1 : ������ ����
        // 2 : ������ ä����
        ownedBuildings.Add(new BuildingInfo(0, 4));
        ownedBuildings.Add(new BuildingInfo(1, 4));
        ownedBuildings.Add(new BuildingInfo(2, 4));
    }
}

[System.Serializable]
public class CookieInfo
{
    // ��Ű�� �ε���
    public int cookieIndex;
    
    // �ɷ�ġ
    public int cookieLevel;
    public int skillLevel;
    public int evolutionCount;
    public int evolutionGauge;
    public int evolutionMaxGauge;

    // ����
    public Vector3 lastKingdomPosition;
    public int battlePosition;
    public bool isBattleMember;
    public bool isHave;

    public CookieInfo(int cookieIndex, bool isBattleMember, bool isHave)
    {
        this.cookieIndex = cookieIndex;
        this.isBattleMember = isBattleMember;
        this.isHave = isHave;

        battlePosition = -1;

        cookieLevel = 1;
        skillLevel = 1;
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

    // ��ġ�� �Ǿ��°�?
    public bool isInstall;

    // ��ġ�� ���
    public Vector3 installationPosition;

    // ���������� Ȯ�ε� ���۽ð�
    public string lastTime;

    public BuildingInfo(int buildingIndex, int slotCount)
    {
        this.buildingIndex = buildingIndex;
        this.slotCount = slotCount;

        this.installationPosition = Vector3.zero;
        this.isInstall = false;
        this.cookieWorkerIndex = -1;
        this.craftingItemData = new List<CraftingItemData>();
        for(int i = 0; i < slotCount; i++)
        {
            this.craftingItemData.Add(new CraftingItemData(ECraftingState.empty, null));
        }
    }
}