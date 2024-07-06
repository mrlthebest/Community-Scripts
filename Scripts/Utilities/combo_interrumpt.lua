local macroName = 'Combo';
local macroDelay = 100;
local tabName = 'Main';
setDefaultTab(tabName);


local spellEntry = [[
UIWidget
  background-color: alpha
  text-offset: 18 0
  focusable: true
  height: 16

  CheckBox
    id: enabled
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: 15
    height: 15
    margin-top: 2
    margin-left: 3

  $focus:
    background-color: #00000055

  Button
    id: remove
    !text: tr('x')
    anchors.right: parent.right
    margin-right: 15
    width: 15
    height: 15
]]

local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text
local spellEntryFile = "/bot/"..configName.."/uSpellEntry.otui"
if not g_resources.fileExists(spellEntryFile) then
    g_resources.writeFileContents(spellEntryFile, spellEntry)
end

ConfigNeox = {};

ConfigNeox.read = function(filePath, callback)
    if g_resources.fileExists(filePath) then
        local status, result = pcall(function()
            return json.decode(g_resources.readFileContents(filePath))
        end)
        if not status then
            return onError("Erro carregando arquivo (" .. filePath .. "). Para consertar o problema, exclua o arquivo. Detalhes: " .. result)
        end

        callback(result);
    end
end

ConfigNeox.save = function(configFile, content)
    local status, result = pcall(function()
        return json.encode(content, 2)
    end);

    if not status then
        return onError("Erro salvando configuração. Detalhes: " .. result);
    end

    if result:len() > 100 * 1024 * 1024 then
        return onError("Arquivo de configuração acima de 100MB, não será salvo.");
    end

    g_resources.writeFileContents(configFile, result);
end




combointerruptPanelName = "combointerrupt"
local uiInterrupt = setupUI([[
Panel
  height: 17
  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Combo Interrupt')

  Button
    id: settings
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Setup
]])
uiInterrupt:setId(combointerruptPanelName);
uiInterrupt.title:setText(macroName .. ' Interrupt')

local assignWindow = setupUI([[
MainWindow
  id: assignWindow
  !text: tr('Button Assign')
  size: 360 150
  @onEscape: self:destroy()

  Label
    !text: tr('Please, press the key you wish to use for action')
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    text-auto-resize: true
    text-align: left

  Label
    id: comboPreview
    !text: tr('Current action hotkey: %s', 'none')
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: prev.bottom
    margin-top: 10
    text-auto-resize: true

  HorizontalSeparator
    id: separator
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: next.top
    margin-bottom: 10

  Button
    id: addButton
    !text: tr('Add')
    width: 64
    anchors.right: next.left
    anchors.bottom: parent.bottom
    margin-right: 10

  Button
    id: cancelButton
    !text: tr('Cancel')
    width: 64
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    @onClick: self:getParent():destroy()
]], g_ui.getRootWidget());

assignWindow:hide();

local windowInterrupt = setupUI([[
SpellEntry < Label
  background-color: alpha
  text-offset: 18 0
  focusable: true
  height: 16

  CheckBox
    id: enabled
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: 15
    height: 15
    margin-top: 2
    margin-left: 3

  $focus:
    background-color: #00000055

  Button
    id: remove
    !text: tr('x')
    anchors.right: parent.right
    margin-right: 15
    width: 15
    height: 15

MainWindow
  !text: tr('Combo Interrupt by VictorNeox')
  size: 220 308
  
  Panel
    id: MainPanel
    anchors.top: parent.top
    anchors.left: parent.left
    image-border: 6
    padding: 3
    size: 187 225

    
    TextList
      id: spellList
      anchors.left: parent.left
      anchors.top: parent.top
      padding: 1
      size: 175 195    
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
    
    Button
      id: addKey
      !text: tr('Select Key')
      anchors.top: spellList.bottom
      anchors.left: spellList.left
      width: 175
      height: 20
      margin-top: 4
      padding: 1
        
  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 25
    margin-right: 5
      
]], g_ui.getRootWidget());
windowInterrupt:hide();
local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text;
ComboInterruptConfig = {
    keys = {},
    enabled = false,
};

ComboInterrupt = {};

local MAIN_DIRECTORY = "/bot/" .. configName .. "/" .. "neox_combointerrupt/";
if not g_resources.directoryExists(MAIN_DIRECTORY) then
    g_resources.makeDir(MAIN_DIRECTORY);
end


local comboInterruptFile = "" .. MAIN_DIRECTORY .. "combointerrupt_config.json";
local MainPanel = windowInterrupt.MainPanel;

ConfigNeox.read(comboInterruptFile, function(result)
    ComboInterruptConfig = result
    if (type(ComboInterruptConfig.keys) ~= 'table') then
        ComboInterruptConfig.keys = {};
    end
end);

function ComboInterrupt.save()
    ConfigNeox.save(comboInterruptFile, ComboInterruptConfig);
end

uiInterrupt.title:setOn(ComboInterruptConfig.enabled);
uiInterrupt.title.onClick = function(widget)
    ComboInterruptConfig.enabled = not ComboInterruptConfig.enabled;
    widget:setOn(ComboInterruptConfig.enabled);
    ComboInterrupt.save();
end

uiInterrupt.settings.onClick = function(widget)
  if not windowInterrupt:isVisible() then
    windowInterrupt:show();
    windowInterrupt:raise();
    windowInterrupt:focus();
  else
    windowInterrupt:hide();
    ComboInterrupt.save();
  end
end
windowInterrupt.closeButton.onClick = function(widget)
    windowInterrupt:hide();
    ComboInterrupt.save();
end

ComboInterrupt.refreshSpells = function()
    if ComboInterruptConfig.keys then
        for i, child in pairs(MainPanel.spellList:getChildren()) do
            child:destroy();
        end
        for index, entry in pairs(ComboInterruptConfig.keys) do
            local label = UI.createWidget('SpellEntry', MainPanel.spellList)
            label.enabled:setChecked(entry.enabled);
            label.enabled.onClick = function(widget)
                entry.enabled = not entry.enabled;
                label.enabled:setChecked(entry.enabled);
            end
            label.remove.onClick = function(widget)
                ComboInterruptConfig.keys[index] = nil;
                label:destroy();
            end
            label:setText('  [ '.. index .. ' ]');
        end
    end
end

assignWindow.comboPreview.keyCombo = '';


MainPanel.addKey.onClick = function(widget)
    assignWindow:show();
    assignWindow:grabKeyboard();
    assignWindow.onKeyDown = function(assignWindow, keyCode, keyboardModifiers)
        local keyCombo = modules.corelib.KeyCodeDescs[keyCode]
        assignWindow.comboPreview:setText(tr('Current action hotkey: %s', keyCombo));
        assignWindow.comboPreview.keyCombo = keyCombo;
        assignWindow.comboPreview:resizeToText();
        return true;
    end
end

assignWindow.addButton.onClick = function()
    local text = assignWindow.comboPreview.keyCombo;
    if (text:len() == 0 or ComboInterruptConfig.keys[text]) then
        return warn('Invalid Key or Key already exists');
    end
    ComboInterruptConfig.keys[text] = {
        enabled = true
    };
    ComboInterrupt.save();
    ComboInterrupt.refreshSpells();
    assignWindow.comboPreview:setText(tr('Current action hotkey: %s', 'none'));
    assignWindow.comboPreview.keyCombo = '';
    assignWindow:hide();
end





-- MainPanel.moveUp.onClick = function()
--   local action = MainPanel.spellList:getFocusedChild();
--   if (not action) then return; end
--   local index = MainPanel.spellList:getChildIndex(action);
--   if (index < 2) then return; end
--   MainPanel.spellList:moveChildToIndex(action, index - 1);
--   MainPanel.spellList:ensureChildVisible(action);
--   ComboInterruptConfig.spells[index].index = index - 1;
--   ComboInterruptConfig.spells[index - 1].index = index;
--   table.sort(ComboInterruptConfig.spells, function(a,b) return a.index < b.index end)
--   ComboInterrupt.save();
-- end

-- MainPanel.moveDown.onClick = function()
--   local action = MainPanel.spellList:getFocusedChild()
--   if not action then return end
--   local index = MainPanel.spellList:getChildIndex(action)
--   if index >= MainPanel.spellList:getChildCount() then return end
--   MainPanel.spellList:moveChildToIndex(action, index + 1);
--   MainPanel.spellList:ensureChildVisible(action);
--   ComboInterruptConfig.spells[index].index = index + 1;
--   ComboInterruptConfig.spells[index + 1].index = index;
--   table.sort(ComboInterruptConfig.spells, function(a,b) return a.index < b.index end)
--   ComboInterrupt.save();
-- end

-- ComboInterrupt.canCast = function(spell)
--   if (TimeSpellConfig.spells[spell] == nil or TimeSpellConfig.spells[spell].totalTime >= now) then
--     return false;
--   end
--   return true;
-- end

-- ComboInterrupt.macro = macro(100, function()
--   if (not ui.title:isOn()) then return; end
--   if (isInPz()) then return; end
--   if (not g_game.isAttacking()) then return; end

--   local target = g_game.getAttackingCreature();
--   local distance = getDistanceBetween(player:getPosition(), target:getPosition());
--   for index, obj in ipairs(ComboInterruptConfig.spells) do
--     if (obj.enabled and distance <= obj.distance) then
--       if (not obj.shouldLinkTimeSpell or ComboInterrupt.canCast(obj.spell)) then
--         say(obj.spell);
--       end
--     end
--   end
-- end);

-- MainPanel.distance.onValueChange = function(scroll, value)
--   MainPanel.distanceCountLabel:setText(value);
-- end


-- ComboInterrupt.refreshConfigOptions = function()
--   windowUI.configsList:clearOptions();
--   local configFiles = g_resources.listDirectoryFiles(MAIN_DIRECTORY)
--   for i, file in ipairs(configFiles) do
--     if (g_resources.isFileType(file, 'json')) then
--       local fileName = file:split(".")[1];
--       windowUI.configsList:addOption(fileName)
--     end
--   end
--   windowUI.configsList:setOption(name());
-- end


ComboInterrupt.init = function()
    ComboInterrupt.refreshSpells();
end

-- ComboInterrupt.fullRefresh = function()
--   ComboInterrupt.save();
--   ComboInterrupt.refreshConfigOptions();
--   ComboInterrupt.refreshSpells();
-- end
ComboInterrupt.init();

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

combobotPanelName = "combobot"
local ui = setupUI([[
Panel
  height: 17
  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Combo')

  Button
    id: settings
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Setup
]])
ui:setId(combobotPanelName);
ui.title:setText(macroName)

local windowUI = setupUI([[
MainWindow
  !text: tr('Combo by VictorNeox - edited by mrlthebest. ')
  size: 575 315
  
  Panel
    id: MainPanel
    image-source: /images/ui/panel_flat
    anchors.top: parent.top
    anchors.left: parent.left
    image-border: 6
    padding: 3
    size: 537 225

    
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
      anchors.left: spellName.right
      anchors.top: parent.top
      text: Spell
      margin-top: 10
      margin-left: 7

    TextEdit
      id: spellName
      anchors.left: spellList.right
      anchors.top: parent.top
      margin-left: 30
      margin-top: 8
      width: 125

    Label
      id: orangeMsgLabel
      anchors.left: spellNameLabel.left
      anchors.top: spellName.bottom
      margin-top: 15
      text: Orange Spell

    TextEdit
      id: orangeMsg
      anchors.left: spellName.left
      anchors.top: prev.top
      margin-top: -5
      width: 125

    Label
      id: cooldownLabel
      anchors.left: orangeMsgLabel.left
      anchors.top: orangeMsg.bottom
      margin-top: 15
      text: Cooldown

    HorizontalScrollBar
      id: cooldown
      anchors.left: orangeMsg.left
      anchors.top: prev.top
      margin-top: 0
      width: 125
      minimum: 0
      maximum: 60000
      step: 500

    Label
      id: hppercentLabel
      anchors.left: cooldownLabel.left
      anchors.top: cooldown.bottom
      text: Hppercent
      margin-top: 15

    HorizontalScrollBar
      id: hppercent
      anchors.left: cooldown.left
      anchors.top: prev.top
      width: 125
      minimum: 1
      maximum: 100
      step: 1

    Label
      id: distanceLabel
      anchors.left: cooldownLabel.left
      anchors.top: hppercent.bottom
      text: Distance
      margin-top: 15

    HorizontalScrollBar
      id: distance
      anchors.left: cooldown.left
      anchors.top: prev.top
      width: 125
      minimum: 1
      maximum: 8
      step: 1

    Label
      id: levelLabel
      anchors.left: cooldownLabel.left
      anchors.top: distance.bottom
      text: Level
      margin-top: 15

    HorizontalScrollBar
      id: level
      anchors.left: cooldown.left
      anchors.top: prev.top
      width: 125
      minimum: 1
      maximum: 1000
      step: 1
    
  Button
    id: moveUp
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-left: 15
    margin-top: 30
    text: ^
    size: 15 15
    font: cipsoftFont

  Button
    id: moveDown
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-left: 15
    margin-bottom: 80
    text: ^
    rotation: 180
    size: 15 15
    font: cipsoftFont

  Button
    id: addSpell
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    margin-bottom: 50
    margin-right: 50
    text: Add
    size: 60 17
    font: cipsoftFont

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top
    margin-bottom: 5

  VerticalSeparator
    id: separator2
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: closeButton.bottom
    anchors.top: parent.top
    margin-bottom: 30
    margin-left: 25    

  ComboBox
    id: configsList
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    text-offset: 3 0
    width: 200
    
  Button
    id: loadButton
    !text: tr('Load')
    font: cipsoftFont
    anchors.left: configsList.right
    anchors.bottom: parent.bottom
    size: 45 23
    margin-top: 15
    margin-left: 5
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
ComboBotConfig = {
    spells = {},
};

ComboBot = {};

local MAIN_DIRECTORY = "/bot/" .. configName .. "/" .. "neox_combobot/";
if not g_resources.directoryExists(MAIN_DIRECTORY) then
    g_resources.makeDir(MAIN_DIRECTORY);
end


local comboBotFile = "" .. MAIN_DIRECTORY .. name() .. ".json";
local MainPanel = windowUI.MainPanel;

ConfigNeox.read(comboBotFile, function(result)
    ComboBotConfig = result
    if (type(ComboBotConfig.spells) ~= 'table') then
        ComboBotConfig.spells = {};
    end
end);

function ComboBot.save()
    ConfigNeox.save(comboBotFile, ComboBotConfig);
end

ui.title:setOn(ComboBotConfig.enabled);
ui.title.onClick = function(widget)
    ComboBotConfig.enabled = not ComboBotConfig.enabled;
    widget:setOn(ComboBotConfig.enabled, moveCombo);
    moveCombo.setOn(ComboBotConfig.enabled);
    ComboBot.save();
end

ui.settings.onClick = function(widget)
  if not windowUI:isVisible() then
    windowUI:show();
    windowUI:raise();
    windowUI:focus();
  else
    windowUI:hide();
  end
end
windowUI.closeButton.onClick = function(widget)
    windowUI:hide();
    ComboBot.save();
end


ComboBot.refreshSpells = function()
    if ComboBotConfig.spells then
        for i, child in pairs(MainPanel.spellList:getChildren()) do
            child:destroy();
        end
        for index, entry in ipairs(ComboBotConfig.spells) do
            local label = setupUI(spellEntry, MainPanel.spellList);
            label.onDoubleClick = function(widget)
                local spellTable = entry;
                table.remove(ComboBotConfig.spells, index);
                reindexTable(ComboBotConfig.spells);
                MainPanel.spellName:setText(spellTable.spell);
                MainPanel.cooldown:setText(spellTable.cooldown);
                MainPanel.distance:setValue(spellTable.distance);
                MainPanel.level:setValue(spellTable.level)
                MainPanel.hppercent:setValue(spellTable.hppercent);
                label:destroy();
            end
            label.enabled:setChecked(entry.enabled);
            label.enabled.onClick = function(widget)
                entry.enabled = not entry.enabled;
                label.enabled:setChecked(entry.enabled);
            end
            label.remove.onClick = function(widget)
                ComboBotConfig.spells[index] = nil;
                reindexTable(ComboBotConfig.spells);
                label:destroy();
            end
            label:setText('Spell: ' .. entry.spell)
            label:setTooltip('Orange Message: ' .. entry.orangeSpell .. ' | Cooldown: ' .. entry.cooldown / 1000 .. 's | Hppercent: ' .. entry.hppercent .. ' | Distance: ' .. entry.distance .. ' | Level: ' .. entry.level)
        end
    end
end

function reindexTable(t)
    if not t or type(t) ~= "table" then return end

    local i = 0
    for _, e in pairs(t) do
        i = i + 1
        e.index = i
    end
end


windowUI.addSpell.onClick = function(widget)

    local spellName = MainPanel.spellName:getText():trim():lower();
    local orangeMsg = MainPanel.orangeMsg:getText():trim():lower();
    orangeMsg = (orangeMsg:len() == 0) and spellName or orangeMsg;
    local cooldown = MainPanel.cooldown:getValue();
    local distance = MainPanel.distance:getValue();
    local hppercent = MainPanel.hppercent:getValue();
    local level = MainPanel.level:getValue();

    if (spellName:len() == 0) then
        return warn('ComboBot: Enter a valid spell.');
    end

    if (shouldLinkTimeSpell and not cooldown) then
        return warn('ComboBot: Enter a cooldown or disable time spell integration.');
    end

    table.insert(ComboBotConfig.spells, {
        index = #ComboBotConfig.spells+1,
        spell = spellName,
        orangeSpell = orangeMsg,
        cooldown = cooldown,
        distance = distance,
        hppercent = hppercent,
        level = level,
        enabled = true
    });
    MainPanel.spellName:clearText();
    MainPanel.orangeMsg:clearText();
    MainPanel.cooldown:setText(1);
    MainPanel.distance:setValue(1);
    MainPanel.hppercent:setValue(1);
    MainPanel.level:setValue(1);
    ComboBot.refreshSpells();
end

windowUI.moveUp.onClick = function()
    local action = MainPanel.spellList:getFocusedChild();
    if (not action) then return; end
    local index = MainPanel.spellList:getChildIndex(action);
    if (index < 2) then return; end
    MainPanel.spellList:moveChildToIndex(action, index - 1);
    MainPanel.spellList:ensureChildVisible(action);
    ComboBotConfig.spells[index].index = index - 1;
    ComboBotConfig.spells[index - 1].index = index;
    table.sort(ComboBotConfig.spells, function(a,b) return a.index < b.index end)
    ComboBot.save();
end

windowUI.moveDown.onClick = function()
    local action = MainPanel.spellList:getFocusedChild()
    if not action then return end
    local index = MainPanel.spellList:getChildIndex(action)
    if index >= MainPanel.spellList:getChildCount() then return end
    MainPanel.spellList:moveChildToIndex(action, index + 1);
    MainPanel.spellList:ensureChildVisible(action);
    ComboBotConfig.spells[index].index = index + 1;
    ComboBotConfig.spells[index + 1].index = index;
    table.sort(ComboBotConfig.spells, function(a,b) return a.index < b.index end)
    ComboBot.save();
end

function isAnyKeyPressed()
  if (ComboInterruptConfig and ComboInterruptConfig.enabled) then
    for key, value in pairs(ComboInterruptConfig.keys) do
      if (modules.corelib.g_keyboard.isKeyPressed(key)) then
        return true;
      end
    end
  end
  return false;
end

ComboBot.macro = macro(macroDelay, function()
    if (not ui.title:isOn()) then return; end
    local playerPos = pos();
    if not g_game.isAttacking() then return; end
    local target = g_game.getAttackingCreature();
    local targetPos = target:getPosition();
    local targetHealth = target:getHealthPercent();
    if not targetPos then return end
    local targetDistance = getDistanceBetween(playerPos, targetPos);
    for index, obj in ipairs(ComboBotConfig.spells) do
        if isAnyKeyPressed() then return; end
        if (obj.enabled and targetDistance <= obj.distance and targetHealth <= obj.hppercent and player:getLevel() >= obj.level) then
            if (not obj.cooldownSpells or obj.cooldownSpells <= now) then
                say(obj.spell);
            end
        end
    end
end)


onTalk(function(name, level, mode, text, channelId, pos)
    text = text:lower();
    if (name ~= player:getName()) then return; end

    for index, obj in ipairs(ComboBotConfig.spells) do
        if text == obj.orangeSpell then
            obj.cooldownSpells = now + obj.cooldown;
            break
        end
    end
end);


MainPanel.distance:setText('0')
MainPanel.level:setText('0')
MainPanel.cooldown:setText('0s')
MainPanel.hppercent:setText('0%')
MainPanel.distance.onValueChange = function(scroll, value)
    MainPanel.distance:setText(value);
end
MainPanel.level.onValueChange = function(scroll, value)
    MainPanel.level:setText(value);
end

MainPanel.hppercent.onValueChange = function(scroll, value)
    MainPanel.hppercent:setText(value .. '%');
end

MainPanel.cooldown.onValueChange = function(scroll, value)
    MainPanel.cooldown:setText(value .. 'ms');
end


local setCooldown = false;
local numbers = '';

MainPanel.cooldown.onHoverChange = function(widget, hovered)
    if hovered then
        setCooldown = true;
    else
        setCooldown = false;
        numberSequence = "";
    end
end


onKeyPress(function(key)
    if not setCooldown then return; end
    if key >= '0' and key <= '9' then
        numbers = numbers .. key
        MainPanel.cooldown:setValue(tonumber(numbers))
        MainPanel.cooldown:setText(tonumber(numbers) .. 'ms')
    elseif key == 'Escape' then
        MainPanel.cooldown:setValue(0)
        MainPanel.cooldown:setText('0ms')
        numbers = '';
    end
end);


ComboBot.refreshConfigOptions = function()
    windowUI.configsList:clearOptions();
    local configFiles = g_resources.listDirectoryFiles(MAIN_DIRECTORY)
    for i, file in ipairs(configFiles) do
        if (g_resources.isFileType(file, 'json')) then
            local fileName = file:split(".")[1];
            windowUI.configsList:addOption(fileName)
        end
    end
    windowUI.configsList:setOption(name());
end


ComboBot.init = function()
    ComboBot.refreshConfigOptions();
    ComboBot.refreshSpells();
end

ComboBot.fullRefresh = function()
    ComboBot.save();
    ComboBot.refreshConfigOptions();
    ComboBot.refreshSpells();
end

windowUI.loadButton.onClick = function()
    local SELECTED_OPTION = windowUI.configsList:getCurrentOption().text;
    local OPTION_FILE_COMBO = MAIN_DIRECTORY .. SELECTED_OPTION .. ".json";
    ConfigNeox.read(OPTION_FILE_COMBO, function(result)
        ComboBotConfig = result;
        ComboBot.fullRefresh();
    end);
    warn('ComboBot: Configuration ' .. SELECTED_OPTION .. ' loaded')
end
ComboBot.init();

