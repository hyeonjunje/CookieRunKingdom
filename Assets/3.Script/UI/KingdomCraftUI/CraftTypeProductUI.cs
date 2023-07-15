using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CraftTypeProductUI : CraftTypeUI
{
    [SerializeField] private CraftInGredientUI _craftInGredientUI;
    [SerializeField] private Transform _ingredientParent;

    private List<CraftInGredientUI> _ingredientUIList;

    public override void Init(CraftData craftData, System.Action<CraftData> action = null)
    {
        base.Init(craftData, action);

        _ingredientParent.DestroyAllChild();
        _ingredientUIList = new List<CraftInGredientUI>();

        for (int i = 0; i < craftData.Ingredients.Length; i++)
        {
            CraftInGredientUI ui =Instantiate(_craftInGredientUI, _ingredientParent);
            _ingredientUIList.Add(ui);
            ui.Init(craftData.Ingredients[i]);
        }

        craftButton.onClick.AddListener(() =>
        {
            for(int i = 0; i < _ingredientUIList.Count; i++)
                _ingredientUIList[i].SetText();
        });
    }
}
