
local macroName = 'Speed';
local macroDelay = 100;
local tabName = setDefaultTab('Main');

addTextEdit("Speed Spell ", storage.speedSpell or "Speed Spell", function(widget, text)
  storage.speedSpell = text:trim():lower();
end, tabName);

macro(macroDelay, macroName, function()
    if (not hasHaste() or isParalyzed()) then
        say(storage.speedSpell)
    end
end, tambem);