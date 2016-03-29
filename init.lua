-- simple mesh-based round trees mod
-- by VanessaEzekowitz
--
-- Textures borrowed/derived from Mossmanikin's alternate trunks mod, cc-by-sa
-- code: WTFPL

local trees={
	{ "default:tree",        "round_default_tree_top.png" },
	{ "default:jungletree",  "default_jungletree_top.png" },
	{ "default:pine_tree",   "round_pine_tree_top.png"    },
	{ "default:acacia_tree", "round_acacia_tree_top.png"  },
	{ "default:cactus",      "default_cactus_top.png"     }
}

--local trees2 = {}

for _,tree in pairs(trees) do
	local nodename, top = unpack(tree)

	local oldnode = minetest.registered_nodes[nodename]
	if not oldnode then
		error("[round_trunks] "..nodename.." is not a node.")
	end

	local def = {}
	for i in pairs(oldnode) do
		def[i] = rawget(oldnode, i)
	end

	minetest.override_item(nodename, {
		drawtype = "mesh",
		mesh = "round_trunks_mesh.obj",
		tiles = {top, top, def.tiles[3]},
		paramtype = "light",
	})

	--trees2[#trees2+1] = nodename

	minetest.register_node(":"..nodename.."_cube", def)


	minetest.register_craft({
		output = nodename.." 4",
		recipe = {
			{ def.name, def.name },
			{ def.name, def.name }
		}
	})

	minetest.register_craft({
		output = def.name.." 4",
		recipe = {
			{ nodename, nodename },
			{ nodename, nodename }
		}
	})
end

--[[ If this abm was good for something, it should have been documented.
minetest.register_abm({
	nodenames = trees2,
	chance = 2,
	interval = 1,
	action = function(pos, node)
		if node.param1 == 0 then
			minetest.set_node(pos, {name = node.name, param2 = node.param2 })
		end
	end
})
--]]
