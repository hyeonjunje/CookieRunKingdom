using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProjectileMagicCircle : MonoBehaviour
{
    [SerializeField] private Transform outerCircle;
    [SerializeField] private Transform innerCircle;
    [SerializeField] private DamageBox lighting;

    [SerializeField] private float moveSpeed = 5f;
    [SerializeField] private float rotateSpeed = 5f;
    [SerializeField] private float timePerAttack = 1f;
    [SerializeField] private float duration = 6f;
    [SerializeField] private Vector3 dir= new Vector3(7.72f, 3.86f,0f);

    private float _currentTime = 0f;
    private float _entireTime = 0f;
    private Transform _parent = null;
    private Vector3 _initPos = Vector3.zero;

    public void Init(int damage, LayerMask targetLayer, bool isForward, Transform parent, Vector3 initPos)
    {
        dir = isForward ? dir : -dir;
        _parent = parent;
        _initPos = initPos;
        lighting.Init(damage, targetLayer);
    }

    private void OnEnable()
    {
        _currentTime = 0;
        _entireTime = 0;

        transform.localPosition = _initPos;
        transform.SetParent(null);
    }

    private void Update()
    {
        _currentTime += Time.deltaTime;

        transform.position += dir.normalized * moveSpeed * Time.deltaTime;
        innerCircle.localEulerAngles += Vector3.forward * rotateSpeed * Time.deltaTime;

        if(_currentTime >= timePerAttack)
        {
            _entireTime += _currentTime;
            _currentTime = 0;
            lighting.gameObject.SetActive(true);
        }

        if (lighting.gameObject.activeSelf && _currentTime >= 0.2f)
        {
            lighting.gameObject.SetActive(false);
        }

        if (_entireTime + _currentTime >= duration)
        {
            transform.SetParent(_parent);
            gameObject.SetActive(false);
        }
    }
}
