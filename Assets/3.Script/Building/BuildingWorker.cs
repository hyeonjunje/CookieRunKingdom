using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingWorker : MonoBehaviour
{
    protected BuildingController _controller;

    [SerializeField] private List<CraftingItemData> _craftingItemData = new List<CraftingItemData>();
    [SerializeField] private GameObject _craftBubble;

    [Header("���� ��Ű ����")]
    [SerializeField] private Transform _workPlace;
    [SerializeField] private string _workAnimationName;

    // �ش� �ǹ��� �۾����ΰ�, �ƴѰ�?
    public bool isWorking = false;

    // �ش� �ǹ��� ��ǥ �ǹ��ΰ�? ��ǥ�ǹ��̸� å������ GameManagerEX�� �ð��� ����ð����� ������Ʈ���ش�.
    public bool isRepresentative = false;


    private int _slotCount = 0;

    private List<SpriteRenderer> _craftBubbleUnit = new List<SpriteRenderer>();
    private BuildingData _data;
    private KingdomManager _kingdomManager;

    public bool IsCraftable { get; protected set; }
    public CookieController Worker { get; private set; }
    public List<CraftingItemData> CraftingItemData => _craftingItemData;

    public virtual void Init(BuildingController controller)
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

    // �ǹ��� ���۽����� �ʱ�ȭ����
    public void InitCraftSlot()
    {
        _craftingItemData = new List<CraftingItemData>();
        for (int i = 0; i < _slotCount; i++)
            _craftingItemData.Add(new CraftingItemData(ECraftingState.empty, null));
    }


    public virtual void LoadBuilding()
    {
        BuildingInfo buildingInfo = GameManager.Game.OwnedCraftableBuildings[_controller.Data.BuildingIndex];

        _slotCount = buildingInfo.slotCount;
        InitCraftSlot();
        IsCraftable = buildingInfo.isCraftable;
        _craftingItemData = buildingInfo.craftingItemData;

        if (buildingInfo.isInstall)
        {
            _controller.BuildingEditor.IsFlip = buildingInfo.isFlip;
            _controller.BuildingAnimator.FlipX(_controller.BuildingEditor.IsFlip);

            transform.position = buildingInfo.installationPosition;
            transform.SetGridTransform();

            WorkBuilding();
            _controller.BuildingEditor.IsInstance = true;
            _controller.BuildingEditor.OnClickEditMode();
            _controller.BuildingEditor.PutBuilding();
            BuildingPreviewTileObjectPool.instance.ResetPreviewTile();
        }
    }

    public virtual void SaveBuilding()
    {
        BuildingInfo buildingInfo = GameManager.Game.OwnedCraftableBuildings[_controller.Data.BuildingIndex];

        buildingInfo.isCraftable = IsCraftable;
        buildingInfo.installationPosition = transform.position;
        buildingInfo.isInstall = _controller.BuildingEditor.IsInstance;
        buildingInfo.isFlip = _controller.BuildingEditor.IsFlip;

        buildingInfo.craftingItemData = _craftingItemData;

        if (Worker != null)
            buildingInfo.cookieWorkerIndex = ((CookieData)Worker.Data).CookieIndex;
        else
            buildingInfo.cookieWorkerIndex = -1;
    }

    // �ǹ��� ������ �ֽ�ȭ����
    public void LoadWorker(CookieController worker)
    {
        Worker = worker;

        if(Worker != null)
        {
            Worker.CookieCitizeon.GoToWork(_workPlace);
            Worker.CharacterAnimator.SettingOrderLayer(false);
        }

        // ���ϴ� ���� �ƴ�
        if (_craftingItemData[0].state == ECraftingState.empty)
        {
            _controller.BuildingAnimator.PlayAnimation("off");
        }
        else
        {
            if (!_controller.BuildingAnimator.IsAnimationExist("working"))
                _controller.BuildingAnimator.PlayAnimation("loop_back");
            else
                _controller.BuildingAnimator.PlayAnimation("working");

            if(Worker != null)
                Worker.CharacterAnimator.PlayAnimation(_workAnimationName);
        }
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
                CookieController cookie = _kingdomManager.allCookies[Random.Range(0, _kingdomManager.allCookies.Count)];
                if (!cookie.CookieStat.IsHave)
                    continue;
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
        if(Worker != null)
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
    public virtual bool TryHarvest()
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
    protected virtual void Harvest()
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

            // ��ǥ�ǹ��� PrevcraftTime�ð��� �����Ѵ�. 
            if (isRepresentative)
            {
                GameManager.Game.PrevCraftTime = System.DateTime.Now;
            }

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
