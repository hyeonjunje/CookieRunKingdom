using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingCircleEditUIInPreview : BuildingCircleEditUI
{
    public override void SetPrevBuilding(BuildingController currentBuilding)
    {
        // 이전 건물 원상태로 돌리기
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
            GuideDisplayer.Instance.ShowGuide("이곳엔 설치할 수 없습니다.");
        }
    }

    public override void ExitUI()
    {
        Debug.Log("이거 해요??");

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
        GuideDisplayer.Instance.ShowGuide("사지도 않은 물건을 어떻게 팔아요!");
    }
}
