-- v. 0.2
-- Push subtitles to clipboard
-- in linux needs xsel or xclip to work
--
-- default keybinding to start/stop: Y

-- verify which command to use (false if none is found)
local clipboard = package.config:sub(1,1) == '\\' and 'clip.exe' or                 -- Windows
	(pcall(function () io.popen('pbcopy'):close() end)) and 'pbcopy' or         -- MacOS
	os.execute('xsel -h > /dev/null 2>&1') and 'xsel -z -b' or                  -- xsel
	os.execute('xclip -h > /dev/null 2>&1') and 'xclip -i -selection clipboard' -- xclip

local running

local function toclipboard(name, value)
	if running and type(value) == 'string' then
		io.popen(clipboard, 'w'):write(value):close()
	end
end

local function stop()
	running = false
	mp.msg.warn('Quitting Yomichampv ...')
	mp.unregister_event('end-file', stop)
	mp.unobserve_property('sub-text', 'string', toclipboard)
	mp.remove_key_binding('Yomichampv-pause')
	mp.remove_key_binding('Yomichampv-resume')
end

-- get_active_subtrack from huglovefan/mpv-subside.lua
local function get_active_subtrack ()
	local l = mp.get_property_native('track-list')
	for _, t in ipairs(l) do
		if t.type == 'sub' and t.selected then
			return t.lang
		end
	end
	return 'no'
end

local function start_stop()
	if running then
		stop()
		mp.command('show-text "Quitting Yomichampv..."')
	else
		if get_active_subtrack() ~= 'ja' then
			mp.command('show-text "Select japanese subtitles before' ..
				' starting Yomichampv."')
		else
			running = true

			mp.register_event('end-file', stop)
			mp.observe_property('sub-text', 'string', toclipboard)

			mp.add_forced_key_binding('mouse_leave', 'Yomichampv-pause',
				function () mp.set_property_native('pause', true) end)

			mp.add_forced_key_binding('mouse_move', 'Yomichampv-resume',
				function () mp.set_property_native('pause', false) end)

			mp.command('show-text "Starting Yomichampv..."')
		end
	end
end

mp.add_key_binding('y', 'start-stop-Yomichampv', start_stop)
