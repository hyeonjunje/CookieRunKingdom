using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingCircleEditUIInPreview : BuildingCircleEditUI
{
    public override void SetPrevBuilding(BuildingController currentBuilding)
    {
        // ���� �ǹ� �����·� ������
        if (_currentBuilding != null && _currentBuilding != currentBuilding)
        {
            ExitUI();
        }
    }

    public override void SetBuilding(BuildingController currentBuilding, Transform parent, float cameraOrthographicSize = 10)
    {
        base.SetBuilding(currentBuilding, parent, cameraOrthographicSize);
    }

    public override void HideUI()
    {
        base.HideUI();
    }

    public override void ShowInfo()
    {
        base.ShowInfo();
    }

    public override void StoreBuilding()
    {
        base.StoreBuilding();
    }

    public override void CheckBuilding()
    {
        if (_currentBuilding.BuildingEditor.IsInstallable())
        {
            GameManager.Game.EnvironmentScore += _currentBuilding.Data.BuildingScore;
            onUnInstallBuilding?.Invoke();

            _kingdomManager.buildingsInKingdom.Add(_currentBuilding);

            _currentBuilding.BuildingEditor.IsInstance = true;

            _originPos = _currentBuilding.transform.position;
            _currentBuilding.BuildingEditor.PutBuilding();

            BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
            _buttonsParent.SetActive(false);

            _currentBuilding.BuildingAnimator.FlipX(_currentFlip);
            _currentBuilding.BuildingEditor.IsFlip = _currentFlip;

            _currentBuilding.BuildingEditor.OnInstallEffect();
            _currentBuilding = null;
        }
        else
        {
            GuideDisplayer.Instance.ShowGuide("�̰��� ��ġ�� �� �����ϴ�.");
        }
    }

    public override void ExitUI()
    {
        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        _buttonsParent.SetActive(false);
        transform.SetParent(null);
        _currentBuilding.gameObject.SetActive(false);
        _kingdomEditUI.AddBuilding(_currentBuilding);
        _currentBuilding = null;
    }

    public override void RotateBuilding()
    {
        base.RotateBuilding();
    }

    public override void SellBuilding()
    {
        GuideDisplayer.Instance.ShowGuide("������ ���� ������ ��� �Ⱦƿ�!");
    }
}
