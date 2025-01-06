-- Tools UI (Activate & Setup);

local macroName = 'Time Spell';
local macroDelay = 100;
setDefaultTab(tabName);
timeSpellPanelName = "timespellbot"
local ui = setupUI([[
Panel
  height: 17
  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Time Spell')

  Button
    id: settings
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Setup
]])
ui:setId(timeSpellPanelName);
ui.title:setText(macroName)

local windowUI = setupUI([[
MainWindow
  !text: tr('Time Spell by neoX - Discord: VictorNeox#1947')
  size: 820 312
  
  Panel
    id: MainPanel
    image-source: /images/ui/panel_flat
    anchors.top: parent.top
    anchors.left: parent.left
    image-border: 6
    padding: 3
    size: 492 225

    
    TextList
      id: spellList
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      padding: 1
      size: 270 212    
      margin-bottom: 3
      margin-left: 3
      vertical-scrollbar: spellListScrollBar
      
    VerticalScrollBar
      id: spellListScrollBar
      anchors.top: spellList.top
      anchors.bottom: spellList.bottom
      anchors.right: spellList.right
      step: 14
      pixels-scroll: true

    Label
      id: spellNameLabel
      anchors.left: spellList.right
      anchors.top: spellList.top
      text: Spell Name:
      margin-top: 10
      margin-left: 7

    TextEdit
      id: spellName
      anchors.left: spellNameLabel.right
      anchors.top: parent.top
      margin-top: 5
      margin-left: 12
      width: 125

    Label
      id: onScreenLabel
      anchors.left: spellNameLabel.left
      anchors.top: spellName.bottom
      margin-top: 10
      text: On Screen:

    TextEdit
      id: onScreen
      anchors.left: onScreenLabel.right
      anchors.top: prev.top
      margin-top: -5
      margin-left: 17
      width: 125

    Label
      id: activeTimeLabel
      anchors.left: onScreenLabel.left
      anchors.top: onScreen.bottom
      text: Active Time:
      margin-top: 10

    TextEdit
      id: activeTime
      anchors.left: activeTimeLabel.right
      anchors.top: prev.top
      margin-top: -5
      margin-left: 5
      width: 125

    Label
      id: totalTimeLabel
      anchors.left: activeTimeLabel.left
      anchors.top: activeTime.bottom
      text: Total Time:
      margin-top: 10

    TextEdit
      id: totalTime
      anchors.left: totalTimeLabel.right
      anchors.top: prev.top
      margin-top: -5
      margin-left: 13
      width: 125

    Label
      id: posXLabel
      anchors.left: totalTimeLabel.left
      anchors.top: totalTime.bottom
      text: X:
      margin-top: 10

    TextEdit
      id: posX
      anchors.left: posXLabel.right
      anchors.top: prev.top
      margin-top: -5
      margin-left: 68
      width: 35

    Label
      id: posYLabel
      anchors.left: posX.right
      anchors.top: posX.top
      text: Y:
      margin-top: 5
      margin-left: 25

    TextEdit
      id: posY
      anchors.left: posYLabel.right
      anchors.top: prev.top
      margin-top: -5
      margin-left: 21
      width: 35

    Button
      id: addSpell
      anchors.left: spellList.right
      anchors.bottom: parent.bottom
      margin-bottom: 2
      margin-left: 8
      text: Add
      size: 200 17
      font: cipsoftFont

  VerticalSeparator
    id: sep
    anchors.top: parent.top
    anchors.left: prev.right
    anchors.bottom: MainPanel.bottom
    margin-left: 10
    margin-bottom: 5
    
  Label
    anchors.left: prev.right
    anchors.right: parent.right
    anchors.top: parent.top
    text-align: center
    text: Additional Information

  HorizontalSeparator
    anchors.left: prev.left
    anchors.top: prev.bottom  
    anchors.right: prev.right
    margin-top: 5
    margin-left: 10

  Label 
    id: FirstAditionalLabel
    anchors.top: prev.bottom
    anchors.left: prev.left
    margin-top: 10
    margin-left: 5
    text: *Spell Name: Orange message above the char

  Label 
    anchors.top: prev.bottom
    anchors.left: prev.left
    margin-top: 10
    text: *On Screen: How it will appear on the screen

  Label 
    anchors.top: prev.bottom
    anchors.left: prev.left
    margin-top: 10
    text: *Active Time: Total time the spell is active

  Label 
    anchors.top: prev.bottom
    anchors.left: prev.left
    margin-top: 10
    text: *Total Time: Total Cooldown time

  Label 
    anchors.top: prev.bottom
    anchors.left: prev.left
    margin-top: 10
    text: *Pos X/Y: Position on the X and Y axis

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top
    margin-bottom: 8    

  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 15
    margin-right: 5
      
]], g_ui.getRootWidget());
windowUI:hide();
local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text;
TimeSpellConfig = {
    spells = {},
};

local spellsWidgets = {};

local timeSpellFile = "/bot/" .. configName .. "/".. name() .. "_TimeSpell.json";
local MainPanel = windowUI.MainPanel;

local editActiveTime = nil;
local editTotalTime = nil;

if g_resources.fileExists(timeSpellFile) then
    local status, result = pcall(function() 
      return json.decode(g_resources.readFileContents(timeSpellFile)) 
    end)
    if not status then
      return onError("Error loading file (" .. timeSpellFile .. "). To fix the problem, delete TimeSpell.json. Details:" .. result)
    end
    TimeSpellConfig = result
    if (type(TimeSpellConfig.spells) ~= 'table') then
        TimeSpellConfig.spells = {};
    end

    for i, object in pairs(TimeSpellConfig.spells) do
        if (object.totalCd - now > object.totalTime) then
            TimeSpellConfig.spells[i].totalCd = 0;
            TimeSpellConfig.spells[i].activeCd = 0;
        end
    end
end

function timeSpellConfigSave()
    local configFile =  timeSpellFile;

    local status, result = pcall(function() 
        return json.encode(TimeSpellConfig, 2) 
    end);

    if not status then
        return onError("Error saving configuration. Details: " .. result);
    end
      
    if result:len() > 100 * 1024 * 1024 then
        return onError("Configuration file over 100MB will not be saved.");
    end

    g_resources.writeFileContents(timeSpellFile, result);
end

ui.title:setOn(TimeSpellConfig.enabled);
ui.title.onClick = function(widget)
    TimeSpellConfig.enabled = not TimeSpellConfig.enabled;
    widget:setOn(TimeSpellConfig.enabled);

    timeSpellConfigSave();

    if (not TimeSpellConfig.enabled) then
        for i, widget in pairs(spellsWidgets) do
            if (widget ~= nil) then
                spellsWidgets[i]:destroy();
                spellsWidgets[i] = nil;
            end
        end
    end
end
ui.settings.onClick = function(widget)
    windowUI:show();
    windowUI:raise();
    windowUI:focus();
end
windowUI.closeButton.onClick = function(widget)
    windowUI:hide();
    timeSpellConfigSave();
end

local destroySpellWidget = function(key)
    spellsWidgets[key]:destroy();
    spellsWidgets[key] = nil;
end

local refreshSpells = function()
    if TimeSpellConfig.spells then
      for i, child in pairs(MainPanel.spellList:getChildren()) do
        child:destroy();
      end
      for _, entry in pairs(TimeSpellConfig.spells) do
        local label = UI.createWidget('SpellEntry', MainPanel.spellList);
        label.onDoubleClick = function(widget)
            local spellTable = entry;
            TimeSpellConfig.spells[entry.spell] = nil;
            reindexTable(TimeSpellConfig.spells);
            if (spellsWidgets[spellTable.spell] ~= nil) then
                spellsWidgets[spellTable.spell]:destroy();
                spellsWidgets[spellTable.spell] = nil;
            end
            MainPanel.spellName:setText(spellTable.spell);
            MainPanel.onScreen:setText(spellTable.onScreen);
            MainPanel.activeTime:setText(spellTable.activeTime);
            MainPanel.totalTime:setText(spellTable.totalTime);
            MainPanel.posX:setText(spellTable.x);
            MainPanel.posY:setText(spellTable.y);
            label:destroy();
        end
        label.enabled:setChecked(entry.enabled);
        label.enabled.onClick = function(widget)
          entry.enabled = not entry.enabled;
          label.enabled:setChecked(entry.enabled);
        end
        label.remove.onClick = function(widget)
          TimeSpellConfig.spells[entry.spell] = nil;
          destroySpellWidget(entry.spell);
          reindexTable(TimeSpellConfig.spells);
          label:destroy();
        end
        label:setText('['.. entry.onScreen .. ']: Cooldown: ' .. entry.totalTime / 1000 .. 's');
      end
    end
end

refreshSpells();

MainPanel.addSpell.onClick = function(widget)

    local spellName = MainPanel.spellName:getText():trim():lower();
    local onScreenName = MainPanel.onScreen:getText():trim();
    local activeTime = tonumber(MainPanel.activeTime:getText()) or 0;
    local totalTime = tonumber(MainPanel.totalTime:getText());
    local posX = tonumber(MainPanel.posX:getText()) or 0;
    local posY = tonumber(MainPanel.posY:getText()) or 39;

    if (not totalTime) then
        return warn('TimeSpell: Enter a valid cooldown.');
    end

    if (not posX) then
        return warn('TimeSpell: Enter a valid Y position.');
    end

    if (not posY) then
        return warn('TimeSpell: Enter a valid Y position.');
    end

    if (spellName:len() == 0) then
        return warn('TimeSpell: Enter a valid spell.');
    end

    if (onScreenName:len() == 0) then
        return warn('TimeSpell: Put a name on OnScreen.');
    end

    TimeSpellConfig.spells[spellName] = { 
      index = #TimeSpellConfig.spells+1, 
      spell = spellName, 
      onScreen = onScreenName, 
      activeTime = activeTime,
      activeCd = 0,
      totalTime = totalTime,
      totalCd = 0,
      x = posX,
      y = posY,
      enabled = true,
    };

    MainPanel.spellName:setText('');
    MainPanel.onScreen:setText('');
    MainPanel.activeTime:setText('');
    MainPanel.totalTime:setText('');
    MainPanel.posX:setText('');
    MainPanel.posY:setText('');
    refreshSpells();
end

local spellWidget = [[
UIWidget
  background-color: black
  opacity: 0.8
  padding: 0 5
  focusable: true
  phantom: false
  draggable: true
]];

local function formatRemainingTime(time)
    local remainingTime = (time - now) / 1000;
    local timeText = '';
    timeText = string.format("%.0f", (time - now) / 1000).. "s";
    return timeText;
end

local function attachSpellWidgetCallbacks(key)
    spellsWidgets[key].onDragEnter = function(widget, mousePos)
        if not modules.corelib.g_keyboard.isCtrlPressed() then
          return false
        end
        widget:breakAnchors()
        widget.movingReference = { x = mousePos.x - widget:getX(), y = mousePos.y - widget:getY() }
        return true
    end
  
    spellsWidgets[key].onDragMove = function(widget, mousePos, moved)
        local parentRect = widget:getParent():getRect()
        local x = math.min(math.max(parentRect.x, mousePos.x - widget.movingReference.x), parentRect.x + parentRect.width - widget:getWidth())
        local y = math.min(math.max(parentRect.y - widget:getParent():getMarginTop(), mousePos.y - widget.movingReference.y), parentRect.y + parentRect.height - widget:getHeight())        
        widget:move(x, y)
        return true
    end
  
    spellsWidgets[key].onDragLeave = function(widget, pos)
      TimeSpellConfig.spells[key].x = widget:getX();
      TimeSpellConfig.spells[key].y = widget:getY();
      timeSpellConfigSave();
      return true
    end
end

local TimeSpellMacro = macro(macroDelay, function() 
    if (not ui.title:isOn()) then return; end

    for index, object in pairs(TimeSpellConfig.spells) do
      if (not object.enabled and spellsWidgets[object.spell] ~= nil) then
          spellsWidgets[object.spell]:destroy();
          spellsWidgets[object.spell] = nil;
      elseif (object.enabled) then
          if (spellsWidgets[object.spell] == nil) then
              spellsWidgets[object.spell] = setupUI(spellWidget, g_ui.getRootWidget());
              spellsWidgets[object.spell]:setPosition({ x = object.x, y = object.y })
              attachSpellWidgetCallbacks(object.spell);
          end
          
          if (not object.totalCd or object.totalCd < now) then
              spellsWidgets[object.spell]:setText(object.onScreen .. ': OK!');
              spellsWidgets[object.spell]:setColor('green');
          elseif (object.activeCd >= now) then
              spellsWidgets[object.spell]:setColor('blue');
              local timeText = formatRemainingTime(object.activeCd);
              spellsWidgets[object.spell]:setText(object.onScreen .. ': ' .. timeText);
          else
              spellsWidgets[object.spell]:setColor('red');
              local timeText = formatRemainingTime(object.totalCd);
              spellsWidgets[object.spell]:setText(object.onScreen .. ': ' .. timeText);
          end
      end
    end
end);

onTalk(function(name, level, mode, text, channelId, pos)
    if (name ~= player:getName()) then return; end

    text = text:lower();
    if (TimeSpellConfig.spells[text] == nil) then return; end
    if (TimeSpellConfig.spells[text].activeTime > 0) then
        TimeSpellConfig.spells[text].activeCd = now + TimeSpellConfig.spells[text].activeTime;
    end
    TimeSpellConfig.spells[text].totalCd = now + TimeSpellConfig.spells[text].totalTime;
    timeSpellConfigSave();
end);
