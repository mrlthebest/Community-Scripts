-- layout para scroll bar
local scrollBarLayout = [[
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
]]

-- inicializa a tabela de armazenamento
storage.scrollBarValues = storage.scrollBarValues or {}

-- função para adicionar uma scroll bar
addScrollBar = function(id, title, min, max, defaultValue, dest, tooltip)
    -- valida o valor inicial
    local value = math.min(math.max(storage.scrollBarValues[id] or defaultValue, min), max)

    -- cria o widget
    local widget = setupUI(scrollBarLayout, dest)

    -- valida se os widgets foram criados corretamente
    if not widget.text or not widget.scroll then
        error("Falha ao criar widgets para a scroll bar")
        return
    end

    -- define propriedades do widget
    widget.text:setTooltip(tooltip)
    widget.scroll.onValueChange = function(scroll, value)
        widget.text:setText(title .. ": " .. value)
        storage.scrollBarValues[id] = value
    end

    widget.scroll:setMinimum(min)
    widget.scroll:setMaximum(max)
    widget.scroll:setValue(value)
    widget.scroll.onValueChange(widget.scroll, value)
end

-- layout para switch bar
local switchBarLayout = [[
BotSwitch
  height: 20
  margin-top: 7
]]

-- inicializa a tabela de armazenamento
storage.switchStatus = storage.switchStatus or {}

-- função para adicionar uma switch bar
addSwitchBar = function(id, title, defaultValue, dest, tooltip)
    -- cria o widget
    local widget = setupUI(switchBarLayout, dest)

    -- define a lógica de clique no switch
    widget.onClick = function()
        widget:setOn(not widget:isOn())
        storage.switchStatus[id] = widget:isOn()
    end

    -- define propriedades do widget
    widget:setText(title)
    widget:setTooltip(tooltip)
    widget:setOn(storage.switchStatus[id] or defaultValue)
end
