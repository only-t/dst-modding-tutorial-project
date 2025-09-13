local LightningWand = Class(function(self, inst)
    self.inst = inst
end)

function LightningWand:DoLightning(pos)
    local lightning = SpawnPrefab("lightning")
    lightning.Transform:SetPosition(pos.x, pos.y, pos.z)

    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 3)
    for i, ent in ipairs(ents) do
        if ent.components.burnable then
            ent.components.burnable:Ignite()
        end
        
        if ent.components.combat then
            ent.components.combat:GetAttacked(lightning, 30)
        end
    end
end

return LightningWand