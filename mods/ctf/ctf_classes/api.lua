function ctf_classes.register(cname, def)
	assert(not ctf_classes.__classes[cname])
	def.name = cname
	ctf_classes.__classes[cname] = def
	table.insert(ctf_classes.__classes_ordered, def)

	def.max_hp = def.max_hp or 20
	def.pros   = def.pros or {}
	def.cons   = def.cons or {}
end

function ctf_classes.get(player)
	if type(player) == "string" then
		player = minetest.get_player_by_name(player)
	end

	local cname = player:get_meta():get("ctf_classes:class") or "knight"
	return ctf_classes.__classes[cname]
end

function ctf_classes.set(player, cname)
	assert(ctf_classes.__classes[cname])
	player:get_meta():set_string("ctf_classes:class", cname)
	ctf_classes.update(player)
end

local function set_max_hp(player, max_hp)
	local cur_hp = player:get_hp()
	local new_hp = cur_hp + max_hp - player:get_properties().hp_max
	player:set_properties({
		hp_max = max_hp
	})

	assert(new_hp <= max_hp)
	if cur_hp > max_hp then
		player:set_hp(max_hp)
	elseif new_hp > cur_hp then
		player:set_hp(new_hp)
	end

	--TODO: update HUD
end

function ctf_classes.update(player)
	local class = ctf_classes.get(player)
	print("Class: " .. class.name)
	set_max_hp(player, class.max_hp)
	print(" - max_hp = " .. class.max_hp)
end
