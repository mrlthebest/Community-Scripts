local macroName = 'Utura';
local macroDelay = 100;

macro(macroDelay, macroNam, function()
    say("Utura")
    delay(60000)
end, tabName)

macro(macroDelay, macroName .. " Gran", function()
    say("Utura Gran")
    delay(60000)
end, tabName)
