local macroName = 'Mount';
local macroDelay = 100;
local tabName = setDefaultTab('Main');

macro(macroDelay, macroName, function()
    --Made By VivoDibra#1182 
    if isInPz() then return end
    local pOutifit = player:getOutfit()
    local isMounted = pOutifit.mount ~= nil and pOutifit.mount > 0
    if not isMounted then
        player:mount()
    end
end, tabName)
  
  --Join Discord server for free scripts
  --https://discord.gg/RkQ9nyPMBH
  --Made By VivoDibra#1182
  --Tested on vBot 4.8 / OTCV8 3.1 rev 232