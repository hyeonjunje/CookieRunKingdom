using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingWorker : MonoBehaviour
{
    private BuildingController _controller;

    [SerializeField] private List<CraftingItemData> _craftingItemData = new List<CraftingItemData>();
    [SerializeField] private GameObject _craftBubble;

    [Header("���� ��Ű ����")]
    [SerializeField] private Transform _workPlace;
    [SerializeField] private string _workAnimationName;

    // �ش� �ǹ��� �۾����ΰ�, �ƴѰ�?
    public bool isWorking = false;

    private List<SpriteRenderer> _craftBubbleUnit = new List<SpriteRenderer>();
    private BuildingData _data;
    private KingdomManager _kingdomManager;

    public CookieController Worker { get; private set; }
    public List<CraftingItemData> CraftingItemData => _craftingItemData;

    public void Init(BuildingController controller)
    {
        _controller = controller;

        _data = _controller.Data;

        for(int i = 0; i < _craftBubble.transform.childCount; i++)
        {
            _craftBubbleUnit.Add(_craftBubble.transform.GetChild(i).GetComponent<SpriteRenderer>());
        }

        _kingdomManager = FindObjectOfType<KingdomManager>();

        _controller.BuildingAnimator.PlayAnimation("off");
    }

    private void OnDisable()
    {
        StopAllCoroutines();
    }

    public void WorkBuilding()
    {
        StartCoroutine(CoSecond());
    }

    public void SelectedWorker()
    {
        if (Worker != null)
        {
            Worker.CharacterAnimator.PlayAnimation(_workAnimationName);
        }
    }

    public void Highlighgt(bool flag)
    {
        // �ƹ��� ��Ű ��ġ ��Ű��
        // ��Ű ���� �ִϸ��̼� �־��ֱ�

        if (Worker == null)
        {
            while(Worker == null)
            {
                CookieController cookie = _kingdomManager.myCookies[Random.Range(0, _kingdomManager.myCookies.Count)];
                if (!_kingdomManager.workingCookies.Contains(cookie))
                    Worker = cookie;
            }

            Worker.CookieCitizeon.GoToWork(_workPlace);
        }

        foreach (Renderer renderer in GetComponentsInChildren<Renderer>())
        {
            renderer.sortingLayerID = flag ?
            SortingLayer.NameToID("GridUpper") : SortingLayer.NameToID("Default");
        }
        Worker.CharacterAnimator.SettingOrderLayer(flag);
    }

    public void ChangeWorker(CookieController newWorker)
    {
        Worker.CookieCitizeon.LeaveWork();
        Worker = newWorker;
        Worker.CookieCitizeon.GoToWork(_workPlace);

        if (isWorking)
            Worker.CharacterAnimator.PlayAnimation(_workAnimationName);
    }

    /// <summary>
    /// ���۹� ��Ȯ�� �õ��ϴ� �޼ҵ�
    /// ��Ȯ�� �� ������ ��Ȯ�ϰ� true��ȯ
    /// ��Ȯ�� �� ������ �׳� false ��ȯ
    /// </summary>
    /// <returns>��Ȯ�� �� �ֳ�?</returns>
    public bool TryHarvest()
    {
        for (int i = 0; i < _craftingItemData.Count; i++)
        {
            if (_craftingItemData[i].state == ECraftingState.complete)
            {
                Harvest();
                return true;
            }
        }
        return false;
    }

    // ���������� ��Ȯ�ϴ� �޼ҵ�
    private void Harvest()
    {
        // ���� ���ٴϴ� ��Ȯ�� �� ���ֱ�
        _craftBubble.SetActive(false);
        foreach (SpriteRenderer sr in _craftBubbleUnit)
            sr.sprite = null;

        int count = 0;

        for (int i = 0; i < _craftingItemData.Count; i++)
        {
            if (_craftingItemData[i].state == ECraftingState.complete)
            {
                DataBaseManager.Instance.AddItem(_craftingItemData[i].craftData.CraftResult.ingredientItem, _craftingItemData[i].craftData.CraftResult.count);
                _craftingItemData[i].state = ECraftingState.empty;
            }
        }

        for (int i = 0; i < _craftingItemData.Count; i++)
        {
            if (_craftingItemData[i].state != ECraftingState.empty)
            {
                _craftingItemData[count++] = new CraftingItemData(_craftingItemData[i].state, _craftingItemData[i].craftData);
                _craftingItemData[i].state = ECraftingState.empty;
            }
        }

        // ���� �� ��Ȯ�ϸ� �ִϸ��̼� ���ֱ�
        if(_craftingItemData[0].state == ECraftingState.empty)
        {
            isWorking = false;
            Worker.CookieCitizeon.EndWork();
        }
    }

    private IEnumerator CoSecond()
    {
        WaitForSecondsRealtime second = new WaitForSecondsRealtime(1f);

        while (true)
        {
            yield return second;
            ManageCraftingItemData();
        }
    }

    private void ManageCraftingItemData()
    {
        for (int i = 0; i < _craftingItemData.Count; i++)
        {
            if (_craftingItemData[i].craftData == null)
                return;

            // ����� �ִٸ�
            if (_craftingItemData[i].state == ECraftingState.making)
            {
                // 1�ʾ� �����ش�.
                _craftingItemData[i].takingTime += 1;

                // ���� �� ������ٸ�
                if (_craftingItemData[i].takingTime >= _craftingItemData[i].craftData.CraftTime)
                {
                    // ����
                    _craftBubble.SetActive(true);
                    foreach (SpriteRenderer sr in _craftBubbleUnit)
                    {
                        if (sr.sprite == null)
                        {
                            sr.sprite = _craftingItemData[i].craftData.CraftImage;
                            break;
                        }
                    }

                    _craftingItemData[i].state = ECraftingState.complete;
                    if (i + 1 < _craftingItemData.Count && _craftingItemData[i + 1].craftData != null &&
                        _craftingItemData[i + 1].state == ECraftingState.waiting)
                    {
                        _craftingItemData[i + 1].state = ECraftingState.making;
                        return;
                    }
                }
            }
        }
    }


    /// <summary>
    /// �ٸ� ���³� ������ KingdomManageState�� ���ƿ� �� GameManagerEx�� PrevCraftTime�� ���� �ð��� ����ؼ�
    /// ����ǰ�� ������ �ֽ�ȭ�Ѵ�.
    /// </summary>
    public void UpdateCraftingItem()
    {
        int diffTime = (int)((System.DateTime.Now - GameManager.Game.PrevCraftTime).TotalSeconds);

        for (int i = 0; i < _craftingItemData.Count; i++)
        {
            if (_craftingItemData[i].craftData == null)
                return;

            // ����� �ִٸ�
            if (_craftingItemData[i].state == ECraftingState.making)
            {
                int remainTime = _craftingItemData[i].craftData.CraftTime - _craftingItemData[i].takingTime;

                // �ð��� ���̰� ����ǰ�� ���� �ð����� ������ ����ɷ� �Ѵ�.
                if(diffTime >= remainTime)
                {
                    diffTime -= remainTime;
                    _craftingItemData[i].state = ECraftingState.complete;

                    // ����
                    _craftBubble.SetActive(true);
                    foreach (SpriteRenderer sr in _craftBubbleUnit)
                    {
                        if (sr.sprite == null)
                        {
                            sr.sprite = _craftingItemData[i].craftData.CraftImage;
                            break;
                        }
                    }

                    if (i + 1 < _craftingItemData.Count && _craftingItemData[i + 1].craftData != null &&
                        _craftingItemData[i + 1].state == ECraftingState.waiting)
                    {
                        _craftingItemData[i + 1].state = ECraftingState.making;
                    }
                }
                else
                {
                    _craftingItemData[i].takingTime += diffTime;
                }
            }
        }
    }
}
