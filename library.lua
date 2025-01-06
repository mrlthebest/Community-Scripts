--[[

  Scroll Bar Function

  Id: Nome que irá ficar salvo no storage, usado para salvar os valrores.
  Title: Titulo principal.
  Min: Valor minimo.
  Max: Valor máximo.
  Default Value: Valor definido no começo.
  Dest: Tab que irá ficar a scrollbar.
  Tooltip: Tooltip que irá ficar no widget
]]--

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
    if max - min > 1000 then
        widget.scroll:setStep(100)
    elseif max - min > 100 then
        widget.scroll:setStep(10)
    end
    widget.scroll:setValue(value)
    widget.scroll.onValueChange(widget.scroll, value)
end

--[[

  Switch Bar Function

  Id: Nome que irá ficar salvo no storage, usado para salvar os valrores.
  Title: Titulo principal.
  Default Value: Valor definido no começo(boolean).
  Dest: Tab que irá ficar a scrollbar.
  Tooltip: Tooltip que irá ficar no widget
]]--

scrollBar = [[
BotSwitch
  height: 20
  margin-top: 7
]];

storage.switchStatus = storage.switchStatus or {};
addSwitchBar = function(id, title, defaultValue, dest, tooltip)
    local widget = setupUI(scrollBar, dest)
    widget.onClick = function()
        widget:setOn(not widget:isOn())
        storage.switchStatus[id] = widget:isOn()
    end
    widget:setText(title)
    widget:setTooltip(tooltip)
    if storage.switchStatus[id] == nil then
        widget:setOn(defaultValue)
    else
        widget:setOn(storage.switchStatus[id])
    end
    storage.switchStatus[id] = widget:isOn()
end


--[[

  Item Widget Function

  Id: Nome que irá ficar salvo no storage, usado para salvar os valrores.
  Title: Titulo principal.
  Default Item: Valor definido no começo(id).
  Dest: Tab que irá ficar a scrollbar.
  Tooltip: Tooltip que irá ficar no widget

]]--

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

--[[

  CheckBox Widget Function

  Id: Nome que irá ficar salvo no storage, usado para salvar os valrores.
  Title: Titulo principal.
  Default Item: Valor definido no começo(boolean).
  Dest: Tab que irá ficar a scrollbar.
  Tooltip: Tooltip que irá ficar no widget

]]--

checkBoxWidget = [[
CheckBox
  width: 30
]]

storage.checkBoxStatus = storage.checkBoxStatus or {}
addCheckBox = function(id, title, defaultBoolean, dest, tooltip)
    local widget = setupUI(checkBoxWidget, dest)
    widget:setText(title)
    widget:setTooltip(tooltip)
    widget.onCheckChange = function(widget, checked)
        widget:setChecked(checked)
        storage.checkBoxStatus[id] = checked;
    end
    widget:setChecked(storage.checkBoxStatus[id] or defaultBoolean)
end


