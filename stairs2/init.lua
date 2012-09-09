-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.

-- Node will be called stairs:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description)
    minetest.register_node(minetest.get_current_modname()..":stair_" .. subname, {
        description = description,
        drawtype = "nodebox",
        tiles = images,
        paramtype = "light",
        paramtype2 = "facedir",
        is_ground_content = true,
        groups = groups,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
                {-0.5, 0, 0, 0.5, 0.5, 0.5},
            },
        },
    })

    minetest.register_craft({
        output = minetest.get_current_modname()..':stair_' .. subname .. ' 4',
        recipe = {
            {recipeitem, "", ""},
            {recipeitem, recipeitem, ""},
            {recipeitem, recipeitem, recipeitem},
        },
    })

    -- Flipped recipe for the silly minecrafters
    minetest.register_craft({
        output = minetest.get_current_modname()..':stair_' .. subname .. ' 4',
        recipe = {
            {"", "", recipeitem},
            {"", recipeitem, recipeitem},
            {recipeitem, recipeitem, recipeitem},
        },
    })
end

-- Node will be called stairs:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description)
    minetest.register_node(minetest.get_current_modname()..":slab_" .. subname, {
        description = description,
        drawtype = "nodebox",
        tiles = images,
        paramtype = "light",
        is_ground_content = true,
        groups = groups,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type ~= "node" then
                return itemstack
            end

            -- If it's being placed on an another similar one, replace it with
            -- a full block
            local slabpos = nil
            local slabnode = nil
            local p0 = pointed_thing.under
            local p1 = pointed_thing.above
            local n0 = minetest.env:get_node(p0)
            local n1 = minetest.env:get_node(p1)
            if n0.name == minetest.get_current_modname()..":slab_" .. subname then
                slabpos = p0
                slabnode = n0
            elseif n1.name == minetest.get_current_modname()..":slab_" .. subname then
                slabpos = p1
                slabnode = n1
            end
            if slabpos then
                -- Remove the slab at slabpos
                minetest.env:remove_node(slabpos)
                -- Make a fake stack of a single item and try to place it
                local fakestack = ItemStack(recipeitem)
                pointed_thing.above = slabpos
                fakestack = minetest.item_place(fakestack, placer, pointed_thing)
                -- If the item was taken from the fake stack, decrement original
                if not fakestack or fakestack:is_empty() then
                    itemstack:take_item(1)
                -- Else put old node back
                else
                    minetest.env:set_node(slabpos, slabnode)
                end
                return itemstack
            end

            -- Otherwise place regularly
            return minetest.item_place(itemstack, placer, pointed_thing)
        end,
    })

    minetest.register_craft({
        output = minetest.get_current_modname()..':slab_' .. subname .. ' 3',
        recipe = {
            {recipeitem, recipeitem, recipeitem},
        },
    })
end

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab)
    stairs.register_stair(subname, recipeitem, groups, images, desc_stair)
    stairs.register_slab(subname, recipeitem, groups, images, desc_slab)
end


-- add glass and desert stone stairs and slabs
stairs.register_stair_and_slab(
    "desert_stone",
    "default:desert_stone",
    {cracky=3},
    {"default_desert_stone.png"},
    "Desert Stone Stair",
    "Desert Stone Slab")

stairs.register_stair_and_slab(
    "glass",
    "default:glass",
    {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    {"default_glass.png"},
    "Glass Stair",
    "Glass Slab")

print("hello from "..minetest.get_current_modname().." at "..minetest.get_modpath(minetest.get_current_modname()).."!")
