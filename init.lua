dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function allocate_perks()
	---@type table
    local perk_deck = perk_get_spawn_order()

    if (perk_deck ~= nil) then
		for _, perk in ipairs({"GLASS_CANNON", "PERKS_LOTTERY", "EXPLODING_CORPSES"}) do	
			if (table_contains({perk_deck[1], perk_deck[2], perk_deck[3]}, perk)) then
				return
			end
		end
		local seed = Random(1, 999999999)
		GamePrint("New seed: " .. tostring(seed))
		SetWorldSeed(seed)
		return allocate_perks()
    end
end


function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	allocate_perks()
end
