local macroName = 'Heal Friend';
local macroDelay = 100;


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
        widget.text:setText(title)
        widget.scroll:setText(value)
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



UI.Separator(tabName);
UI.Label('Spell Heal', tabName)
addTextEdit("Spell Heal", storage.spellHeal or "Spell Heal", function(widget, text)
    storage.spellHeal = text;
end, tabName);

addItem('itemHeal', 'Heal Item', 11863, tabName, 'Item de heal.');
addScrollBar('percentageHeal', 'Porcentagem para curar', 1, 100, 99, tabName, '%');
addScrollBar('delayHeal', 'Delay para curar', 1, 120, 1, tabName, 'Segundos');
addScrollBar('distanceHeal', 'Distancia de heal', 1, 10, 1, tabName, '');
UI.Button("Friend List", function(newText)
    UI.MultilineEditorWindow(storage.friendList or '', {title="FriendList", description="Example: \nPlayer\nPlayer", width = 150, height = 50}, function(text)
        storage.friendList = text;
    end, tabName);
end, tabName);

macro(macroDelay, macroName, function(m)
    local playerPos = pos();
    local delayHeal = storage.scrollBarValues.delayHeal;
    local percentageHeal = storage.scrollBarValues.percentageHeal;
    local distanceHeal = storage.scrollBarValues.distanceHeal;
    local itemHeal = storage.itemValues.itemHeal;
    local spellHeal = storage.spellHeal;
    if not storage.friendList or storage.friendList == '' then
        warn('Friend list invalida, adicione players separando-os por quebra de linha.')
        m:setOff()
        return
    end
    local friendList = string.split(storage.friendList, '\n');
    for _, spec in ipairs(getSpectators()) do
        if (table.contains(friendList, spec:getName(), true) or (spec:getEmblem() == 1 or spec:getShield() == 3)) then
            local specPos = spec:getPosition();
            local specHealth = spec:getHealthPercent();
            if not specPos then return; end
            local distanceToSpec = getDistanceBetween(playerPos, specPos);
            if distanceToSpec <= distanceHeal and specHealth <= percentageHeal then
                if (spellHeal ~= 'Spell Heal' or spellHeal:len() > 0) then
                    say(spellHeal .. ' "' .. spec:getName())
                else
                    useWith(itemHeal, spec)
                end
                delay(delayHeal*1000)
            end
        end
    end
end, tabName);
UI.Separator(tabName);
