using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CookieStat : MonoBehaviour
{
    private int _cookieLevel;
    private int _skillLevel;
    private int _evolutionCount;
    private int _battlePosition;
    private bool _isBattleMember;
    private bool _isHave;

    private int _evolutionGauge;
    private int _evolutionMaxGague;


    private CookieController _controller;
    private CookieData _data;

    public int CookieLevel => _cookieLevel;
    public int SkillLevel => _skillLevel;
    public int EvolutionCount => _evolutionCount;
    public int BattlePosition => _battlePosition;
    public bool IsBattleMember => _isBattleMember;
    public bool IsHave => _isHave;
    public int EvolutionGauge => _evolutionGauge;
    public int EvolutionMaxGauge => _evolutionMaxGague;

    public void Init(CookieController controller)
    {
        _controller = controller;
        _data = ((CookieData)_controller.Data);
    }

    public void SetBattle(bool isBattle, int position)
    {
        _isBattleMember = isBattle;
        _battlePosition = position;
    }

    public void SaveCookie()
    {
        CookieInfo cookieInfo = GameManager.Game.allCookies[_data.CookieIndex];
        cookieInfo.cookieLevel = _cookieLevel;
        cookieInfo.skillLevel = _skillLevel;
        cookieInfo.evolutionCount = _evolutionCount;
        cookieInfo.battlePosition = _battlePosition;
        cookieInfo.isHave = _isHave;
        cookieInfo.isBattleMember = _isBattleMember;
        cookieInfo.evolutionGauge = _evolutionGauge;
        cookieInfo.evolutionMaxGauge = _evolutionMaxGague;
    }

    public void LoadCookie()
    {
        CookieInfo cookieInfo = GameManager.Game.allCookies[_data.CookieIndex];
        _cookieLevel = cookieInfo.cookieLevel;
        _skillLevel = cookieInfo.skillLevel;
        _evolutionCount = cookieInfo.evolutionCount;
        _battlePosition = cookieInfo.battlePosition;
        _isHave = cookieInfo.isHave;
        _isBattleMember = cookieInfo.isBattleMember;

        _evolutionGauge = cookieInfo.evolutionGauge;
        _evolutionMaxGague = cookieInfo.evolutionMaxGauge;

        for (int i = 1; i < _cookieLevel; i++)
            _controller.CharacterStat.LevelUP();

        for (int i = 1; i < _skillLevel; i++)
            _controller.CharacterStat.SkillLevelUp();

        for (int i = 0; i < _evolutionCount; i++)
            _controller.CharacterStat.Evolution();
    }

    public void LevelUp()
    {
        if(_cookieLevel < 60)
        {
            _cookieLevel++;
            _controller.CharacterStat.LevelUP();
        }
    }

    public void Evolution()
    {
        if(_evolutionCount < 5)
        {
            _evolutionCount++;
            _controller.CharacterStat.Evolution();
        }
    }

    public void SkillLevelUp()
    {
        if(_skillLevel < 60)
        {
            _skillLevel++;
            _controller.CharacterStat.SkillLevelUp();
        }
    }
}
