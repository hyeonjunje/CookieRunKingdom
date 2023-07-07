using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingWorker : MonoBehaviour
{
    private BuildingController _controller;

    [SerializeField] private List<CraftingItemData> _craftingItemData = new List<CraftingItemData>();
    [SerializeField] private GameObject _craftBubble;

    [Header("일할 쿠키 정보")]
    [SerializeField] private Transform _workPlace;
    [SerializeField] private string _workAnimationName;

    // 해당 건물이 작업중인가, 아닌가?
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
        // 아무나 쿠키 위치 시키고
        // 쿠키 등장 애니메이션 넣어주기

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
    /// 제작물 수확을 시도하는 메소드
    /// 수확할 수 있으면 수확하고 true반환
    /// 수확할 수 없으면 그냥 false 반환
    /// </summary>
    /// <returns>수확할 수 있나?</returns>
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

    // 실질적으로 수확하는 메소드
    private void Harvest()
    {
        // 버블에 떠다니는 수확물 다 없애기
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

        // 전부 다 수확하면 애니메이션 꺼주기
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

            // 만들고 있다면
            if (_craftingItemData[i].state == ECraftingState.making)
            {
                // 1초씩 더해준다.
                _craftingItemData[i].takingTime += 1;

                // 만약 다 만들었다면
                if (_craftingItemData[i].takingTime >= _craftingItemData[i].craftData.CraftTime)
                {
                    // 버블
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
    /// 다른 상태나 씬에서 KingdomManageState로 돌아올 때 GameManagerEx의 PrevCraftTime과 현재 시간을 계산해서
    /// 제작품의 정보를 최신화한다.
    /// </summary>
    public void UpdateCraftingItem()
    {
        int diffTime = (int)((System.DateTime.Now - GameManager.Game.PrevCraftTime).TotalSeconds);

        for (int i = 0; i < _craftingItemData.Count; i++)
        {
            if (_craftingItemData[i].craftData == null)
                return;

            // 만들고 있다면
            if (_craftingItemData[i].state == ECraftingState.making)
            {
                int remainTime = _craftingItemData[i].craftData.CraftTime - _craftingItemData[i].takingTime;

                // 시간의 차이가 제작품의 남은 시간보다 많으면 만든걸로 한다.
                if(diffTime >= remainTime)
                {
                    diffTime -= remainTime;
                    _craftingItemData[i].state = ECraftingState.complete;

                    // 버블
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
