local macroName = 'Bug Map Kunai';
local macroDelay = 100;

local bugMap = {};
bugMap.directions = {
    ["W"] = {x = 0, y = -5, direction = 0},
    ["E"] = {x = 3, y = -3},
    ["D"] = {x = 5, y = 0, direction = 1},
    ["C"] = {x = 3, y = 3},
    ["S"] = {x = 0, y = 5, direction = 2},
    ["Z"] = {x = -3, y = 3},
    ["A"] = {x = -5, y = 0, direction = 3},
    ["Q"] = {x = -3, y = 3}
};

addItem('kunaiId', 'ID Kunai', 11863, tabName, '')

bugMap.isKeyPressed = modules.corelib.g_keyboard.isKeyPressed;
bugMap.macro = macro(macroDelay, macroName, function()
    if (modules.game_console:isChatEnabled() or modules.corelib.g_keyboard.isCtrlPressed()) then return; end
    local pos = pos();
    for key, config in pairs(bugMap.directions) do
        if (bugMap.isKeyPressed(key)) then
            if (config.direction) then
                turn(config.direction);
            end
            local tile = g_map.getTile({x = pos.x + config.x, y = pos.y + config.y, z = pos.z});
            if (tile) then
                return useWith(storage.itemValues.kunaiId, tile:getTopUseThing());
            end
        end
    end
end, tabName);
