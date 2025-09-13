local assets = {
    Asset("ANIM", "anim/custom_wand.zip")
}

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "custom_wand", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function OnUnequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:Hide("ARM_carry")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("custom_wand")
    inst.AnimState:SetBuild("custom_wand")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "rocks"
    inst.components.inventoryitem.atlasname = "images/inventoryimages.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    inst:AddComponent("lightningwand")

    return inst
end

return Prefab("custom_wand", fn, assets)