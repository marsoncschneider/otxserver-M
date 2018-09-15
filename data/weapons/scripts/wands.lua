local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
   
function onGetFormulaValues(cid, level, maglevel)
    local min = -maglevel*10
    local max = -maglevel*20
return min, max    
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
function onUseWeapon(cid, var)
    doCombat(cid, combat, var)
end