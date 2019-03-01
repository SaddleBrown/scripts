local tiny = {}
local path = {}
myHero = Heroes.GetLocal()

------Пути----------
path[1] = {"Vaness", "Heroes", "Strength", "Tiny"}
path[2] = {"Vaness", "Heroes", "Strength", "Tiny", "Combo key"}
path[3] = {"Vaness", "Heroes", "Strength", "Tiny", "Items combo"}
path[4] = {"Vaness", "Heroes", "Strength", "Tiny", "Skill combo"}
path[5] = {"Vaness", "Heroes", "Strength", "Tiny", "Abilities combo"}

tiny.OverallEnable = Menu.AddOptionBool(path[1], "Enable", false)
tiny.ComboKey = Menu.AddKeyOption(path[1], "Combo key", Enum.ButtonCode.BUTTON_CODE_NONE)
myHero = Heroes.GetLocal()
-------items-------
tiny.blood = Menu.AddOptionBool(path[3], "Bloodthorn", false)
tiny.orchid = Menu.AddOptionBool(path[3], "Orchid", false)
tiny.null = Menu.AddOptionBool(path[3], "Nullifier", false)
tiny.blink = Menu.AddOptionBool(path[1], "Enable blink ?", true)
tiny.dagon = Menu.AddOptionBool(path[3], "Dagon", false)

---------Icons------------
Menu.AddMenuIcon(path[1], "panorama/images/heroes/icons/npc_dota_hero_tiny_png.vtex_c")
Menu.AddOptionIcon(tiny.blood, "panorama/images/items/bloodthorn_png.vtex_c")
Menu.AddOptionIcon(tiny.orchid, "panorama/images/items/orchid_png.vtex_c")
Menu.AddOptionIcon(tiny.null, "panorama/images/items/Nullifier_png.vtex_c")
Menu.AddOptionIcon(tiny.blink, "panorama/images/items/blink_png.vtex_c")
Menu.AddOptionIcon(tiny.dagon, "panorama/images/items/dagon_5_png.vtex_c")
-----------------------

function tiny.OnUpdate()
	if not Menu.IsEnabled(tiny.OverallEnable) then return end
	if not Engine.IsInGame() or NPC.IsStunned(myHero) or Entity.IsAlive(myHero) then return end
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_tiny" then return end
	if Menu.IsKeyDown(tiny.ComboKey) then
		return tiny.Combo()
	end
end

function tiny.Combo()
	if not Menu.IsKeyDown(tiny.ComboKey) then return end


end