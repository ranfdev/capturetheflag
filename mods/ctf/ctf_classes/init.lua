ctf_classes = {
	__classes = {},
	__classes_ordered = {},
}

dofile(minetest.get_modpath("ctf_classes") .. "/api.lua")
dofile(minetest.get_modpath("ctf_classes") .. "/gui.lua")

ctf_classes.register("knight", {
	description = "Knight",
	pros = { "+10 HP", "+10% melee skill" },
	cons = { "-10% speed" },
	max_hp = 30,
	color = "#ccc",
})

ctf_classes.register("archer", {
	description = "Archer",
	pros = { "+10% ranged skill", "Can use sniper rifles", "Can use grapling hooks" },
	cons = {},
	speed = 1.1,
	color = "#c60",
})

ctf_classes.register("medic", {
	description = "Medic",
	speed = 1.1,
	pros = { "x2 regen for nearby friendlies", "Free bandages" },
	cons = { "Can't capture the flag"},
	color = "#0af",
})

minetest.register_on_joinplayer(ctf_classes.update)

minetest.register_chatcommand("set_class", {
	func = function(name, params)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "You must be online to do this!"
		end

		local cname = params:trim()
		if params == "" then
			ctf_classes.show_gui(name)
		else
			if ctf_classes.__classes[cname] then
				ctf_classes.set(player, cname)
				return true, "Set class to " .. cname
			else
				return false, "Class '" .. cname .. "' does not exist"
			end
		end
	end
})
