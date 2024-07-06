local macroName = 'Regeneration';
local macroDelay = 100;
local tabName = setDefaultTab('Main');

UI.Separator(tabName)
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

addTextEdit("Regeneration Spell", storage.regenerationSpell or "Regeneration Spell", function(widget, text)
    storage.regenerationSpell = text;
end, tabName);
addScrollBar('percentageRegeneration', 'Porcentagem Vida', 1, 100, 99, tabName, "Porcentagem de vida para usar o regeneration.");


macro(macroDelay, macroName, function()
    local selfHealth = hppercent();
    if selfHealth <= storage.scrollBarValues.percentageRegeneration then
        say(storage.regenerationSpell)
    end
end, tabName);


UI.Separator(tabName)