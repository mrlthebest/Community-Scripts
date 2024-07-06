local macroName = 'Auto Share Exp'
local macroDelay = 100
local tabName = 'Main'

macro(macroDelay, macroName, function()
    -- Made By VivoDibra
    local target = g_game.getAttackingCreature()
    if not target then 
        return 
    end
    if isSafe(8) and getDistanceBetween(pos(), target:getPosition()) <= 4 then
        say("exevo gran mas frigo")
    else
        g_game.useWith(Item.create(3155), target)
    end
end, tabName)

addButton("", "+ Free Scripts", function()
    g_platform.openUrl("https://discord.gg/RkQ9nyPMBH")
end, tabName)

-- Join Discord server for free scripts
-- https://discord.gg/RkQ9nyPMBH
-- Made By VivoDibra
-- Tested on vBot 4.8 / OTCV8 3.2 rev 4
