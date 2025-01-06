local macroName = 'Send Message on Trade';
local macroDelay = 60000;
setDefaultTab(tabName);


macro(macroDelay, macroName, function()
    local trade = getChannelId("advertising")
    if not trade then
      trade = getChannelId("trade")
    end
    if trade and storage.autoTradeMessage:len() > 0 then    
      sayChannel(trade, storage.autoTradeMessage)
    end
  end, tabName)
  UI.TextEdit(storage.autoTradeMessage or "I'm using OTClientV8!", function(widget, text)    
    storage.autoTradeMessage = text
  end, tabName)
  
  UI.Separator(tabName)
