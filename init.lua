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

local trees2 = {}

for i in ipairs(trees) do
	local nodename = trees[i][1]
	local top =      trees[i][2]

	local oldnode = minetest.registered_nodes[nodename]
	if not oldnode then return end
	local newnode = table.copy(oldnode)

	minetest.register_node(":"..nodename.."_cube", oldnode)

	newnode.drawtype = "mesh"
	newnode.mesh = "round_trunks_mesh.obj"
	newnode.tiles[1] = top
	newnode.tiles[2] = top
	newnode.paramtype = "light"

	minetest.register_node(":"..nodename, newnode)
	table.insert(trees2, nodename)

	minetest.register_craft({
		output = newnode.name.." 4",
		recipe = {
			{ oldnode.name, oldnode.name },
			{ oldnode.name, oldnode.name }
		}
	})

	minetest.register_craft({
		output = oldnode.name.." 4",
		recipe = {
			{ newnode.name, newnode.name },
			{ newnode.name, newnode.name }
		}
	})
end

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
