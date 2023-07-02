using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

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
