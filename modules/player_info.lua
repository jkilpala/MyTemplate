local M = {}
local state = {
	coins = 0,
	sounds_on = true,
	musics_on = true,
	language = 0,
	data_dirty = false,
}
function M:add_coins(v)
	state.coins = state.coins + v
	state.data_dirty = true
end
function M:remove_coins(v)
	state.data_dirty = true
	local temp_coins = state.coins - v
	if temp_coins >= 0 then
		state.coins = temp_coins
		return true
	else
		return false
	end
end
function M:get_coins()
	return state.coins
end

function M:set_music(v)
	state.musics_on = v
	state.data_dirty = true
end
function M:get_music()
	return state.musics_on
end

function M:set_sounds(v)
	state.sounds_on = v
end
function M:get_sounds()
	return state.sounds_on
end

function M:set_language(v)
	state.language = v
	state.data_dirty = true
end

function M:save_game(cb)
	if state.data_dirty then
		local filename = sys.get_save_file("myGame", "savegame")
		local success = sys.save(filename, state)
		state.data_dirty = false
		cb(success)
	end
end
function M:load_game(cb)
	local filename = sys.get_save_file("myGame", "savegame")
	local data = sys.load(filename)
	state = data
end
function M.new()
	return setmetatable(state, {__index = M })
end

return M