-- move player to registered "home" position when respawned
minetest.register_on_respawnplayer(function(player)
    local name = player:get_player_name()
    local home = player_data.get_player_data(name, "home_position")
    if home ~= nil then
        minetest.log("action", "Moving player "..name.." to home position.")
        player:setpos(home)
        return true
    end
    minetest.log("action", "No home position for player "..name..".")
    return false
end)

-- set player home position
minetest.register_chatcommand("home", {
    params = "",
    description = "set your 'home' position.",
    privs = {},
    func = function(name, param)
        local player = minetest.env:get_player_by_name(name)
        player_data.set_player_data(name, "home_position", player:getpos())
        local home = player_data.get_player_data(name, "home_position")
        minetest.log("action", "Set home position for player "..name.." to ("..home.x..", "..home.y..", "..home.z..").")
        minetest.chat_send_player(name, "You will now respawn here.")
    end,
})

-- kills the player
minetest.register_chatcommand("killme", {
    params = "",
    description = "kills you.",
    privs = {},
    func = function(name, param)
        local player = minetest.env:get_player_by_name(name)
        player:set_hp(0)
        minetest.log("action", "Killed player "..name..".")
    end,
})

-- report player location
minetest.register_chatcommand("where", {
    params = "",
    description = "report your position and orientation",
    privs = {},
    func = function(name, param)
        local player = minetest.env:get_player_by_name(name)
        local pos = player:getpos()
        minetest.chat_send_player(name, "Player "..name.." is at ("..pos.x..", "..pos.y..", "..pos.z..").")
    end,
})

print("hello from "..minetest.get_current_modname().." at "..minetest.get_modpath(minetest.get_current_modname()).."!")
