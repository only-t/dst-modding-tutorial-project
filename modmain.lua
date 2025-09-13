print("Hello Constant!")

Assets = {
	Asset("ATLAS", "images/hungry_pou_plush.xml"),
	Asset("IMAGE", "images/hungry_pou_plush.tex"),

	Asset("ANIM", "anim/hungry_pou_plush.zip"),

	Asset("ANIM", "anim/my_cool_anim.zip"),
	
    Asset("ANIM", "anim/custom_hat.zip"),
    Asset("ANIM", "anim/custom_bodyarmor.zip"),
    Asset("ANIM", "anim/custom_wand.zip")
}

PrefabFiles = {
	"hungry_pou_plush",
	"custom_hat",
	"custom_bodyarmor",
	"custom_wand",
}

local STRINGS = GLOBAL.STRINGS
local NAMES = STRINGS.NAMES
local GENERIC = STRINGS.CHARACTERS.GENERIC.DESCRIBE
local WILLOW = STRINGS.CHARACTERS.WILLOW.DESCRIBE
local WOLFGANG = STRINGS.CHARACTERS.WOLFGANG.DESCRIBE
local WENDY = STRINGS.CHARACTERS.WENDY.DESCRIBE
local WX78 = STRINGS.CHARACTERS.WX78.DESCRIBE
local WICKERBOTTOM = STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE
local WOODIE = STRINGS.CHARACTERS.WOODIE.DESCRIBE
local MAXWELL = STRINGS.CHARACTERS.WAXWELL.DESCRIBE
local WIGFRID = STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE
local WEBBER = STRINGS.CHARACTERS.WEBBER.DESCRIBE
local WINONA = STRINGS.CHARACTERS.WINONA.DESCRIBE
local WARLY = STRINGS.CHARACTERS.WARLY.DESCRIBE
local WORTOX = STRINGS.CHARACTERS.WORTOX.DESCRIBE
local WORMWOOD = STRINGS.CHARACTERS.WORMWOOD.DESCRIBE
local WURT = STRINGS.CHARACTERS.WURT.DESCRIBE
local WALTER = STRINGS.CHARACTERS.WALTER.DESCRIBE
local WANDA = STRINGS.CHARACTERS.WANDA.DESCRIBE

NAMES.HUNGRY_POU_PLUSH = "Pou Plush (Feed Him)"
GENERIC.HUNGRY_POU_PLUSH = "Dinner."
WILLOW.HUNGRY_POU_PLUSH = "Dinner."
WOLFGANG.HUNGRY_POU_PLUSH = "Dinner."
WENDY.HUNGRY_POU_PLUSH = "Dinner."
WX78.HUNGRY_POU_PLUSH = "Dinner."
WICKERBOTTOM.HUNGRY_POU_PLUSH = "Dinner."
WOODIE.HUNGRY_POU_PLUSH = "Dinner."
MAXWELL.HUNGRY_POU_PLUSH = "Dinner."
WIGFRID.HUNGRY_POU_PLUSH = "Dinner."
WEBBER.HUNGRY_POU_PLUSH = "Dinner."
WINONA.HUNGRY_POU_PLUSH = "Dinner."
WARLY.HUNGRY_POU_PLUSH = "Dinner."
WORTOX.HUNGRY_POU_PLUSH = "Dinner."
WORMWOOD.HUNGRY_POU_PLUSH = "Dinner."
WURT.HUNGRY_POU_PLUSH = "Dinner."
WALTER.HUNGRY_POU_PLUSH = "Dinner."
WANDA.HUNGRY_POU_PLUSH = "Dinner."

AddAction("HUG", "Hug!", function(act)
	if act.invobject then
		act.invobject.components.huggable:Hug(act.doer)

		return true
	end

	return false
end)

AddComponentAction("INVENTORY", "huggable", function(inst, doer, actions, right)
	if doer.replica.inventory:GetActiveItem() == nil and (doer.replica.rider == nil or not doer.replica.rider:IsRiding()) then
		table.insert(actions, GLOBAL.ACTIONS.HUG)
	end
end)

local hug_state = GLOBAL.State{
	name = "my_custom_hug_state",
	tags = { "doing", "busy" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
		inst.AnimState:Show("ARM_carry")
		inst.AnimState:Hide("ARM_normal")
		inst.AnimState:PlayAnimation("action_uniqueitem_pre")
		inst.AnimState:PushAnimation("funny_anim", false)
        inst.AnimState:OverrideSymbol("swap_object", "bernie_build", "swap_bernie")
		inst.AnimState:OverrideSymbol("swap_object_bernie", "bernie_build", "swap_bernie_idle_willow")
	end,

	onexit = function(inst)
		inst.AnimState:Show("ARM_normal")
		inst.AnimState:Hide("ARM_carry")
	end,

	events = {
		GLOBAL.EventHandler("animqueueover", function(inst)
			inst.sg:GoToState("idle")
		end)
	},
	
	timeline = {
		GLOBAL.TimeEvent(50*GLOBAL.FRAMES, function(inst)
			inst:PerformBufferedAction()
		end)
	}
}

local hug_state_client = GLOBAL.State{
	name = "my_custom_hug_state",
	server_states = { "my_custom_hug_state" },
	forward_server_states = true,
	onenter = function(inst) inst.sg:GoToState("action_uniqueitem_busy") end
}

AddStategraphState("wilson_client", hug_state_client)
AddStategraphState("wilson", hug_state)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.HUG, "my_custom_hug_state"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.HUG, "my_custom_hug_state"))

AddAction("DOLIGHTNING", "Cast Spell", function(act)
	if act.invobject then
		act.invobject.components.lightningwand:DoLightning(act:GetActionPoint())

		return true
	end

	return false
end)

GLOBAL.ACTIONS.DOLIGHTNING.distance = 20

AddComponentAction("POINT", "lightningwand", function(inst, doer, pos, actions, right, target)
	if not right then
		return
	end

	if doer.replica.inventory:GetActiveItem() == nil and (doer.replica.rider == nil or not doer.replica.rider:IsRiding()) then
		table.insert(actions, GLOBAL.ACTIONS.DOLIGHTNING)
	end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DOLIGHTNING, "castspell"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DOLIGHTNING, "castspell"))