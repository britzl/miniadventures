local M = {}

function M.blink(sprite_url, interval)
	local on = true
	timer.delay(interval, true, function()
		on = not on
		msg.post(sprite_url, on and "enable" or "disable")
	end)
end


return M