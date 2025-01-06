local macroName = 'Exchange Money';
local macroDelay = 1000;

if type(storage.moneyItems) ~= "table" then
    storage.moneyItems = {3031, 3035}
end
macro(macroDelay, macroName, function()
    if not storage.moneyItems[1] then return end
    local containers = g_game.getContainers()
    for index, container in pairs(containers) do
        if not container.lootContainer then -- ignore monster containers
            for i, item in ipairs(container:getItems()) do
                if item:getCount() == 100 then
                    for m, moneyId in ipairs(storage.moneyItems) do
                        if item:getId() == moneyId.id then
                            return g_game.use(item)
                        end
                    end
                end
            end
        end
    end
end, tabName)

local moneyContainer = UI.Container(function(widget, items)
    storage.moneyItems = items
end, tabName)
moneyContainer:setHeight(35)
moneyContainer:setItems(storage.moneyItems)
