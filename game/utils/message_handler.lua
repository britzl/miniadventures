local M = {}


local function tohash(message_id)
	return type(message_id) == "string" and hash(message_id) or message_id
end


function M.create()
	local handler = {}

	local listeners = {}

	local function set_listeners(message_id, fn)
		message_id = tohash(message_id)
		listeners[message_id] = fn
	end
	
	function handler.register(message_id, fn)
		set_listeners(message_id, fn)
	end

	function handler.unregister(message_id, fn)
		set_listeners(message_id, nil)
	end

	function handler.handle(message_id, message, sender)
		message_id = tohash(message_id)
		if listeners[message_id] then
			listeners[message_id](message, sender)
		end
	end

	return handler
end

return M