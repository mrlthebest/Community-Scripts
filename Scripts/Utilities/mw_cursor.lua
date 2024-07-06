local macroName = 'MW Cursor';
local macroDelay = 100;
local tabName = setDefaultTab('Main');

UI.Label('R MW Key', tabName)
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


addItem('mwallId', 'MW ID', 110, tabName, '');

hotkey('R', macroName, function()
    local tile = getTileUnderCursor();
    if (modules.game_console:isChatEnabled() or modules.corelib.g_keyboard.isCtrlPressed()) then return; end
    if not tile then return end
    g_game.stop();
    player:stopAutoWalk();
    useWith(storage.itemValues.mwallId, tile:getTopUseThing())
    delay(macroDelay)
end, tabName);
