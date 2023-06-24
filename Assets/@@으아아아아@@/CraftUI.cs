using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CraftUI : MonoBehaviour
{
    [Header("Right")]
    [SerializeField] private Transform craftTypeParent;
    [SerializeField] private CraftTypeUI craftTypePrefab;

    [Header("Left")]
    [SerializeField] private Transform craftItemParent;
    [SerializeField] private GameObject craftItemPrefab;

    [Header("Center")]
    [SerializeField] private TextMeshProUGUI buildingName;
    [SerializeField] private TextMeshProUGUI buildingLevel;
    [SerializeField] private Button levelUpButton;
    [SerializeField] private Button selectCookieButton;
    [SerializeField] private Button leftArrow;
    [SerializeField] private Button rightArrow;


    public void SetCraft(Building building)
    {
        buildingName.text = building.Data.BuildingName;

        craftTypeParent.DestroyAllChild();

        RectTransform parentTransform = craftTypeParent.GetComponent<RectTransform>();
        RectTransform craftTypePrefabTransform = craftTypePrefab.GetComponent<RectTransform>();
        /*parentTransform.sizeDelta = new Vector2(parentTransform.sizeDelta.x
            , (craftTypePrefabTransform.sizeDelta.y + 10) * building.Data.Items.Length);

        for(int i = 0; i < building.Data.Items.Length; i++)
        {
            CraftTypeUI craftTypeUI = Instantiate(craftTypePrefab, craftTypeParent);
            craftTypeUI.Init(building.Data.Items[i]);
        }*/
    }
}
