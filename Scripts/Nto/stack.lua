local macroName = 'Stack';
local macroDelay = 100;

addTextEdit("Stack Spell", storage.stackSpell or "Stack Spell", function(widget, text)
    storage.stackSpell = text;
end, tabName);

local maxDistance = 8;

local Stack = {};

Stack.northPattern = [[
    11111
    11111
    11111
    11111
    11111
    11111
    11111
    11111
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
]];

Stack.southPattern = [[
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    00000
    11111
    11111
    11111
    11111
    11111
    11111
    11111
    11111
]];

Stack.westPattern = [[
    1111111110000000000
    1111111110000000000
    1111111110000000000
    1111111110000000000
    1111111110000000000
]];

Stack.eastPattern = [[
    0000000000111111111
    0000000000111111111
    0000000000111111111
    0000000000111111111
    0000000000111111111
]];

Stack.icon = addIcon("Stack",  {item=7382, text="Stack"}, macro(macroDelay, macroName, function() 
    local furthestMonster = nil;
    local pattern = nil;

    if (modules.corelib.g_keyboard.areKeysPressed("Shift+W")) then
        pattern = Stack.northPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("Shift+S")) then
        pattern = Stack.southPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("Shift+A")) then
        pattern = Stack.westPattern;
    elseif (modules.corelib.g_keyboard.areKeysPressed("Shift+D")) then
        pattern = Stack.eastPattern;
    end

    if (not pattern) then return; end

    local playerPos = pos();
    for _, creature in pairs(getSpectators(playerPos, pattern)) do
        if (not creature:isNpc() and not creature:isPlayer()) then
            local monsterDistance = getDistanceBetween(playerPos, creature:getPosition())
            if (monsterDistance <= maxDistance and
                (
                    furthestMonster == nil or
                    monsterDistance > getDistanceBetween(playerPos, furthestMonster:getPosition())
                )
            ) then
                furthestMonster = creature;
            end
        end
    end

    if (not furthestMonster) then return; end

    g_game.stop();
    g_game.attack(furthestMonster);

    say(storage.stackSpell);

    schedule(600, function()
        g_game.cancelAttack();
    end);
end, tabName));
