using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CraftTypeProductUI : CraftTypeUI
{
    [SerializeField] private CraftInGredientUI _craftInGredientUI;
    [SerializeField] private Transform _ingredientParent;

    public override void Init(CraftData craftData)
    {
        base.Init(craftData);

        _ingredientParent.DestroyAllChild();

        for (int i = 0; i < craftData.Ingredients.Length; i++)
        {
            CraftInGredientUI ui =Instantiate(_craftInGredientUI, _ingredientParent);
            ui.Init(craftData.Ingredients[i]);
        }
    }
}
