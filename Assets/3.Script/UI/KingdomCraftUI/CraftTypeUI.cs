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

    [SerializeField] private Button craftButton;

    public virtual void Init(CraftData craftData, System.Action<CraftData> action = null)
    {
        craftItemImage.sprite = craftData.CraftImage;
        craftItemName.text = craftData.CraftName;

        craftTime.text = Utils.GetTimeText(craftData.CraftTime);

        craftButton.onClick.RemoveAllListeners();
        craftButton.onClick.AddListener(() => action?.Invoke(craftData));
    }
}
