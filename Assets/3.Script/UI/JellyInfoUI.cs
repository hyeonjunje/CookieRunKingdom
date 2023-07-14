using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class JellyInfoUI : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI _jellyText;
    [SerializeField] private TextMeshProUGUI _jellTimeText;

    private Coroutine _coUpdate;

    private void OnDisable()
    {
        GameManager.Game.prevJellyTime = System.DateTime.Now;

        if (_coUpdate != null)
            StopCoroutine(_coUpdate);
    }

    private void OnEnable()
    {
        int diffTime = (int)((System.DateTime.Now - GameManager.Game.prevJellyTime).TotalSeconds);

        if(diffTime >= GameManager.Game.jellyTime)
        {
            diffTime -= GameManager.Game.jellyTime;
            int count = diffTime / Utils.JellyTime;
            GameManager.Game.Jelly += 1 + count;
            GameManager.Game.jellyTime = diffTime % Utils.JellyTime;
        }
        else
        {
            GameManager.Game.jellyTime -= diffTime;
        }
        OnChangeJelly();
    }

    public void OnChangeJelly()
    {
        _jellTimeText.gameObject.SetActive(false);

        if (GameManager.Game.Jelly < GameManager.Game.MaxJelly)
        {
            if (_coUpdate != null)
                StopCoroutine(_coUpdate);
            _coUpdate = StartCoroutine(CoUpdate());
        }
    }


    private IEnumerator CoUpdate()
    {
        _jellTimeText.gameObject.SetActive(true);
        WaitForSeconds wait = new WaitForSeconds(1f);

        while(true)
        {
            _jellTimeText.text = Utils.GetTimeText(GameManager.Game.jellyTime, false);
            yield return wait;
            GameManager.Game.jellyTime--;

            if (GameManager.Game.jellyTime <= 0)
            {
                GameManager.Game.Jelly++;
                GameManager.Game.jellyTime = Utils.JellyTime;
                if (GameManager.Game.Jelly >= GameManager.Game.MaxJelly)
                {
                    _jellTimeText.gameObject.SetActive(false);
                    break;
                }
            }
        }
    }
}
