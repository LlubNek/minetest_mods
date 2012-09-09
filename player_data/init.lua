player_data = {}
player_data.player_data_path = minetest.get_worldpath().."/player_data.lua"

function player_data.save_player_data()
    local file = io.open(player_data.player_data_path, "w")
    file:write(minetest.serialize(player_data.player_data))
    file:close()
end

function player_data.load_player_data()
    local function exists(filename)
        local file = io.open(filename, "rb")
        if file == nil then
            return false
        end
        file:close()
        return true
    end

    if exists(player_data.player_data_path) then
        player_data.player_data = dofile(player_data.player_data_path)
    else
        player_data.player_data = {}
    end
end

function player_data.set_player_data(player, field, data)
    if type(player) ~= "string" then
        player = player:get_player_name()
    end
    if player_data.player_data[player] == nil then
        player_data.player_data[player] = {}
    end
    player_data.player_data[player][field] = data
    player_data.save_player_data()
end

function player_data.get_player_data(player, field)
    if type(player) ~= "string" then
        player = player:get_player_name()
    end
    if player_data.player_data[player] == nil then
        return nil
    end
    return player_data.player_data[player][field]
end

player_data.load_player_data()
print("hello from "..minetest.get_current_modname().." at "..minetest.get_modpath(minetest.get_current_modname()).."!")
