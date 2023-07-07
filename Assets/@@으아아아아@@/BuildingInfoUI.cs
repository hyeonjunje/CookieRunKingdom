using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class BuildingInfoUI : BaseUI
{
    [Header("UI")]
    [SerializeField] private TextMeshProUGUI _buildingNameText;
    [SerializeField] private TextMeshProUGUI _buildingSizeText;
    [SerializeField] private TextMeshProUGUI _buildingScoreText;
    [SerializeField] private TextMeshProUGUI _buildingExplain;
    [SerializeField] private Button _okayButton;

    [Header("Transform")]
    [SerializeField] private Transform _buildingParent;

    private BuildingController _building;

    public void SetBuilding(BuildingController building)
    {
        _building = building;
    }

    public override void Hide()
    {
        base.Hide();
    }

    public override void Init()
    {
        base.Init();

        _okayButton.onClick.AddListener(() => GameManager.UI.ExitPopUpUI());
    }

    public override void Show()
    {
        base.Show();

        _buildingParent.DestroyAllChild();

        _buildingNameText.text = _building.Data.BuildingName;
        _buildingSizeText.text = _building.Data.BuildingSize.x + "X" + _building.Data.BuildingSize.y;
        _buildingScoreText.text = _building.Data.BuildingScore.ToString();
        _buildingExplain.text = _building.Data.BuildingExplain;

        BuildingController building = Instantiate(_building, _buildingParent);
        building.transform.localPosition = Vector3.zero;
        building.transform.localScale = Vector3.one;
    }
}
