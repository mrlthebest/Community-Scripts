local macroName = 'Bug Map Kunai';
local macroDelay = 100;
local tabName = setDefaultTab('Main');

itemWidget = [[
Panel
  height: 34
  margin-top: 7
  margin-left: 25
  margin-right: 25

  UIWidget
    id: text
    anchors.left: parent.left
    anchors.verticalCenter: next.verticalCenter

  BotItem
    id: item
    anchors.top: parent.top
    anchors.right: parent.right
]]

storage.itemValues = storage.itemValues or {};
addItem = function(id, title, defaultItem, dest, tooltip)
    local widget = setupUI(itemWidget, dest)
    widget.text:setText(title)
    widget.text:setTooltip(tooltip)
    widget.item:setTooltip(tooltip)
    widget.item:setItemId(storage.itemValues[id] or defaultItem)
    widget.item.onItemChange = function(widget)
        storage.itemValues[id] = widget:getItemId()
    end
    storage.itemValues[id] = storage.itemValues[id] or defaultItem
end

local bugMap = {};
bugMap.directions = {
    ["W"] = {x = 0, y = -5, direction = 0},
    ["E"] = {x = 3, y = -3},
    ["D"] = {x = 5, y = 0, direction = 1},
    ["C"] = {x = 3, y = 3},
    ["S"] = {x = 0, y = 5, direction = 2},
    ["Z"] = {x = -3, y = 3},
    ["A"] = {x = -5, y = 0, direction = 3},
    ["Q"] = {x = -3, y = 3}
};

addItem('kunaiId', 'ID Kunai', 11863, tabName, '')

bugMap.isKeyPressed = modules.corelib.g_keyboard.isKeyPressed;
bugMap.macro = macro(macroDelay, macroName, function()
    if (modules.game_console:isChatEnabled() or modules.corelib.g_keyboard.isCtrlPressed()) then return; end
    local pos = pos();
    for key, config in pairs(bugMap.directions) do
        if (bugMap.isKeyPressed(key)) then
            if (config.direction) then
                turn(config.direction);
            end
            local tile = g_map.getTile({x = pos.x + config.x, y = pos.y + config.y, z = pos.z});
            if (tile) then
                return useWith(storage.itemValues.kunaiId, tile:getTopUseThing());
            end
        end
    end
end, tabName);
