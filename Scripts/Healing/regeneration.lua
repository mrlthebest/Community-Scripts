local macroName = 'Regeneration';
local macroDelay = 100;

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
