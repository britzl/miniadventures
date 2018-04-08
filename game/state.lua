local file = require "ludobits.m.io.file"

local FILENAME = "save"

local M = {}

local state = {}

local function get_level_state(level_id)
	level_id = hash_to_hex(level_id)
	state.levels[level_id] = state.levels[level_id] or { deleted_objects = {} }
	return state.levels[level_id]
end

function M.load()
	state = sys.load(file.get_save_file_path(FILENAME)) or {}
	state.levels = state.levels or {}
	pprint(state)
end

function M.save()
	sys.save(file.get_save_file_path(FILENAME), state)
end

function M.reset()
	state = {}
	M.save()
	M.load()
end

function M.game_object_deleted(level_id, id)
	print("game_object_deleted")
	table.insert(get_level_state(level_id).deleted_objects, id)
	M.save()
end


function M.delete_game_objects(level_id)
	go.delete(get_level_state(level_id).deleted_objects)
end


return M