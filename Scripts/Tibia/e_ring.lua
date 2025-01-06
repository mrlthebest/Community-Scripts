local macroName = 'E-Ring';
local macroDelay = 100;

--Join Discord server for free scripts
--https://discord.gg/RkQ9nyPMBH
--Made By VivoDibra
--Tested on vBot 4.8 / OTCV8 3.2 rev 4

local s  = {}

g_ui.loadUIFromString([[
PvPScriptsScrollBar < Panel
  height: 28
  margin-top: 3

  UIWidget
    id: text
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    text-align: center
    
  HorizontalScrollBar
    id: scroll
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
    margin-top: 3
    minimum: 0
    maximum: 10
    step: 1

PvPScriptsItem < Panel
  height: 40
  margin-top: 10  
  UIWidget
    id: text
    anchors.left: parent.left
    anchors.verticalCenter: next.verticalCenter

  BotItem
    id: item
    anchors.top: parent.top
    anchors.right: parent.right
    
]])

local addScrollBar = function(id, title, min, max, defaultValue, dest, tooltip)
    local widget = UI.createWidget("PvPScriptsScrollBar", dest)
    widget.text:setTooltip(tooltip)
    widget.scroll.onValueChange = function(scroll, value)
      widget.text:setText(title..value)
      if value == 0 then
        value = 1
      end
      storage[id] = value
    end
    widget.scroll:setRange(min, max)
    widget.scroll:setTooltip(tooltip)
    widget.scroll:setValue(storage[id] or defaultValue)
    widget.scroll.onValueChange(widget.scroll, widget.scroll:getValue())
end

local addItem = function(id, title, defaultItem, dest, tooltip)
    local widget = UI.createWidget('PvPScriptsItem', dest)
    widget:setId(id)
    widget.text:setText(title)
    widget.text:setTooltip(tooltip)
    widget.item:setTooltip(tooltip)
    widget.item:setItemId(storage[id] or defaultItem)
    widget.item.onItemChange = function(widget)
      storage[id] = widget:getItemId()
    end
    storage[id] = storage[id] or defaultItem
    return widget
end

addSeparator(tabName)
addLabel("","E-Ring Custom", tabName):setColor("green")
addSeparator(tabName)
addLabel(tabName)

addLabel("", "E-Ring", tabName):setColor("#5DF2BD")
addScrollBar("ERingHP", "HP < ", 0, 100, 90, tabName, "")
addScrollBar("ERingMP", "MP > ", 0, 100, 80, tabName, "")
addItem("ERing", "normal id", storage.ERing or 3051, tabName, "")
addItem("ERingEquipped", "equipped Id", storage.ERingEquipped or 3088, tabName, "")

addLabel("", "Normal Ring", tabName):setColor("yellow")
addScrollBar("NormalHP", "HP > ", 0, 100, 90, tabName, "")
addScrollBar("NormalMP", "MP < ", 0, 100, 80, tabName, "")
addItem("NormalRing", "normal id", storage.NormalRing or 3004, tabName, "")
addItem("NormalRingEquipped", "equipped id", storage.NormalRingEquipped or 3004, tabName, "")

s.equipItem = function(normalId, activeId, slot)
    local item = getInventoryItem(slot)
    if item and item:getId() == activeId then
        return false
    end
  
    if g_game.getClientVersion() >= 870 then
      g_game.equipItemId(normalId)
      return true
    end
  
    local itemToEquip = findItem(normalId)
    if itemToEquip then
        moveToSlot(itemToEquip, slot, itemToEquip:getCount())
        return true
    end
end

function crazyHPPercent()
  return (player:getHealth() / 100) * 10
end

s.m_main = macro(macroDelay, macroName, function() 
  local hp = hppercent()
  local mp = manapercent()
   

  local equipEnergy = hp < storage.ERingHP and mp > storage.ERingMP
  local equipNormal = hp > storage.NormalHP and mp <= storage.NormalMP

  if equipEnergy then
      s.equipItem(storage.ERing, storage.ERingEquipped, SlotFinger)
  elseif equipNormal then
      s.equipItem(storage.NormalRing, storage.NormalRingEquipped, SlotFinger)
  end
end, tabName)

addButton("", "+ Free Scripts", function()
  g_platform.openUrl("https://discord.gg/RkQ9nyPMBH")
end)

addSeparator(tabName)
