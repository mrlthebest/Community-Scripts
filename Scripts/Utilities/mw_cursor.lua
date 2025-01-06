local macroName = 'MW Cursor';
local macroDelay = 100;
setDefaultTab(tabName);

UI.Label('R MW Key', tabName)
addItem('mwallId', 'MW ID', 110, tabName, '');

hotkey('R', macroName, function()
    local tile = getTileUnderCursor();
    if (modules.game_console:isChatEnabled() or modules.corelib.g_keyboard.isCtrlPressed()) then return; end
    if not tile then return end
    g_game.stop();
    player:stopAutoWalk();
    useWith(storage.itemValues.mwallId, tile:getTopUseThing())
    delay(macroDelay)
end, tabName);
