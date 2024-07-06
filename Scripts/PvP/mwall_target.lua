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


addItem('mwallId', 'MW ID' , 3180, mainTab, '');

local offsetDirections = {
    [North] = { 0, -2 },
    [East] = { 2, 0 },
    [South] = { 0, 2 },
    [West] = { -2, 0 },
    [NorthEast] = { 2, -2 },
    [SouthEast] = { 2, 2 },
    [SouthWest] = { -2, 2 },
    [NorthWest] = { -2, -2 }
}

macro(1000, "Mwall Frente Target", function()
    local target = g_game.getAttackingCreature()
    if not target then
        return
    end

    local targetPos = target:getPosition()
    local targetDir = target:getDirection()

    targetPos.x = targetPos.x + offsetDirections[targetDir][1]
    targetPos.y = targetPos.y + offsetDirections[targetDir][2]
    
    local mwallTile = g_map.getTile(targetPos)
    useWith(storage.itemValues.mwallId, mwallTile:getTopUseThing())
end, mainTab)
