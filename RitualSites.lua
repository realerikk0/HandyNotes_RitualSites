local ADDON_NAME = ...
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end

local PLUGIN_DISPLAY_NAME = "HandyNotes: Ritual Sites"
local MAP_DAGGERSPINE_POINT = 2594
local CATEGORY_SEAWEED = "seaweed"
local CATEGORY_LYNX = "lynx"

local locale = GetLocale()
local L = {
	["HandyNotes: Ritual Sites"] = "HandyNotes: Ritual Sites",
	["Ritual Site collectible points."] = "Ritual Site collectible points.",
	["Show map button"] = "Show map button",
	["Show the Ritual Sites filter button on the world map."] = "Show the Ritual Sites filter button on the world map.",
	["Show seaweed and soggy nest"] = "Show seaweed and soggy nest",
	["Show washed-up seaweed and the soggy nest."] = "Show washed-up seaweed and the soggy nest.",
	["Show void-touched lynx thickets"] = "Show void-touched lynx thickets",
	["Show rustling hidden thickets for the void-touched lynx collectible."] = "Show rustling hidden thickets for the void-touched lynx collectible.",
	["Washed-Up Seaweed"] = "Washed-Up Seaweed",
	["Has a chance to spawn the void-touched poisonfin."] = "Has a chance to spawn the void-touched poisonfin.",
	["Soggy Nest"] = "Soggy Nest",
	["Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet."] = "Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet.",
	["Rustling Hidden Thicket"] = "Rustling Hidden Thicket",
	["Click the thicket repeatedly until the void-touched lynx kitten becomes interactable."] = "Click the thicket repeatedly until the void-touched lynx kitten becomes interactable.",
	["Coordinates"] = "Coordinates",
	["Left-click: set in-game waypoint"] = "Left-click: set in-game waypoint",
	["Right-click: add TomTom waypoint"] = "Right-click: add TomTom waypoint",
	["Show all"] = "Show all",
	["Open HandyNotes options"] = "Open HandyNotes options"
}

if locale == "zhCN" then
	L = {
		["HandyNotes: Ritual Sites"] = "HandyNotes：仪式场地",
		["Ritual Site collectible points."] = "仪式场地收集点。",
		["Show map button"] = "显示地图按钮",
		["Show the Ritual Sites filter button on the world map."] = "在世界地图上显示仪式场地过滤按钮。",
		["Show seaweed and soggy nest"] = "显示海藻和湿漉漉的窝",
		["Show washed-up seaweed and the soggy nest."] = "显示冲上岸的海藻和湿漉漉的窝。",
		["Show void-touched lynx thickets"] = "显示虚触山猫草丛",
		["Show rustling hidden thickets for the void-touched lynx collectible."] = "显示虚触山猫收集用的沙沙响的隐秘草丛。",
		["Washed-Up Seaweed"] = "冲上岸的海藻",
		["Has a chance to spawn the void-touched poisonfin."] = "有几率刷出虚触毒鳍龙。",
		["Soggy Nest"] = "湿漉漉的窝",
		["Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet."] = "在这里使用湿透的山猫玩具，可获得虚空腐化的毒鳍龙宠物。",
		["Rustling Hidden Thicket"] = "沙沙响的隐秘草丛",
		["Click the thicket repeatedly until the void-touched lynx kitten becomes interactable."] = "反复点击草丛，直到虚空之触山猫幼崽可互动。",
		["Coordinates"] = "坐标",
		["Left-click: set in-game waypoint"] = "左键：设置游戏内导航点",
		["Right-click: add TomTom waypoint"] = "右键：添加 TomTom 路径点",
		["Show all"] = "显示全部",
		["Open HandyNotes options"] = "打开 HandyNotes 设置"
	}
end

local defaults = {
	showSeaweed = true,
	showLynx = true,
	showMapButton = true
}

HandyNotes_RitualSitesDB = HandyNotes_RitualSitesDB or {}
local db = HandyNotes_RitualSitesDB

local function GetOption(key)
	if db[key] == nil then
		return defaults[key]
	end
	return db[key]
end

local function Refresh()
	HandyNotes:SendMessage("HandyNotes_NotifyUpdate", ADDON_NAME)
end

local function SetOption(key, value)
	db[key] = value and true or false
	Refresh()
end

local function ToggleOption(key)
	SetOption(key, not GetOption(key))
end

local function ItemIcon(itemID, fallback)
	if C_Item and C_Item.GetItemIconByID then
		return C_Item.GetItemIconByID(itemID) or fallback
	end
	return fallback
end

local ICON_KELP = ItemIcon(270041, "Interface\\Icons\\INV_Misc_Herb_Seaweed")
local ICON_NEST = "Interface\\Icons\\INV_Misc_Basket_05"
local ICON_LYNX = ItemIcon(270063, "Interface\\Icons\\Ability_Druid_CatForm")

local nodes = {}
local mapButton

local function Coord(x, y)
	return HandyNotes:getCoord(x / 100, y / 100)
end

local function AddNode(x, y, category, title, note, icon, scale)
	nodes[Coord(x, y)] = {
		category = category,
		title = title,
		note = note,
		icon = icon,
		scale = scale or 1,
		alpha = 1
	}
end

local function AddKelp(x, y)
	AddNode(x, y, CATEGORY_SEAWEED, L["Washed-Up Seaweed"], L["Has a chance to spawn the void-touched poisonfin."], ICON_KELP, 1.15)
end

local function AddBush(x, y)
	AddNode(x, y, CATEGORY_LYNX, L["Rustling Hidden Thicket"], L["Click the thicket repeatedly until the void-touched lynx kitten becomes interactable."], ICON_LYNX, 1.1)
end

AddKelp(66.01, 73.85)
AddKelp(61.54, 77.22)
AddKelp(47.92, 72.06)
AddKelp(40.97, 72.43)
AddKelp(38.10, 63.62)
AddKelp(46.65, 46.02)
AddKelp(53.27, 55.43)
AddKelp(50.00, 55.24)

AddNode(30.03, 63.12, CATEGORY_SEAWEED, L["Soggy Nest"], L["Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet."], ICON_NEST, 1.1)

AddBush(66.40, 52.46)
AddBush(65.70, 51.60)
AddBush(55.00, 79.30)
AddBush(35.10, 44.50)
AddBush(68.46, 37.62)
AddBush(63.58, 65.58)
AddBush(42.03, 80.03)
AddBush(41.76, 49.69)
AddBush(43.31, 57.99)

local handler = {}

local function IsCategoryEnabled(category)
	if category == CATEGORY_SEAWEED then
		return GetOption("showSeaweed")
	elseif category == CATEGORY_LYNX then
		return GetOption("showLynx")
	end
	return true
end

local function Iter(pointData, prevCoord)
	if not pointData then return nil end

	local coord, node = next(pointData, prevCoord)
	while coord do
		if IsCategoryEnabled(node.category) then
			return coord, nil, node.icon, node.scale, node.alpha
		end
		coord, node = next(pointData, coord)
	end
end

function handler:GetNodes2(mapID)
	if mapID ~= MAP_DAGGERSPINE_POINT then
		return Iter, nil, nil
	end

	return Iter, nodes, nil
end

function handler:OnEnter(mapID, coord)
	local node = nodes[coord]
	if not node then return end

	local center = self:GetCenter()
	local parentCenter = UIParent:GetCenter()
	if center and parentCenter and center > parentCenter then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local x, y = HandyNotes:getXY(coord)
	GameTooltip:SetText(node.title)
	if node.note then
		GameTooltip:AddLine(node.note, 1, 1, 1, true)
	end
	GameTooltip:AddDoubleLine(L["Coordinates"], ("%.2f, %.2f"):format(x * 100, y * 100), 0.7, 0.7, 0.7, 0.7, 0.7, 0.7)
	GameTooltip:AddLine(L["Left-click: set in-game waypoint"], 0.5, 0.8, 1)
	if TomTom then
		GameTooltip:AddLine(L["Right-click: add TomTom waypoint"], 0.5, 0.8, 1)
	end
	GameTooltip:Show()
end

function handler:OnLeave()
	GameTooltip:Hide()
end

function handler:OnClick(button, down, mapID, coord)
	if down then return end

	local node = nodes[coord]
	if not node then return end

	local x, y = HandyNotes:getXY(coord)
	if button == "LeftButton" then
		if C_Map.CanSetUserWaypointOnMap(mapID) then
			C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y))
			C_SuperTrack.SetSuperTrackedUserWaypoint(true)
		end
	elseif button == "RightButton" and TomTom then
		TomTom:AddWaypoint(mapID, x, y, {
			title = node.title,
			persistent = false,
			minimap = true,
			world = true
		})
	end
end

local options = {
	type = "group",
	name = PLUGIN_DISPLAY_NAME,
	desc = L["Ritual Site collectible points."],
	get = function(info) return GetOption(info[#info]) end,
	set = function(info, value) SetOption(info[#info], value) end,
	args = {
		showSeaweed = {
			type = "toggle",
			name = L["Show seaweed and soggy nest"],
			desc = L["Show washed-up seaweed and the soggy nest."],
			order = 10
		},
		showLynx = {
			type = "toggle",
			name = L["Show void-touched lynx thickets"],
			desc = L["Show rustling hidden thickets for the void-touched lynx collectible."],
			order = 20
		},
		showMapButton = {
			type = "toggle",
			name = L["Show map button"],
			desc = L["Show the Ritual Sites filter button on the world map."],
			order = 30,
			set = function(info, value)
				SetOption(info[#info], value)
				if mapButton then
					mapButton:SetShown(value and WorldMapFrame and WorldMapFrame:GetMapID() == MAP_DAGGERSPINE_POINT)
				end
			end
		}
	}
}

HandyNotes:RegisterPluginDB(ADDON_NAME, handler, options)

local function OpenHandyNotesOptions()
	local AceConfigDialog = LibStub("AceConfigDialog-3.0", true)
	if AceConfigDialog then
		AceConfigDialog:Open("HandyNotes")
	elseif Settings and Settings.OpenToCategory then
		Settings.OpenToCategory("HandyNotes")
	elseif InterfaceOptionsFrame_OpenToCategory then
		InterfaceOptionsFrame_OpenToCategory("HandyNotes")
	end
end

local function ShowFilterMenu(owner)
	if MenuUtil and MenuUtil.CreateContextMenu then
		MenuUtil.CreateContextMenu(owner, function(_, rootDescription)
			rootDescription:CreateTitle(L["HandyNotes: Ritual Sites"])
			rootDescription:CreateCheckbox(L["Show seaweed and soggy nest"], function()
				return GetOption("showSeaweed")
			end, function()
				ToggleOption("showSeaweed")
			end)
			rootDescription:CreateCheckbox(L["Show void-touched lynx thickets"], function()
				return GetOption("showLynx")
			end, function()
				ToggleOption("showLynx")
			end)
			rootDescription:CreateDivider()
			rootDescription:CreateButton(L["Show all"], function()
				SetOption("showSeaweed", true)
				SetOption("showLynx", true)
			end)
			rootDescription:CreateButton(L["Open HandyNotes options"], OpenHandyNotesOptions)
		end)
		return
	end

	UIErrorsFrame:AddMessage(L["HandyNotes: Ritual Sites"] .. ": MenuUtil is not available.")
end

local function UpdateMapButton()
	if not mapButton or not WorldMapFrame then return end
	mapButton:SetShown(GetOption("showMapButton") and WorldMapFrame:IsShown() and WorldMapFrame:GetMapID() == MAP_DAGGERSPINE_POINT)
end

local function CreateWorldMapColumnButton()
	local WorldMapButtons = LibStub and LibStub("Krowi_WorldMapButtons-1.4", true)
	if not WorldMapButtons then return false end

	local templateName = ADDON_NAME .. "WorldMapOptionsButtonTemplate"
	local ok, registeredButton = pcall(function()
		return WorldMapButtons:Add(templateName, "DROPDOWNTOGGLEBUTTON")
	end)
	if ok and registeredButton then
		mapButton = registeredButton
		mapButton:SetScript("OnClick", ShowFilterMenu)
		mapButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:SetText(L["HandyNotes: Ritual Sites"])
			GameTooltip:AddLine(L["Show seaweed and soggy nest"], GetOption("showSeaweed") and 0.4 or 0.8, GetOption("showSeaweed") and 1 or 0.4, 0.4)
			GameTooltip:AddLine(L["Show void-touched lynx thickets"], GetOption("showLynx") and 0.4 or 0.8, GetOption("showLynx") and 1 or 0.4, 0.4)
			GameTooltip:Show()
		end)
		mapButton:SetScript("OnLeave", GameTooltip_Hide)
		UpdateMapButton()
		return true
	end

	return false
end

local function CreateMapButton()
	if mapButton or not WorldMapFrame then return end
	if not CreateWorldMapColumnButton() then return end

	WorldMapFrame:HookScript("OnShow", UpdateMapButton)
	WorldMapFrame:HookScript("OnHide", UpdateMapButton)
	if WorldMapFrame.SetMapID then
		hooksecurefunc(WorldMapFrame, "SetMapID", function()
			C_Timer.After(0, UpdateMapButton)
		end)
	end
	if WorldMapFrame.OnMapChanged then
		hooksecurefunc(WorldMapFrame, "OnMapChanged", UpdateMapButton)
	end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", CreateMapButton)
if C_Timer then
	C_Timer.After(0, CreateMapButton)
end
