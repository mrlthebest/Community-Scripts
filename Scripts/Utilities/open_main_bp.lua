local macroName = 'Keep Open Main BP';
local macroDelay = 100;
local tabName = setDefaultTab('Main');


macro(macroDelay, macroName, function()
    --Made By VivoDibra#1182
    if not getContainers()[0] and getBack() then
        g_game.open(getBack())
    end
end, tabName)

--Join Discord server for free scripts
--https://discord.gg/RkQ9nyPMBH
--Made By VivoDibra#1182
--Tested on vBot 4.8 / OTCV8 3.1 rev 232