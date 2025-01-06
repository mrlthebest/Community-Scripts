local macroName = 'Follow Attack';
local macroDelay = 100;

local targetName;
macro(macroDelay, macroName, function()
    local target = g_game.getAttackingCreature();
    if g_game.isAttacking() and target and target:isPlayer() then
      targetName = target:getName();
    end
    if targetName then
      local findTarget = getCreatureByName(targetName);
      if not findTarget then return; end
      say('sense "' .. targetName)
      delay(2000)
  end
end, tabName);
