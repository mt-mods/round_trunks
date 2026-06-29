-- simple mesh-based round trees mod
-- by VanessaEzekowitz
--
-- Textures borrowed/derived from Mossmanikin's alternate trunks mod

local trees = {
	{"default:tree",        "round_default_tree_top.png"},
	{"default:jungletree",  "default_jungletree_top.png"},
	{"default:pine_tree",   "round_pine_tree_top.png"   },
	{"default:acacia_tree", "round_acacia_tree_top.png" },
	{"default:aspen_tree",  "round_aspen_tree_top.png"  },
	{"default:cactus",      "default_cactus_top.png"    }
}

for _,tree in pairs(trees) do
	local nodename, top = unpack(tree)

	local oldnode = core.registered_nodes[nodename]
	if not oldnode then
		error("[round_trunks] "..nodename.." is not a node.")
	end

	local def = {}
	for i in pairs(oldnode) do
		def[i] = rawget(oldnode, i)
	end

	core.override_item(nodename, {
		drawtype = "mesh",
		mesh = "round_trunks_mesh.obj",
		tiles = {top, top, def.tiles[3]},
		paramtype = "light",
	})

	trees2[#trees2+1] = nodename

	core.register_node(":"..nodename.."_cube", def)

	core.register_craft({
		output = nodename.." 4",
		recipe = {
			{def.name, def.name},
			{def.name, def.name}
		}
	})

	core.register_craft({
		output = def.name.." 4",
		recipe = {
			{nodename, nodename},
			{nodename, nodename}
		}
	})
end

--[[ This lbm should fix black trunks.
core.register_lbm({
	name = "round_trunks:trunkfix",
	nodenames = trees2,
	action = function(pos, node)
		node.param1 = nil
		core.set_node(pos, node)
	end
})
--]]
