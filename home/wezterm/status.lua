local wezterm = require("wezterm")

local DEFAULT_FG = { Color = "#9a9eab" }
local DEFAULT_BG = { Color = "#333333" }

local SPACE_1 = " "
local SPACE_2 = "  "
local SPACE_3 = "   "

local HEADER_KEY_NORMAL = { Foreground = DEFAULT_FG, Text = "" }
local HEADER_LEADER = { Foreground = { Color = "#ffffff" }, Text = "" }
local HEADER_IME = { Foreground = DEFAULT_FG, Text = "あ" }

local function AddIcon(elems, icon)
	table.insert(elems, { Foreground = icon.Foreground })
	table.insert(elems, { Background = DEFAULT_BG })
	table.insert(elems, { Text = SPACE_1 .. icon.Text .. SPACE_3 })
end

local function GetKeyboard(elems, window)
	if window:leader_is_active() then
		AddIcon(elems, HEADER_LEADER)
		return
	end

	AddIcon(elems, window:composition_status() and HEADER_IME or HEADER_KEY_NORMAL)
end

local function LeftUpdate(window, pane)
	local elems = {}

	GetKeyboard(elems, window)

	window:set_left_status(wezterm.format(elems))
end

local HEADER_HOST = { Foreground = { Color = "#75b1a9" }, Text = "" }
local HEADER_CWD = { Foreground = { Color = "#92aac7" }, Text = "" }
local HEADER_DATE = { Foreground = { Color = "#ffccac" }, Text = "󱪺" }
local HEADER_TIME = { Foreground = { Color = "#bcbabe" }, Text = "" }
local HEADER_BATTERY = { Foreground = { Color = "#dfe166" }, Text = "" }

local function AddElement(elems, header, str)
	table.insert(elems, { Foreground = header.Foreground })
	table.insert(elems, { Background = DEFAULT_BG })
	table.insert(elems, { Text = header.Text .. SPACE_2 })

	table.insert(elems, { Foreground = DEFAULT_FG })
	table.insert(elems, { Background = DEFAULT_BG })
	table.insert(elems, { Text = str .. SPACE_3 })
end

local function GetHostAndCwd(elems, pane)
	-- local uri = pane:get_current_working_dir()

	-- if not uri then
	-- 	return
	-- end

	-- local cwd_uri = uri.file_path -- uri:sub(8)
	-- local slash = cwd_uri:find("/")

	-- if not slash then
	-- 	return
	-- end

	-- local host = cwd_uri:sub(1, slash - 1)
	-- local dot = host:find("[.]")
	local cwd = ""
	local hostname = ""

	local cwd_uri = pane:get_current_working_dir()
	if not cwd_uri then
		return
	end

	if type(cwd_uri) == "userdata" then
		-- newer version
		cwd = cwd_uri.file_path
		hostname = cwd_uri.host or wezterm.hostname()
	else
		-- older version (20230712-072601-f4abf8fd or earlier,
		-- which doesn't have the Url object)
		cwd_uri = cwd_uri:sub(8)
		local slash = cwd_uri:find("/")
		if slash then
			hostname = cwd_uri:sub(1, slash - 1)
			-- extract cwd from uri
			cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
				return string.char(tonumber(hex, 16))
			end)
		end
	end

	AddElement(elems, HEADER_HOST, hostname)
	AddElement(elems, HEADER_CWD, cwd)
end

local function GetDate(elems)
	AddElement(elems, HEADER_DATE, wezterm.strftime("%a %b %-d"))
end

local function GetTime(elems)
	AddElement(elems, HEADER_TIME, wezterm.strftime("%H:%M"))
end

local function GetBattery(elems, window)
	if not window:get_dimensions().is_full_screen then
		return
	end

	for _, b in ipairs(wezterm.battery_info()) do
		AddElement(elems, HEADER_BATTERY, string.format("%.0f%%", b.state_of_charge * 100))
	end
end

local function RightUpdate(window, pane)
	local elems = {}

	GetHostAndCwd(elems, pane)
	GetDate(elems)
	GetBattery(elems, window)
	GetTime(elems)

	window:set_right_status(wezterm.format(elems))
end

wezterm.on("update-status", function(window, pane)
	LeftUpdate(window, pane)
	RightUpdate(window, pane)
end)
