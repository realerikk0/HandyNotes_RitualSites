local ADDON_NAME = ...

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then
    return
end

local MAP_DAGGERSPINE_POINT = 2594
local MAP_BROKEN_THRONE = 2585
local CATEGORY_SEAWEED = "seaweed"
local CATEGORY_LYNX = "lynx"
local CATEGORY_BROKEN_THRONE_REWARDS = "brokenThroneRewards"
local CATEGORY_BROKEN_THRONE_CHALLENGES = "brokenThroneChallenges"
local DEFAULT_LOCALE = "enUS"
local LANGUAGE_AUTO = "auto"

local TRANSLATIONS = {
    enUS = {
        ["HandyNotes: Ritual Sites"] = "HandyNotes: Ritual Sites",
        ["Ritual Site collectible points."] = "Ritual Site collectible and challenge unlock points.",
        ["Display"] = "Display",
        ["Categories"] = "Categories",
        ["Language"] = "Language",
        ["Game language"] = "Game language",
        ["Choose the language used by this plugin."] = "Choose the language used by this plugin.",
        ["Show world map filter button"] = "Show world map filter button",
        ["Show the Ritual Sites filter button on the world map."] = "Show the Ritual Sites filter button on the world map.",
        ["Show markers on minimap"] = "Show markers on minimap",
        ["Show Ritual Sites markers on the minimap."] = "Show Ritual Sites markers on the minimap.",
        ["Icon scale"] = "Icon scale",
        ["Adjust the size of Ritual Sites markers."] = "Adjust the size of Ritual Sites markers.",
        ["Icon alpha"] = "Icon alpha",
        ["Adjust the transparency of Ritual Sites markers."] = "Adjust the transparency of Ritual Sites markers.",
        ["Show seaweed and soggy nest"] = "Show seaweed and soggy nest",
        ["Show washed-up seaweed and the soggy nest."] = "Show washed-up seaweed and the soggy nest.",
        ["Show void-touched lynx thickets"] = "Show void-touched lynx thickets",
        ["Show rustling hidden thickets for the void-touched lynx collectible."] = "Show rustling hidden thickets for the void-touched lynx collectible.",
        ["Show Broken Throne rewards"] = "Show Broken Throne rewards",
        ["Show fixed Broken Throne collectible and reward points."] = "Show fixed Broken Throne collectible and reward points.",
        ["Show Broken Throne challenge unlocks"] = "Show Broken Throne challenge unlocks",
        ["Show Malevolent Boons obelisks and the tainted bone pile."] = "Show Malevolent Boons obelisks and the tainted bone pile.",
        ["Reset filters"] = "Reset filters",
        ["Restore all Ritual Sites filters to defaults."] = "Restore all Ritual Sites filters to defaults.",
        ["Washed-Up Seaweed"] = "Washed-Up Seaweed",
        ["Has a chance to spawn the void-touched poisonfin."] = "Has a chance to spawn the void-touched poisonfin.",
        ["Soggy Nest"] = "Soggy Nest",
        ["Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet."] = "Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet.",
        ["Rustling Hidden Thicket"] = "Rustling Hidden Thicket",
        ["Click the thicket repeatedly until the void-touched lynx kitten becomes interactable."] = "Click the thicket repeatedly until the void-touched lynx kitten becomes interactable.",
        ["Misplaced Ritual Candle"] = "Misplaced Ritual Candle",
        ["Bring this candle to the nearby ritual circle to repair the Void Eagle ritual."] = "Bring this candle to the nearby ritual circle to repair the Void Eagle ritual.",
        ["Void Eagle Ritual Site"] = "Void Eagle Ritual Site",
        ["Repair the circle with the misplaced ritual candle, then start the ritual for the Void-Corrupted Hex Eagle."] = "Repair the circle with the misplaced ritual candle, then start the ritual for the Void-Corrupted Hex Eagle.",
        ["Void Eagle Wind Gale"] = "Void Eagle Wind Gale",
        ["Use the Void Eagle mount and follow the feather trail to this gale for the Void-Scarred Eaglet."] = "Use the Void Eagle mount and follow the feather trail to this gale for the Void-Scarred Eaglet.",
        ["Lost Bear Cub"] = "Lost Bear Cub",
        ["Feed the hidden Lost Bear Cub 1 Practically Pork to receive the Chubs pet."] = "Feed the hidden Lost Bear Cub 1 Practically Pork to receive the Chubs pet.",
        ["Pile of Meat Carcasses"] = "Pile of Meat Carcasses",
        ["Summon Chubs here and feed the bear mother 5 Practically Pork for the mount."] = "Summon Chubs here and feed the bear mother 5 Practically Pork for the mount.",
        ["Malevolent Boons Obelisk"] = "Malevolent Boons Obelisk",
        ["Walk up to these obelisks for the Malevolent Boons challenge unlock."] = "Walk up to these obelisks for the Malevolent Boons challenge unlock.",
        ["Tainted Bone Pile"] = "Tainted Bone Pile",
        ["Loot this bone pile to start the Tainted Corpses challenge unlock quest."] = "Loot this bone pile to start the Tainted Corpses challenge unlock quest.",
        ["Coordinates"] = "Coordinates",
        ["Left-click: set in-game waypoint"] = "Left-click: set in-game waypoint",
        ["Right-click: add TomTom waypoint"] = "Right-click: add TomTom waypoint",
        ["Show all"] = "Show all",
        ["Open HandyNotes options"] = "Open HandyNotes options",
    },
    zhCN = {
        ["HandyNotes: Ritual Sites"] = "HandyNotes: Ritual Sites（仪式场地）",
        ["Ritual Site collectible points."] = "仪式场地收集和挑战解锁点。",
        ["Display"] = "显示",
        ["Categories"] = "类别",
        ["Language"] = "语言",
        ["Game language"] = "游戏语言",
        ["Choose the language used by this plugin."] = "选择此插件使用的语言。",
        ["Show world map filter button"] = "显示世界地图过滤按钮",
        ["Show the Ritual Sites filter button on the world map."] = "在世界地图上显示仪式场地过滤按钮。",
        ["Show markers on minimap"] = "在小地图显示标记",
        ["Show Ritual Sites markers on the minimap."] = "在小地图上显示仪式场地标记。",
        ["Icon scale"] = "图标大小",
        ["Adjust the size of Ritual Sites markers."] = "调整仪式场地标记的大小。",
        ["Icon alpha"] = "图标透明度",
        ["Adjust the transparency of Ritual Sites markers."] = "调整仪式场地标记的透明度。",
        ["Show seaweed and soggy nest"] = "显示海藻和湿漉漉的窝",
        ["Show washed-up seaweed and the soggy nest."] = "显示冲上岸的海藻和湿漉漉的窝。",
        ["Show void-touched lynx thickets"] = "显示虚触山猫草丛",
        ["Show rustling hidden thickets for the void-touched lynx collectible."] = "显示虚触山猫收集用的沙沙响的隐秘草丛。",
        ["Show Broken Throne rewards"] = "显示残破神庙奖励点",
        ["Show fixed Broken Throne collectible and reward points."] = "显示残破神庙内固定的收集和奖励点。",
        ["Show Broken Throne challenge unlocks"] = "显示残破神庙挑战解锁点",
        ["Show Malevolent Boons obelisks and the tainted bone pile."] = "显示恶意赐福方尖碑和腐化骨堆。",
        ["Reset filters"] = "重置过滤",
        ["Restore all Ritual Sites filters to defaults."] = "将所有仪式场地过滤设置恢复为默认值。",
        ["Washed-Up Seaweed"] = "冲上岸的海藻",
        ["Has a chance to spawn the void-touched poisonfin."] = "有几率刷出虚触毒鳍龙。",
        ["Soggy Nest"] = "湿漉漉的窝",
        ["Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet."] = "在这里使用湿透的山猫玩具，可获得虚空腐化的毒鳍龙宠物。",
        ["Rustling Hidden Thicket"] = "沙沙响的隐秘草丛",
        ["Click the thicket repeatedly until the void-touched lynx kitten becomes interactable."] = "反复点击草丛，直到虚空之触山猫幼崽可互动。",
        ["Misplaced Ritual Candle"] = "遗失的仪式蜡烛",
        ["Bring this candle to the nearby ritual circle to repair the Void Eagle ritual."] = "将这支蜡烛带到附近的仪式法阵，用来修复虚空雄鹰仪式。",
        ["Void Eagle Ritual Site"] = "虚空雄鹰仪式地点",
        ["Repair the circle with the misplaced ritual candle, then start the ritual for the Void-Corrupted Hex Eagle."] = "用遗失的仪式蜡烛修复法阵，然后启动仪式召唤虚空腐化的妖术雄鹰。",
        ["Void Eagle Wind Gale"] = "虚空雄鹰风涡",
        ["Use the Void Eagle mount and follow the feather trail to this gale for the Void-Scarred Eaglet."] = "骑乘虚空雄鹰并沿羽毛轨迹来到这里，可前往虚染雏鹰的巢。",
        ["Lost Bear Cub"] = "走失的熊崽",
        ["Feed the hidden Lost Bear Cub 1 Practically Pork to receive the Chubs pet."] = "喂给隐藏的走失熊崽 1 份 Practically Pork，可获得 Chubs 宠物。",
        ["Pile of Meat Carcasses"] = "肉尸堆",
        ["Summon Chubs here and feed the bear mother 5 Practically Pork for the mount."] = "在这里召唤 Chubs，并喂给熊妈妈 5 份 Practically Pork 以获得坐骑。",
        ["Malevolent Boons Obelisk"] = "恶意赐福方尖碑",
        ["Walk up to these obelisks for the Malevolent Boons challenge unlock."] = "靠近这些方尖碑以解锁恶意赐福挑战。",
        ["Tainted Bone Pile"] = "腐化骨堆",
        ["Loot this bone pile to start the Tainted Corpses challenge unlock quest."] = "拾取这个骨堆以开始腐化尸骸挑战解锁任务。",
        ["Coordinates"] = "坐标",
        ["Left-click: set in-game waypoint"] = "左键：设置游戏内导航点",
        ["Right-click: add TomTom waypoint"] = "右键：添加 TomTom 路径点",
        ["Show all"] = "显示全部",
        ["Open HandyNotes options"] = "打开 HandyNotes 设置",
    },
    ruRU = {
        ["HandyNotes: Ritual Sites"] = "HandyNotes: Ritual Sites",
        ["Ritual Site collectible points."] = "Точки коллекционных предметов и открытия испытаний в местах ритуалов.",
        ["Display"] = "Отображение",
        ["Categories"] = "Категории",
        ["Language"] = "Язык",
        ["Game language"] = "Язык игры",
        ["Choose the language used by this plugin."] = "Выберите язык, используемый этим аддоном.",
        ["Show world map filter button"] = "Кнопка фильтра на карте мира",
        ["Show the Ritual Sites filter button on the world map."] = "Показывать кнопку фильтра мест ритуалов на карте мира.",
        ["Show markers on minimap"] = "Метки на миникарте",
        ["Show Ritual Sites markers on the minimap."] = "Показывать метки мест ритуалов на миникарте.",
        ["Icon scale"] = "Масштаб значков",
        ["Adjust the size of Ritual Sites markers."] = "Настройка размера меток мест ритуалов.",
        ["Icon alpha"] = "Прозрачность значков",
        ["Adjust the transparency of Ritual Sites markers."] = "Настройка прозрачности меток мест ритуалов.",
        ["Show seaweed and soggy nest"] = "Водоросли и Промокшее гнездо",
        ["Show washed-up seaweed and the soggy nest."] = "Показывать выброшенные водоросли и Промокшее гнездо.",
        ["Show void-touched lynx thickets"] = "Шуршащий куст",
        ["Show rustling hidden thickets for the void-touched lynx collectible."] = "Показывать Шуршащие кусты для Меченного Бездной рысенка.",
        ["Show Broken Throne rewards"] = "Награды Расколотого Трона",
        ["Show fixed Broken Throne collectible and reward points."] = "Показывать фиксированные точки коллекционных предметов и наград в Расколотом Троне.",
        ["Show Broken Throne challenge unlocks"] = "Испытания Расколотого Трона",
        ["Show Malevolent Boons obelisks and the tainted bone pile."] = "Показывать обелиски Злобных даров и Оскверненную кучу костей.",
        ["Reset filters"] = "Сбросить фильтры",
        ["Restore all Ritual Sites filters to defaults."] = "Сбросить все фильтры мест ритуалов по умолчанию.",
        ["Washed-Up Seaweed"] = "Выброшенные на берег водоросли",
        ["Has a chance to spawn the void-touched poisonfin."] = "Может призвать Меченного Бездной морского варана.",
        ["Soggy Nest"] = "Промокшее гнездо",
        ["Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet."] = "Используйте здесь Слюнявую рысью игрушку, чтобы получить питомца Омытый Бездной морской варан.",
        ["Rustling Hidden Thicket"] = "Шуршащий куст",
        ["Click the thicket repeatedly until the void-touched lynx kitten becomes interactable."] = "Нажимайте на куст, пока рысь не станет доступна для взаимодействия.",
        ["Misplaced Ritual Candle"] = "Потерянная ритуальная свеча",
        ["Bring this candle to the nearby ritual circle to repair the Void Eagle ritual."] = "Отнесите эту свечу к ближайшему ритуальному кругу, чтобы восстановить ритуал орла Бездны.",
        ["Void Eagle Ritual Site"] = "Место ритуала орла Бездны",
        ["Repair the circle with the misplaced ritual candle, then start the ritual for the Void-Corrupted Hex Eagle."] = "Восстановите круг потерянной ритуальной свечой, затем начните ритуал для Оскверненного Бездной орла.",
        ["Void Eagle Wind Gale"] = "Порыв ветра орла Бездны",
        ["Use the Void Eagle mount and follow the feather trail to this gale for the Void-Scarred Eaglet."] = "Используйте верхового орла Бездны и следуйте по следу перьев к этому потоку для питомца.",
        ["Lost Bear Cub"] = "Потерявшийся медвежонок",
        ["Feed the hidden Lost Bear Cub 1 Practically Pork to receive the Chubs pet."] = "Накормите спрятанного медвежонка х1 Почти свинина, чтобы получить питомца Пухляша.",
        ["Pile of Meat Carcasses"] = "Куча мясных туш",
        ["Summon Chubs here and feed the bear mother 5 Practically Pork for the mount."] = "Призовите здесь Пухляша и скормите медведице х5 Почти свинина, чтобы получить ездовое животное.",
        ["Malevolent Boons Obelisk"] = "Обелиск Злобных даров",
        ["Walk up to these obelisks for the Malevolent Boons challenge unlock."] = "Подойдите к этим обелискам, чтобы открыть испытание Зловещих даров.",
        ["Tainted Bone Pile"] = "Оскверненная груда костей",
        ["Loot this bone pile to start the Tainted Corpses challenge unlock quest."] = "Обыщите эту кучу костей, чтобы начать задание на открытие испытания Оскверненных трупов.",
        ["Coordinates"] = "Координаты",
        ["Left-click: set in-game waypoint"] = "ЛКМ: установить игровую метку",
        ["Right-click: add TomTom waypoint"] = "ПКМ: добавить точку TomTom",
        ["Show all"] = "Показать все",
        ["Open HandyNotes options"] = "Открыть настройки HandyNotes",
    },
}

local LANGUAGE_NAMES = {
    [LANGUAGE_AUTO] = "Game language",
    enUS = "English",
    zhCN = "简体中文",
    ruRU = "Русский",
}

local defaults = {
    language = LANGUAGE_AUTO,
    showMapButton = true,
    showMinimap = true,
    iconScale = 1,
    iconAlpha = 1,
    showSeaweed = true,
    showLynx = true,
    showBrokenThroneRewards = true,
    showBrokenThroneChallenges = true,
}

local resettableDefaults = {
    showMapButton = true,
    showMinimap = true,
    iconScale = 1,
    iconAlpha = 1,
    showSeaweed = true,
    showLynx = true,
    showBrokenThroneRewards = true,
    showBrokenThroneChallenges = true,
}

HandyNotes_RitualSitesDB = HandyNotes_RitualSitesDB or {}
local db = HandyNotes_RitualSitesDB

local mapButton
local worldMapButtons
local UpdateMapButton

local function GetOption(key)
    if db[key] == nil then
        return defaults[key]
    end
    return db[key]
end

local function GetNumberOption(key)
    return tonumber(GetOption(key)) or defaults[key] or 1
end

local function GetActiveLocale()
    local language = GetOption("language")
    if language ~= LANGUAGE_AUTO and TRANSLATIONS[language] then
        return language
    end

    local gameLocale = GetLocale()
    if TRANSLATIONS[gameLocale] then
        return gameLocale
    end

    return DEFAULT_LOCALE
end

local function T(key)
    local localeTable = TRANSLATIONS[GetActiveLocale()] or TRANSLATIONS[DEFAULT_LOCALE]
    return localeTable[key] or TRANSLATIONS[DEFAULT_LOCALE][key] or key
end

local function Refresh()
    HandyNotes:SendMessage("HandyNotes_NotifyUpdate", ADDON_NAME)
end

local function NotifyOptionsChanged()
    local AceConfigRegistry = LibStub("AceConfigRegistry-3.0", true)
    if AceConfigRegistry then
        AceConfigRegistry:NotifyChange("HandyNotes")
    end
end

local function SetOption(key, value)
    db[key] = value
    Refresh()
    NotifyOptionsChanged()
    if UpdateMapButton then
        UpdateMapButton()
    end
end

local function ToggleOption(key)
    SetOption(key, not GetOption(key))
end

local function ResetOptions()
    for key, value in pairs(resettableDefaults) do
        db[key] = value
    end
    Refresh()
    NotifyOptionsChanged()
    if UpdateMapButton then
        UpdateMapButton()
    end
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
local ICON_CANDLE = 133750
local ICON_RITUAL = ItemIcon(269828, "Interface\\Icons\\Spell_Shadow_Rune")
local ICON_WIND = 136018
local ICON_BEAR = ItemIcon(269836, 132183)
local ICON_MEAT = 350568
local ICON_OBELISK = 136210
local ICON_BONE = 236946

local nodesByMap = {}

local function Coord(x, y)
    return HandyNotes:getCoord(x / 100, y / 100)
end

local function GetMapNodes(mapID)
    if not nodesByMap[mapID] then
        nodesByMap[mapID] = {}
    end
    return nodesByMap[mapID]
end

local function AddNode(mapID, x, y, category, titleKey, noteKey, icon, scale, titleSuffix)
    GetMapNodes(mapID)[Coord(x, y)] = {
        category = category,
        titleKey = titleKey,
        titleSuffix = titleSuffix,
        noteKey = noteKey,
        icon = icon,
        scale = scale or 1,
        alpha = 1,
    }
end

local function GetNode(mapID, coord)
    local pointData = nodesByMap[mapID]
    if pointData then
        return pointData[coord]
    end
end

local function GetNodeTitle(node)
    return T(node.titleKey) .. (node.titleSuffix or "")
end

local function IsSupportedMap(mapID)
    return nodesByMap[mapID] ~= nil
end

local function AddKelp(x, y)
    AddNode(MAP_DAGGERSPINE_POINT, x, y, CATEGORY_SEAWEED, "Washed-Up Seaweed", "Has a chance to spawn the void-touched poisonfin.", ICON_KELP, 1.15)
end

local function AddBush(x, y)
    AddNode(MAP_DAGGERSPINE_POINT, x, y, CATEGORY_LYNX, "Rustling Hidden Thicket", "Click the thicket repeatedly until the void-touched lynx kitten becomes interactable.", ICON_LYNX, 1.1)
end

local function AddBrokenThroneReward(x, y, titleKey, noteKey, icon, scale)
    AddNode(MAP_BROKEN_THRONE, x, y, CATEGORY_BROKEN_THRONE_REWARDS, titleKey, noteKey, icon, scale)
end

local function AddBrokenThroneChallenge(x, y, titleKey, noteKey, icon, scale, titleSuffix)
    AddNode(MAP_BROKEN_THRONE, x, y, CATEGORY_BROKEN_THRONE_CHALLENGES, titleKey, noteKey, icon, scale, titleSuffix)
end

local function AddBrokenThroneObelisk(index, x, y)
    AddBrokenThroneChallenge(x, y, "Malevolent Boons Obelisk", "Walk up to these obelisks for the Malevolent Boons challenge unlock.", ICON_OBELISK, 1.05, (" #%d"):format(index))
end

AddKelp(66.01, 73.85)
AddKelp(61.54, 77.22)
AddKelp(47.92, 72.06)
AddKelp(40.97, 72.43)
AddKelp(38.10, 63.62)
AddKelp(46.65, 46.02)
AddKelp(53.27, 55.43)
AddKelp(50.00, 55.24)
AddNode(MAP_DAGGERSPINE_POINT, 30.03, 63.12, CATEGORY_SEAWEED, "Soggy Nest", "Use the soggy lynx toy here to obtain the void-corrupted poisonfin pet.", ICON_NEST, 1.1)

AddBush(66.40, 52.46)
AddBush(65.70, 51.60)
AddBush(55.00, 79.30)
AddBush(35.10, 44.50)
AddBush(68.46, 37.62)
AddBush(63.58, 65.58)
AddBush(42.03, 80.03)
AddBush(41.76, 49.69)
AddBush(43.31, 57.99)

AddBrokenThroneReward(51.50, 47.80, "Misplaced Ritual Candle", "Bring this candle to the nearby ritual circle to repair the Void Eagle ritual.", ICON_CANDLE, 1.05)
AddBrokenThroneReward(50.64, 47.42, "Void Eagle Ritual Site", "Repair the circle with the misplaced ritual candle, then start the ritual for the Void-Corrupted Hex Eagle.", ICON_RITUAL, 1.15)
AddBrokenThroneReward(49.47, 77.94, "Void Eagle Wind Gale", "Use the Void Eagle mount and follow the feather trail to this gale for the Void-Scarred Eaglet.", ICON_WIND, 1.1)
AddBrokenThroneReward(55.82, 49.63, "Lost Bear Cub", "Feed the hidden Lost Bear Cub 1 Practically Pork to receive the Chubs pet.", ICON_BEAR, 1.1)
AddBrokenThroneReward(55.66, 38.85, "Pile of Meat Carcasses", "Summon Chubs here and feed the bear mother 5 Practically Pork for the mount.", ICON_MEAT, 1.1)

AddBrokenThroneObelisk(1, 61.00, 50.00)
AddBrokenThroneObelisk(2, 41.00, 50.00)
AddBrokenThroneObelisk(3, 45.00, 59.00)
AddBrokenThroneObelisk(4, 42.00, 68.00)
AddBrokenThroneObelisk(5, 55.00, 58.00)
AddBrokenThroneObelisk(6, 54.00, 54.00)
AddBrokenThroneChallenge(48.00, 36.50, "Tainted Bone Pile", "Loot this bone pile to start the Tainted Corpses challenge unlock quest.", ICON_BONE, 1.1)

local function IsCategoryEnabled(category)
    if category == CATEGORY_SEAWEED then
        return GetOption("showSeaweed")
    end
    if category == CATEGORY_LYNX then
        return GetOption("showLynx")
    end
    if category == CATEGORY_BROKEN_THRONE_REWARDS then
        return GetOption("showBrokenThroneRewards")
    end
    if category == CATEGORY_BROKEN_THRONE_CHALLENGES then
        return GetOption("showBrokenThroneChallenges")
    end
    return true
end

local handler = {}

local function Iter(pointData, prevCoord)
    if not pointData then
        return nil
    end

    local coord, node = next(pointData, prevCoord)
    while coord do
        if IsCategoryEnabled(node.category) then
            return coord, nil, node.icon, node.scale * GetNumberOption("iconScale"), node.alpha * GetNumberOption("iconAlpha")
        end
        coord, node = next(pointData, coord)
    end
end

function handler:GetNodes2(mapID, isMinimap)
    local pointData = nodesByMap[mapID]
    if not pointData then
        return Iter, nil, nil
    end
    if isMinimap and not GetOption("showMinimap") then
        return Iter, nil, nil
    end
    return Iter, pointData, nil
end

function handler:OnEnter(mapID, coord)
    local node = GetNode(mapID, coord)
    if not node then
        return
    end

    local center = self:GetCenter()
    local parentCenter = UIParent:GetCenter()
    if center and parentCenter and center > parentCenter then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    local x, y = HandyNotes:getXY(coord)
    GameTooltip:SetText(GetNodeTitle(node))
    if node.noteKey then
        GameTooltip:AddLine(T(node.noteKey), 1, 1, 1, true)
    end
    GameTooltip:AddDoubleLine(T("Coordinates"), ("%.2f, %.2f"):format(x * 100, y * 100), 0.7, 0.7, 0.7, 0.7, 0.7, 0.7)
    GameTooltip:AddLine(T("Left-click: set in-game waypoint"), 0.5, 0.8, 1)
    if TomTom then
        GameTooltip:AddLine(T("Right-click: add TomTom waypoint"), 0.5, 0.8, 1)
    end
    GameTooltip:Show()
end

function handler:OnLeave()
    GameTooltip:Hide()
end

function handler:OnClick(button, down, mapID, coord)
    if down then
        return
    end

    local node = GetNode(mapID, coord)
    if not node then
        return
    end

    local x, y = HandyNotes:getXY(coord)
    if button == "LeftButton" then
        if C_Map and C_Map.CanSetUserWaypointOnMap and C_Map.CanSetUserWaypointOnMap(mapID) then
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y))
            if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
        end
    elseif button == "RightButton" and TomTom then
        TomTom:AddWaypoint(mapID, x, y, {
            title = GetNodeTitle(node),
            persistent = false,
            minimap = true,
            world = true,
        })
    end
end

local function OptionName(key)
    return function()
        return T(key)
    end
end

local function OptionValues()
    return {
        [LANGUAGE_AUTO] = T(LANGUAGE_NAMES[LANGUAGE_AUTO]),
        enUS = LANGUAGE_NAMES.enUS,
        zhCN = LANGUAGE_NAMES.zhCN,
        ruRU = LANGUAGE_NAMES.ruRU,
    }
end

local options = {
    type = "group",
    name = TRANSLATIONS[DEFAULT_LOCALE]["HandyNotes: Ritual Sites"],
    desc = OptionName("Ritual Site collectible points."),
    get = function(info)
        return GetOption(info[#info])
    end,
    set = function(info, value)
        SetOption(info[#info], value)
    end,
    args = {
        display = {
            type = "group",
            name = OptionName("Display"),
            inline = true,
            order = 10,
            args = {
                language = {
                    type = "select",
                    name = OptionName("Language"),
                    desc = OptionName("Choose the language used by this plugin."),
                    values = OptionValues,
                    sorting = { LANGUAGE_AUTO, "enUS", "zhCN", "ruRU" },
                    order = 5,
                },
                showMapButton = {
                    type = "toggle",
                    name = OptionName("Show world map filter button"),
                    desc = OptionName("Show the Ritual Sites filter button on the world map."),
                    order = 10,
                },
                showMinimap = {
                    type = "toggle",
                    name = OptionName("Show markers on minimap"),
                    desc = OptionName("Show Ritual Sites markers on the minimap."),
                    order = 20,
                },
                iconScale = {
                    type = "range",
                    name = OptionName("Icon scale"),
                    desc = OptionName("Adjust the size of Ritual Sites markers."),
                    min = 0.5,
                    max = 2,
                    step = 0.05,
                    order = 30,
                },
                iconAlpha = {
                    type = "range",
                    name = OptionName("Icon alpha"),
                    desc = OptionName("Adjust the transparency of Ritual Sites markers."),
                    min = 0.25,
                    max = 1,
                    step = 0.05,
                    isPercent = true,
                    order = 40,
                },
            },
        },
        categories = {
            type = "group",
            name = OptionName("Categories"),
            inline = true,
            order = 20,
            args = {
                showSeaweed = {
                    type = "toggle",
                    name = OptionName("Show seaweed and soggy nest"),
                    desc = OptionName("Show washed-up seaweed and the soggy nest."),
                    order = 10,
                },
                showLynx = {
                    type = "toggle",
                    name = OptionName("Show void-touched lynx thickets"),
                    desc = OptionName("Show rustling hidden thickets for the void-touched lynx collectible."),
                    order = 20,
                },
                showBrokenThroneRewards = {
                    type = "toggle",
                    name = OptionName("Show Broken Throne rewards"),
                    desc = OptionName("Show fixed Broken Throne collectible and reward points."),
                    order = 30,
                },
                showBrokenThroneChallenges = {
                    type = "toggle",
                    name = OptionName("Show Broken Throne challenge unlocks"),
                    desc = OptionName("Show Malevolent Boons obelisks and the tainted bone pile."),
                    order = 40,
                },
            },
        },
        reset = {
            type = "execute",
            name = OptionName("Reset filters"),
            desc = OptionName("Restore all Ritual Sites filters to defaults."),
            order = 30,
            func = ResetOptions,
        },
    },
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
    if not (MenuUtil and MenuUtil.CreateContextMenu) then
        return
    end

    MenuUtil.CreateContextMenu(owner, function(_, rootDescription)
        rootDescription:CreateTitle(T("HandyNotes: Ritual Sites"))
        rootDescription:CreateCheckbox(T("Show seaweed and soggy nest"), function()
            return GetOption("showSeaweed")
        end, function()
            ToggleOption("showSeaweed")
        end)
        rootDescription:CreateCheckbox(T("Show void-touched lynx thickets"), function()
            return GetOption("showLynx")
        end, function()
            ToggleOption("showLynx")
        end)
        rootDescription:CreateCheckbox(T("Show Broken Throne rewards"), function()
            return GetOption("showBrokenThroneRewards")
        end, function()
            ToggleOption("showBrokenThroneRewards")
        end)
        rootDescription:CreateCheckbox(T("Show Broken Throne challenge unlocks"), function()
            return GetOption("showBrokenThroneChallenges")
        end, function()
            ToggleOption("showBrokenThroneChallenges")
        end)
        rootDescription:CreateDivider()
        rootDescription:CreateButton(T("Show all"), function()
            SetOption("showSeaweed", true)
            SetOption("showLynx", true)
            SetOption("showBrokenThroneRewards", true)
            SetOption("showBrokenThroneChallenges", true)
        end)
        rootDescription:CreateButton(T("Open HandyNotes options"), OpenHandyNotesOptions)
    end)
end

function UpdateMapButton()
    if not mapButton or not WorldMapFrame then
        return
    end

    local visible = GetOption("showMapButton") and WorldMapFrame:IsShown() and IsSupportedMap(WorldMapFrame:GetMapID())
    if mapButton:IsShown() ~= visible then
        mapButton:SetShown(visible)
        if worldMapButtons and worldMapButtons.SetPoints then
            worldMapButtons:SetPoints()
        end
    end
end

local function CreateMapButton()
    if mapButton or not WorldMapFrame then
        return
    end

    worldMapButtons = LibStub and LibStub("Krowi_WorldMapButtons-1.4", true)
    if not worldMapButtons then
        return
    end

    local ok, button = pcall(function()
        return worldMapButtons:Add(ADDON_NAME .. "WorldMapOptionsButtonTemplate", "BUTTON")
    end)
    if not ok or not button then
        return
    end

    mapButton = button
    mapButton.Refresh = UpdateMapButton
    mapButton:SetScript("OnClick", ShowFilterMenu)
    mapButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText(T("HandyNotes: Ritual Sites"))
        GameTooltip:AddLine(T("Show seaweed and soggy nest"), GetOption("showSeaweed") and 0.4 or 0.8, GetOption("showSeaweed") and 1 or 0.4, 0.4)
        GameTooltip:AddLine(T("Show void-touched lynx thickets"), GetOption("showLynx") and 0.4 or 0.8, GetOption("showLynx") and 1 or 0.4, 0.4)
        GameTooltip:AddLine(T("Show Broken Throne rewards"), GetOption("showBrokenThroneRewards") and 0.4 or 0.8, GetOption("showBrokenThroneRewards") and 1 or 0.4, 0.4)
        GameTooltip:AddLine(T("Show Broken Throne challenge unlocks"), GetOption("showBrokenThroneChallenges") and 0.4 or 0.8, GetOption("showBrokenThroneChallenges") and 1 or 0.4, 0.4)
        GameTooltip:Show()
    end)
    mapButton:SetScript("OnLeave", GameTooltip_Hide)

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

    UpdateMapButton()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(_, event, addonName)
    if event == "PLAYER_LOGIN" or addonName == "Blizzard_WorldMap" then
        CreateMapButton()
    end
end)

if C_Timer then
    C_Timer.After(0, CreateMapButton)
end
