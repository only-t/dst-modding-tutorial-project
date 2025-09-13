local assets = {
    Asset("ANIM", "anim/hungry_pou_plush.zip"),
    Asset("ATLAS", "images/hungry_pou_plush.xml"),
    Asset("IMAGE", "images/hungry_pou_plush.tex"),
}

local function whatever_i_like()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("hungry_pou_plush")
    inst.AnimState:SetBuild("hungry_pou_plush")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "hungry_pou_plush"
	inst.components.inventoryitem.atlasname = "images/hungry_pou_plush.xml"

    inst:AddComponent("huggable")
    inst.components.huggable:SetSanityGain(15)

    return inst
end

return Prefab("hungry_pou_plush", whatever_i_like, assets)