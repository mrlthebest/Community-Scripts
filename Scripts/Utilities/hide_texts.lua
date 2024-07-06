local macroName = 'Hide';
local macroDelay = 100;
local tabName = setDefaultTab('Main');

TH = macro(macroDelay, macroName .. " Orange Messages", function() end, tabName)
onStaticText(function(thing, text)
    if TH.isOff() then return end
    if not text:find('says:') then
        g_map.cleanTexts()
    end
end);

GH = macro(macroDelay, macroName .. " Green Messages", function() end, tabName)
onTextMessage(function(mode, text)
    if GH.isOff() then return end
    modules.game_textmessage.clearMessages()
    g_map.cleanTexts()
end);