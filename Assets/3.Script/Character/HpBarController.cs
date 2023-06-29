using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HpBarController : MonoBehaviour
{
    [SerializeField] private Slider playerHpBarPrefab;
    [SerializeField] private Slider enemyHpBarPrefab;

    [SerializeField] private int playerHpBarCount = 5;
    [SerializeField] private int enemyHpBarCount = 20;

    private Queue<Slider> playerHpBarQueue = new Queue<Slider>();
    private Queue<Slider> enemyHpBarQueue = new Queue<Slider>();


    private void Awake()
    {
        Init();
    }

    private void Init()
    {
        for(int i = 0; i < playerHpBarCount; i++)
        {
            Slider slider = Instantiate(playerHpBarPrefab, transform);
            slider.gameObject.SetActive(false);
            playerHpBarQueue.Enqueue(slider);

            slider.GetComponent<ObjectPoolingObject>().onDisable += () => ReturnToQueue(slider, true);
        }

        for(int i = 0; i < enemyHpBarCount; i++)
        {
            Slider slider = Instantiate(enemyHpBarPrefab, transform);
            slider.gameObject.SetActive(false);
            enemyHpBarQueue.Enqueue(slider);

            slider.GetComponent<ObjectPoolingObject>().onDisable += () => ReturnToQueue(slider, false);
        }
    }


    /// <summary>
    /// �÷��̾ ������ �θ��� hp�ٸ� ��ȯ�ϴ� �޼ҵ�
    /// </summary>
    /// <param name="isPlayer">�÷��̾�� true, �ƴϸ� false</param>
    /// <returns></returns>
    public Slider GetHpBar(bool isPlayer = true)
    {
        Slider slider = null;

        if(isPlayer)
            slider = playerHpBarQueue.Dequeue();
        else
            slider = enemyHpBarQueue.Dequeue();

        slider.gameObject.SetActive(true);

        return slider;
    }

    public void ReturnToQueue(Slider slider, bool isPlayer = true)
    {
        if(isPlayer)
            playerHpBarQueue.Enqueue(slider);
        else
            enemyHpBarQueue.Enqueue(slider);

        slider.gameObject.SetActive(false);
    }
}
