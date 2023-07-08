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
            _currentBuilding.BuildingEditor.IsInstance = true;

            _originPos = _currentBuilding.transform.position;
            _currentBuilding.BuildingEditor.PutBuilding();

            BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
            _buttonsParent.SetActive(false);

            _currentBuilding.BuildingAnimator.FlipX(_currentFlip);
            _currentBuilding.BuildingEditor.IsFlip = _currentFlip;

            _currentBuilding = null;
        }
        else
        {
            GuideDisplayer.Instance.ShowGuide("�̰��� ��ġ�� �� �����ϴ�.");
        }
    }

    public override void ExitUI()
    {
        Debug.Log("�̰� �ؿ�??");

        BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        _buttonsParent.SetActive(false);
        transform.SetParent(null);
        Destroy(_currentBuilding.gameObject);
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
