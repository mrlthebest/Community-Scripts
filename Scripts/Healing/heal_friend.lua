local macroName = 'Heal Friend';
local macroDelay = 100;

UI.Separator(tabName);
UI.Label('Spell Heal', tabName)
addTextEdit("Spell Heal", storage.spellHeal or "Spell Heal", function(widget, text)
    storage.spellHeal = text;
end, tabName);

addItem('itemHeal', 'Heal Item', 11863, tabName, 'Item de heal.');
addScrollBar('percentageHeal', 'Porcentagem para curar', 1, 100, 99, tabName, '%');
addScrollBar('delayHeal', 'Delay para curar', 1, 120, 1, tabName, 'Segundos');
addScrollBar('distanceHeal', 'Distancia de heal', 1, 10, 1, tabName, '');
UI.Button("Friend List", function(newText)
    UI.MultilineEditorWindow(storage.friendList or '', {title="FriendList", description="Example: \nPlayer\nPlayer", width = 150, height = 50}, function(text)
        storage.friendList = text;
    end, tabName);
end, tabName);

macro(macroDelay, macroName, function(m)
    local playerPos = pos();
    local delayHeal = storage.scrollBarValues.delayHeal;
    local percentageHeal = storage.scrollBarValues.percentageHeal;
    local distanceHeal = storage.scrollBarValues.distanceHeal;
    local itemHeal = storage.itemValues.itemHeal;
    local spellHeal = storage.spellHeal;
    if not storage.friendList or storage.friendList == '' then
        warn('Friend list invalida, adicione players separando-os por quebra de linha.')
        m:setOff()
        return
    end
    local friendList = string.split(storage.friendList, '\n');
    for _, spec in ipairs(getSpectators()) do
        if (table.contains(friendList, spec:getName(), true) or (spec:getEmblem() == 1 or spec:getShield() == 3)) then
            local specPos = spec:getPosition();
            local specHealth = spec:getHealthPercent();
            if not specPos then return; end
            local distanceToSpec = getDistanceBetween(playerPos, specPos);
            if distanceToSpec <= distanceHeal and specHealth <= percentageHeal then
                if (spellHeal ~= 'Spell Heal' or spellHeal:len() > 0) then
                    say(spellHeal .. ' "' .. spec:getName())
                else
                    useWith(itemHeal, spec)
                end
                delay(delayHeal*1000)
            end
        end
    end
end, tabName);
UI.Separator(tabName);
