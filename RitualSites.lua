local ADDON_NAME = ...
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end

local MAP_DAGGERSPINE_POINT = 2594

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

local function Coord(x, y)
	return HandyNotes:getCoord(x / 100, y / 100)
end

local function AddNode(x, y, title, note, icon, scale)
	nodes[Coord(x, y)] = {
		title = title,
		note = note,
		icon = icon,
		scale = scale or 1,
		alpha = 1
	}
end

local function AddKelp(x, y)
	AddNode(x, y, "冲上岸的海藻", "有几率刷出虚触毒鳍龙。", ICON_KELP, 1.15)
end

local function AddBush(x, y)
	AddNode(x, y, "沙沙响的隐秘草丛", "反复点击草丛，直到虚空之触山猫幼崽可互动。", ICON_LYNX, 1.1)
end

AddKelp(66.01, 73.85)
AddKelp(61.54, 77.22)
AddKelp(47.92, 72.06)
AddKelp(40.97, 72.43)
AddKelp(38.10, 63.62)
AddKelp(46.65, 46.02)
AddKelp(53.27, 55.43)
AddKelp(50.00, 55.24)

AddNode(30.03, 63.12, "湿漉漉的窝", "在这里使用湿透的山猫玩具，可获得虚空腐化的毒鳍龙宠物。", ICON_NEST, 1.1)

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

local function Iter(pointData, prevCoord)
	if not pointData then return nil end

	local coord, node = next(pointData, prevCoord)
	if coord then
		return coord, nil, node.icon, node.scale, node.alpha
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
	GameTooltip:AddDoubleLine("坐标", ("%.2f, %.2f"):format(x * 100, y * 100), 0.7, 0.7, 0.7, 0.7, 0.7, 0.7)
	GameTooltip:AddLine("左键：设置游戏内导航点", 0.5, 0.8, 1)
	if TomTom then
		GameTooltip:AddLine("右键：添加 TomTom 路径点", 0.5, 0.8, 1)
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
	name = "HandyNotes: Ritual Sites",
	desc = "Ritual Site collectible points.",
	args = {}
}

HandyNotes:RegisterPluginDB(ADDON_NAME, handler, options)
