local tiny = {}
local path = {}
myHero = Heroes.GetLocal()

------Пути----------
path[1] = {"Vaness", "Heroes", "Strength", "Tiny"}
path[2] = {"Vaness", "Heroes", "Strength", "Tiny", "Combo key"}
path[3] = {"Vaness", "Heroes", "Strength", "Tiny", "Items combo"}
path[4] = {"Vaness", "Heroes", "Strength", "Tiny", "Skill combo"}
path[5] = {"Vaness", "Heroes", "Strength", "Tiny", "Abilities combo"}
path[6] = {"Vaness", "Heroes", "Strength", "Tiny", "Test"}

tiny.OverallEnable = Menu.AddOptionBool(path[1], "Enable", false)
tiny.ComboKey = Menu.AddKeyOption(path[1], "Combo key", Enum.ButtonCode.BUTTON_CODE_NONE)
myHero = Heroes.GetLocal()
tiny.test = Menu.AddOptionBool(path[6], "Enable", false)
tiny.findradius = Menu.AddOptionSlider(path[6], "Find radius", 250, 2000, 1200)

-------items---------
tiny.blood = Menu.AddOptionBool(path[3], "Bloodthorn", false)
tiny.orchid = Menu.AddOptionBool(path[3], "Orchid", false)
tiny.null = Menu.AddOptionBool(path[3], "Nullifier", false)
tiny.blink = Menu.AddOptionBool(path[1], "Enable blink ?", false)
tiny.dagon = Menu.AddOptionBool(path[3], "Dagon", false)
tiny.hex = Menu.AddOptionBool(path[3], "Scythe of Vyse", false)
-----------------------

---------Icons------------
Menu.AddMenuIcon(path[1], "panorama/images/heroes/icons/npc_dota_hero_tiny_png.vtex_c")
Menu.AddOptionIcon(tiny.blood, "panorama/images/items/bloodthorn_png.vtex_c")
Menu.AddOptionIcon(tiny.orchid, "panorama/images/items/orchid_png.vtex_c")
Menu.AddOptionIcon(tiny.null, "panorama/images/items/Nullifier_png.vtex_c")
Menu.AddOptionIcon(tiny.blink, "panorama/images/items/blink_png.vtex_c")
Menu.AddOptionIcon(tiny.dagon, "panorama/images/items/dagon_5_png.vtex_c")
Menu.AddOptionIcon(tiny.hex, "panorama/images/items/sheepstick_png.vtex_c")
-----------------------

function tiny.OnUpdate()
	if not Menu.IsEnabled(tiny.OverallEnable) then return end
	if not Engine.IsInGame() or NPC.IsStunned(myHero) or not Entity.IsAlive(myHero) then return end
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_tiny" then return end

	if Menu.IsKeyDown(tiny.ComboKey) and Menu.IsEnabled(tiny.OverallEnable) then
		return tiny.Combo(myHero, enemy)
	end 
end

function tiny.Combo(myHero, enemy)
	tiny.GetItems()
	tiny.GetSkills()
	mana = NPC.GetMana(myHero)
	pos = Entity.GetAbsOrigin(myHero)
	fRadius = Menu.GetValue(tiny.findradius)
	if not Menu.IsKeyDown(tiny.ComboKey) then return end
	--Heroes.InRadius(vec, radius, teamNum, teamType) 
	enemy = Heroes.InRadius(pos, fRadius, Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
	enemy1 = Entity.GetAbsOrigin(enemy)

	if Menu.IsEnabled(tiny.OverallEnable) and Menu.IsKeyDown(tiny.ComboKey) then
		if Menu.IsEnabled(blink) and Ability.IsReady(blink) and Ability.IsCastable(blink) then
			Ability.CastPosition(blink, enemy1)
		end
			if Menu.IsEnabled(null) and Ability.IsReady(null) and Ability.IsCastable(null, mana) then
				Ability.CastTarget(null, enemy1)
		end
	end
end


function tiny.GetItems()
	blood = NPC.GetItem(myHero, "item_bloodthorn")
	orchid = NPC.GetItem(myHero, "item_orchid")
	null = NPC.GetItem(myHero, "item_nullifier")
	blink = NPC.GetItem(myHero, "item_blink")
	dagon = NPC.GetItem(myHero, "item_dagon")
		if not dagon then
			for i=2,5 do
			  dagon = NPC.GetItem(myHero, "item_dagon_" .. i)
			if dagon then break end
			end
    	end
    hex = NPC.GetItem(myHero, "item_sheepstick")
end

function tiny.GetSkills()
	 avalance = NPC.GetAbility(myHero, "tiny_avalanche")
	 toss = NPC.GetAbility(myHero, "tiny_toss")
end

return tiny