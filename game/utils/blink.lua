local M = {}

function M.blink(sprite_url, interval)
	local on = true
	timer.repeating(interval, function()
		on = not on
		msg.post(sprite_url, on and "enable" or "disable")
	end)
end


return M