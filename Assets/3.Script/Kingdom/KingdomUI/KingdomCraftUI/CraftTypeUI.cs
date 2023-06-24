using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CraftTypeUI : MonoBehaviour
{
    [SerializeField] private Image craftItemImage;
    [SerializeField] private TextMeshProUGUI craftItemName;
    [SerializeField] private TextMeshProUGUI craftTime;

    public virtual void Init(CraftData craftData)
    {
        craftItemImage.sprite = craftData.CraftImage;
        craftItemName.text = craftData.CraftName;

        craftTime.text = GetTimeText(craftData.CraftTime);
    }

    private string GetTimeText(float time)
    {
        float hour = (int)time / 3600;
        time %= 3600;
        float min = (int)time / 60;
        time %= 60;
        float sec = time;

        string result = "";

        if (hour != 0)
            result += hour + "시간 ";
        if (min != 0)
            result += min + "분 ";

        result += sec + "초";

        return result;
    }
}
