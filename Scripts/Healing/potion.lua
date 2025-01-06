local macroName = 'Potion';
local macroDelay = 100;

UI.Separator(tabName)

addScrollBar('potionHealth', 'Porcentagem Vida', 1, 100, 99, tabName, 'Porcentagem de vida para usar a potion.');
addScrollBar('potionMana', 'Porcentagem Mana', 1, 100, 99, tabName, 'Porcentagem de mana para usar a potion.');
addItem('potionLife', 'Potion Life', 11863, tabName, '');
addItem('potionMana', 'Potion Mana', 11863, tabName, '');
addScrollBar('potionDelay', 'Potion Delay', 0, 60, 1, tabName, 'Delay em segundos.');

macro(100, "Potion", function()
    local selfHealth = hppercent();
    local selfMana = manapercent();
    if selfHealth < storage.scrollBarValues.potionHealth then
        useWith(storage.itemValues.potionLife, player)
        delay(storage.scrollBarValues.potionDelay * 1000)
    elseif selfMana < storage.scrollBarValues.potionMana then
        delay(storage.scrollBarValues.potionDelay * 1000)
        useWith(storage.itemValues.potionMana, player)
    end
end, tabName);

UI.Separator(tabName)
