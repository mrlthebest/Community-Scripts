local macroName = 'Exeta Res';
local macroDelay = 100;

macro(macroDelay, macroName, function()
    --Made By VivoDibra#1182
    if g_game.isAttacking() and 
    distanceFromPlayer(g_game.getAttackingCreature():getPosition()) <= 1 and 
    manapercent() > 30 then
        say("Exeta Res")
        delay(5000)
    end
end, tabName)

--Join Discord server for free scripts
--https://discord.gg/RkQ9nyPMBH
--Made By VivoDibra#1182
--Tested on vBot 4.8 / OTCV8 3.1 rev 232
