using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Pathfinding;
using Spine.Unity;

public class CookiePathFinder : MonoBehaviour
{
    public float speed = 5f;

    private Path _path;
    private SkeletonAnimation _animation;
    private Renderer _renderer;
    private Seeker _seeker;

    private Coroutine _coPathFinding;
    private Transform _target;

    private bool _isInit = false;

    public void Init(CharacterData data, Transform target)
    {
        if (data == null)
        {
            transform.DestroyAllChild();
            _animation = null;
            return;
        }
        else
        {
            _animation = Instantiate(data.SpinePrefab, transform);
            _renderer = _animation.GetComponentInChildren<Renderer>();
            if(_seeker == null)
                _seeker = GetComponent<Seeker>();

            _target = target;
            transform.position = _target.position;

            _animation.Initialize(true);
            _animation.AnimationState.SetAnimation(0, "idle", true);
        }
    }

    public void StartPathFinding()
    {
        if(_animation != null)
            _seeker.StartPath(transform.position, _target.position, OnPathComplete);
    }

    private void OnPathComplete(Path p)
    {
        if(!p.error)
        {
            _path = p;

            if (_coPathFinding != null)
                StopCoroutine(_coPathFinding);
            _coPathFinding = StartCoroutine(CoPathFinding());
        }
    }

    private IEnumerator CoPathFinding()
    {
        Vector3 dir = Vector3.zero;
        for (int i = 0; i < _path.vectorPath.Count; i++)
        {
            dir = _path.vectorPath[i] - transform.position;
            if (dir.x >= 0)
                transform.localScale = Vector3.one;
            else
                transform.localScale = new Vector3(-1, 1, 1);

            if(dir.y > 0)
                _animation.AnimationState.SetAnimation(0, "run_back", true);
            else
                _animation.AnimationState.SetAnimation(0, "run", true);

            _renderer.sortingOrder = -Mathf.RoundToInt(transform.position.y * 5);

            while (Vector3.Distance(transform.position, _path.vectorPath[i]) > 0.01f)
            {
                yield return null;
                transform.position = Vector3.MoveTowards(transform.position, _path.vectorPath[i], speed * Time.deltaTime);
            }
            transform.position = _path.vectorPath[i];
        }

        if (dir.y <= 0)
            _animation.AnimationState.SetAnimation(0, "idle", true);
        else
            _animation.AnimationState.SetAnimation(0, "idle_back", true);
    }
}
