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
    [SerializeField] private string _initAnimation;
    [SerializeField] private string _workAnimationName;

    private List<SpriteRenderer> _craftBubbleUnit = new List<SpriteRenderer>();

    public List<CraftingItemData> CraftingItemData => _craftingItemData;
    private BuildingData _data;
    private KingdomManager _kingdomManager;

    public CookieController Worker;

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
            Worker = _kingdomManager.myCookies[Random.Range(0, _kingdomManager.myCookies.Count)];
            Worker.CharacterAnimator.PlayAnimation(_initAnimation);
            Worker.transform.position = _workPlace.position;
            Worker.CookieCitizeon.WorkInKingdom();
        }

        foreach (Renderer renderer in GetComponentsInChildren<Renderer>())
        {
            renderer.sortingLayerID = flag ?
            SortingLayer.NameToID("GridUpper") : SortingLayer.NameToID("Default");

            Worker.CharacterAnimator.SettingOrderLayer(flag);
        }
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
            _controller.BuildingAnimator.PlayAnimation("off");
            Worker.CharacterAnimator.PlayAnimation(_initAnimation);
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
                    }
                }
            }
        }
    }
}
