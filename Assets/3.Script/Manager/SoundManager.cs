using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EBGM
{
    battle,
    bossBattle,
    defeatBattle,
    gacha,
    lobby,
    mainTitle,
    readyBattle,
    start,
    victoryBattle
}

public class SoundManager
{
    private Dictionary<EBGM, AudioClip> _clipDictionary = new Dictionary<EBGM, AudioClip>();

    private AudioSource _audio = null;
    public float bgmVolume = 0.5f;

    public void Init()
    {
        // 오디오 소스 만들어넣기
        // 클립준비해놓기
        
        if(_audio == null)
        {
            GameObject go = new GameObject(typeof(SoundManager).Name);
            go.transform.parent = GameManager.Instance.transform;
            _audio = go.AddComponent<AudioSource>();
            _audio.loop = true;
        }

        _audio.volume = bgmVolume;

        _clipDictionary = new Dictionary<EBGM, AudioClip>();

        _clipDictionary[EBGM.battle] = Resources.Load<AudioClip>("Audio/CKBGM-Battle");
        _clipDictionary[EBGM.bossBattle] = Resources.Load<AudioClip>("Audio/CKBGM-BossBattle");
        _clipDictionary[EBGM.defeatBattle] = Resources.Load<AudioClip>("Audio/CKBGM-DefeatBattle");
        _clipDictionary[EBGM.gacha] = Resources.Load<AudioClip>("Audio/CKBGM-Gacha");
        _clipDictionary[EBGM.lobby] = Resources.Load<AudioClip>("Audio/CKBGM-Lobby");
        _clipDictionary[EBGM.mainTitle] = Resources.Load<AudioClip>("Audio/CKBGM-MainTitle");
        _clipDictionary[EBGM.readyBattle] = Resources.Load<AudioClip>("Audio/CKBGM-ReadyBattle");
        _clipDictionary[EBGM.start] = Resources.Load<AudioClip>("Audio/CKBGM-Start");
        _clipDictionary[EBGM.victoryBattle] = Resources.Load<AudioClip>("Audio/CKBGM-VictoryBattle");
    }

    public void PlayBgm(EBGM bgm)
    {
        if(!_clipDictionary.ContainsKey(bgm))
        {
            Debug.Log("없는 키 입니다. " + bgm);
            return;
        }

        _audio.loop = true;
        StopBgm();
        _audio.clip = _clipDictionary[bgm];
        _audio.Play();
    }

    public void PlaySe(EBGM bgm)
    {
        if (!_clipDictionary.ContainsKey(bgm))
        {
            Debug.Log("없는 키 입니다. " + bgm);
            return;
        }

        _audio.loop = false;
        StopBgm();
        _audio.clip = _clipDictionary[bgm];
        _audio.Play();

    }

    public void StopBgm()
    {
        _audio.Stop();
    }
}
