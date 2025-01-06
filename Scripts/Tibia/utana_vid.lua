local config = {
    invisibleSpell = "Utana Vid",
    minManaPercent = 10,
    useOnPz = false
}

local macroName = 'Utana Vid';
local macroDelay = 100;

macro(macroDelay, macroName, function()
    --Made By VivoDibra
    local isVisible = not player:isInvisible() 
    local hasMana = manapercent() > config.minManaPercent
    local isPzOk = config.useOnPz or not isInPz()
    if isVisible and hasMana and isPzOk then
        say(config.invisibleSpell)
        delay(1000)
    end
end, tabName)

addButton("", "+ Free Scripts", function()
    g_platform.openUrl("https://discord.gg/RkQ9nyPMBH")
end)

--Join Discord server for free scripts
--https://discord.gg/RkQ9nyPMBH
--Made By VivoDibra
--Tested on vBot 4.8 / OTCV8 3.2 rev 4
