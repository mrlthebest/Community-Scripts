local macroName = 'Potion';
local macroDelay = 100;

UI.Separator(tabName)

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

scrollBar = [[
Panel
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
]];

storage.scrollBarValues = storage.scrollBarValues or {};
addScrollBar = function(id, title, min, max, defaultValue, dest, tooltip)
    local value = storage.scrollBarValues[id] or defaultValue
    local widget = setupUI(scrollBar, dest)
    widget.text:setTooltip(tooltip)
    widget.scroll.onValueChange = function(scroll, value)
        widget.text:setText(title .. ": " .. value .. "%")
        if value == 0 then
            value = 1
        end
        storage.scrollBarValues[id] = value
    end
    widget.scroll:setRange(min, max)
    widget.scroll:setTooltip(tooltip)
    widget.scroll:setValue(value)
    widget.scroll.onValueChange(widget.scroll, value)
end

addScrollBar('potionHealth', 'Porcentagem Vida', 1, 100, 99, tabName, 'Porcentagem de vida para usar a potion.');
addScrollBar('potionMana', 'Porcentagem Mana', 1, 100, 99, tabName, 'Porcentagem de mana para usar a potion.');
addItem('potionLife', 'Potion Life', 11863, tabName, '');
addItem('potionMana', 'Potion Mana', 11863, tabName, '');
addScrollBar('potionDelay', 'Potion Delay', 0, 60, 1, tabName, 'Delay em segundos.');

macro(100, "Potion", function()
    local selfHealth = hppercent();
    local selfMana = manapercent();
    if selfHealth < storage.scrollBarValues.potionHealth then
        useWith(storage.itemValues.potionLife, player)
        delay(storage.scrollBarValues.potionDelay * 1000)
    elseif selfMana < storage.scrollBarValues.potionMana then
        delay(storage.scrollBarValues.potionDelay * 1000)
        useWith(storage.itemValues.potionMana, player)
    end
end, tabName);

UI.Separator(tabName)
