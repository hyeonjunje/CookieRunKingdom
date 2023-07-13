using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Spine.Unity;

public class StageManager : MonoBehaviour
{
    [SerializeField] private StageData[] _stageData;
    [SerializeField] private Transform[] _stagePoses;
    [SerializeField] private StageButtonUI _stageButtonPrefab;

    [SerializeField] private Transform _buttonParent;

    [SerializeField] private StageSelectUI _stageSelectUI;

    private void Awake()
    {
        // ���� UI�� Show�� �� �ؾ���
        Init();
    }

    public void Init()
    {
        _buttonParent.DestroyAllChild();

        for(int i = 0; i < _stageData.Length; i++)
        {
            StageButtonUI stageButton = Instantiate(_stageButtonPrefab, _buttonParent);
            stageButton.transform.position = _stagePoses[i].position;

            stageButton.Init(_stageData[i], 0);
            int index = i;
            stageButton.GetComponent<Button>().onClick.AddListener(() => OnClickStageButton(_stageData[index], stageButton.transform.position));

            if(_stageData[i].IsBoss)
            {
                SkeletonAnimation animation = Instantiate(_stageData[i].BossSkeletonAnimation, _stagePoses[i]);
                animation.transform.localPosition = Vector3.zero;
                animation.Initialize(true);
                animation.AnimationState.SetAnimation(0, "battle_idle", true);

                Renderer renderer = animation.GetComponent<Renderer>();
                renderer.sortingLayerName = "GridLower";
                renderer.sortingOrder = -100;
            }
        }
    }

    private void OnClickStageButton(StageData stageData, Vector3 touchPos)
    {
        // ī�޶� �̵�
        // ��Ű �̵�

        _stageSelectUI.InitStageData(stageData, touchPos, 0);
        GameManager.UI.ShowPopUpUI(_stageSelectUI);
    }
}
