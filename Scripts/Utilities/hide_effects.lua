local macroName = 'Hide Sprites';
local macroDelay = 100;
setDefaultTab(tabName);

sprh = macro(macroDelay, macroName, function() end, tabName)
onAddThing(function(tile, thing)
    if sprh.isOff() then return end
    if thing:isEffect() then
        thing:hide()
    end
end)
