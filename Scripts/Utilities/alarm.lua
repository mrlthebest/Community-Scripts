
local panelName = "alarmsAnen"

local ui = setupUI([[
Panel
  height: 19

  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('Alarms +')

  Button
    id: alerts
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Edit
AlarmCheckBox < Panel
  height: 20
  margin-top: 2

  CheckBox
    id: tick
    anchors.fill: parent
    margin-top: 4
    font: verdana-11px-rounded
    text: Player Attack
    text-offset: 17 -3

AlarmCheckBoxAndSpinBox < Panel
  height: 20
  margin-top: 2

  CheckBox
    id: tick
    anchors.fill: parent
    anchors.right: next.left
    margin-top: 4
    font: verdana-11px-rounded
    text: Player Attack
    text-offset: 17 -3

  SpinBox
    id: value
    anchors.top: parent.top
    margin-top: 1
    margin-bottom: 1
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    width: 40
    minimum: 0
    maximum: 100
    step: 1
    editable: true
    focusable: true

AlarmCheckBoxAndTextEdit < Panel
  height: 20
  margin-top: 2

  CheckBox
    id: tick
    anchors.fill: parent
    anchors.right: next.left
    margin-top: 4
    font: verdana-11px-rounded
    text: Creature Name
    text-offset: 17 -3

  BotTextEdit
    id: text
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: 150
    font: terminus-10px
    margin-top: 1
    margin-bottom: 1

AlarmsAnenWindow < MainWindow
  !text: tr('[ANEN] Alarms +')
  size: 330 650
  padding: 15
  @onEscape: self:hide()

  FlatPanel
    id: list
    anchors.fill: parent
    anchors.bottom: settingsList.top
    margin-bottom: 20
    margin-top: 10
    layout: verticalBox
    padding: 10
    padding-top: 5

  FlatPanel
    id: settingsList
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: separator.top
    margin-bottom: 5
    margin-top: 10
    padding: 5
    padding-left: 10
    layout: 
      type: verticalBox
      fit-children: true

  Label
    anchors.verticalCenter: settingsList.top
    anchors.left: settingsList.left
    margin-left: 5
    width: 200
    text: Alarms Settings
    font: verdana-11px-rounded
    color: #9f5031

  Label
    anchors.verticalCenter: list.top
    anchors.left: list.left
    margin-left: 5
    width: 200
    text: Active Alarms
    font: verdana-11px-rounded
    color: #9f5031

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top
    margin-bottom: 8

  ResizeBorder
    id: bottomResizeBorder
    anchors.fill: separator
    height: 3
    minimum: 260
    maximum: 600
    margin-left: 3
    margin-right: 3
    background: #ffffff88  

  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-right: 5
    @onClick: self:getParent():hide()
    
]])
ui:setId(panelName)

if not storage[panelName] then
  storage[panelName] = {}
end

local config = storage[panelName]

ui.title:setOn(config.enabled)
ui.title.onClick = function(widget)
  config.enabled = not config.enabled
  widget:setOn(config.enabled)
end

local window = UI.createWindow("AlarmsAnenWindow")
window:hide()

ui.alerts.onClick = function()
  window:show()
  window:raise()
  window:focus()
end

local widgets = 
{
  "AlarmCheckBox", 
  "AlarmCheckBoxAndSpinBox", 
  "AlarmCheckBoxAndTextEdit"
}

local parents = 
{
  window.list, 
  window.settingsList
}


-- type
addAlarm = function(id, title, defaultValue, alarmType, parent, tooltip, delayAlarm)
  local widget = UI.createWidget(widgets[alarmType], parents[parent])
  widget:setId(id)

  if type(config[id]) ~= 'table' then
    config[id] = {}
  end
  config[id].delay = delayAlarm or nil
  widget.tick:setText(title)
  widget.tick:setChecked(config[id].enabled)
  widget.tick:setTooltip(tooltip)
  -- widget.tick.setOn(config[id].enabled)
  widget.tick.onClick = function()
    if id == "ignoreFriends" and not isFriend then
      warn("To use this option you need 'Player Lists (vBot4.8)'. ")
      widget.tick:setChecked(false)
      return
    end
    config[id].enabled = not config[id].enabled
    widget.tick:setChecked(config[id].enabled)
  end

  if alarmType > 1 and type(config[id].value) == 'nil' then
    config[id].value = defaultValue
  end

  if alarmType == 2 then
    widget.value:setValue(config[id].value)
    widget.value.onValueChange = function(widget, value)
      config[id].value = value
    end
  elseif alarmType == 3 then
    widget.text:setText(config[id].value)
    widget.text.onTextChange = function(widget, newText)
      config[id].value = newText
    end
  end
  return widget
end

-- settings
addAlarm("ignoreFriends", "Ignore Friends", true, 1, 2)
addAlarm("ignoreParty", "Ignore Party Member", true, 1, 2)
addAlarm("ignoreGuild", "Ignore Guild Member", true, 1, 2)
addAlarm("flashClient", "Flash Client", true, 1, 2)
addAlarm("doScreenshot", "Do Screenshot", true, 1, 2)

-- alarm list
addAlarm("damageTaken", "Damage Taken", false, 1, 1, nil, 30000)
addAlarm("lowHealth", "Low Health", 20, 2, 1, nil, 20000)
addAlarm("lowMana", "Low Mana", 20, 2, 1, nil, 20000)
addAlarm("lowStamina", "Low Stamina", 39, 2, 1, "If the set value is less than or equal to your stamina, you will be notified", 600000)
addAlarm("playerAttack", "Player Attack", false, 1, 1, nil, 15000)
addAlarm("noParty", "No party", false, 1, 1, nil, 120000)
addAlarm("noPartySharedExperience", "No party shared experience", false, 1, 1, nil, 180000)
addAlarm("playerDead", "Player dead", false, 1, 1, nil, 180000)
addAlarm("playerUpSkill", "Up Skill", false, 1, 1, nil, 1000)

UI.Separator(window.list)

addAlarm("privateMsg", "Private Message", false, 1, 1)
addAlarm("defaultMsg", "Default Message", false, 1, 1)
addAlarm("customMessage", "Custom Message:", "", 3, 1, "You can add text, that if found in any incoming message will trigger alert.\n You can add many, just separate them by comma.")
addAlarm("discordAlarm", "Discord Alarm:", "1234", 3, 1, "If checked, will send a message to Discord channel (put your ID here).", 10000)
addAlarm("ntfyAlarm", "ntfy Alarm:", "", 3, 1, "If checked, will send a message to Discord channel (put your URL here).", 10000)
UI.Separator(window.list)

addAlarm("creatureDetected", "Creature Detected", false, 1, 1, nil, 50000)
addAlarm("playerDetected", "Player Detected", false, 1, 1, nil, 50000)
addAlarm("creatureName", "Creature Name:", "", 3, 1, "You can add a name or part of it, that if found in any visible creature name will trigger alert.\nYou can add many, just separate them by comma.", 50000)



local lastCallNotify = {}
local function alarm(file, windowText, message, data, key)
  if not lastCallNotify[key] then
    lastCallNotify[key] = 0
  end
  if (now - lastCallNotify[key]) < (data.delay and data.delay or 2000 ) then return end
  lastCallNotify[key] = now
  if not g_resources.fileExists(file) then
    file = "/sounds/alarm.ogg"
  end

  if modules.game_bot.g_app.getOs() == "windows" and config.flashClient.enabled then
    g_window.flash()
  end
  g_window.setTitle(player:getName() .. " - " .. windowText)
  playSound(file)

  if not message then return end

  if config.discordAlarm.enabled then
    local info = {
      user_id = config.discordAlarm.value,
      message = message.message
    }
    HTTP.post('http://139.177.102.132:8001/api/mention', info, function(data, err)

    end)
  end

  if config.ntfyAlarm.enabled then

    local function sendInfo(delay)
      delay = delay or 0
      schedule(delay, function ()
        local info = {
          topic = config.ntfyAlarm.value,
          message = message.message,
          title = windowText,
          tags = message.tags,
          priority = message.priority or 3,
          -- actions = {
--               { 
--                 action = "view",
--                 label = "Open Discord",
--                 url = "https://discord.com/channels/1247624193332216011/1247624193776816308" 
--               },
--               { 
--                 action = "http",
--                 label =  "Turn off",
--                 url = "http://139.177.102.132:8001/api/sendInfo",
--                 body = "{\"temperature\": 65}"
--                }
--         }
        }
        
        HTTP.post('https://ntfy.sh/', json.encode(info), function(data, err)
    
        end)
      end)
    end
    
    if key == "playerDead" and config.doScreenshot.enabled then
      doScreenshot()    
      sendInfo(3000)  
      return
    end
    sendInfo()
  end
end

-- damage taken & custom message
onTextMessage(function(mode, text)
  if not config.enabled then return end
  if not player.isTimedSquareVisible and config.playerAttack.enabled then
    if text:find('hitpoints due to an attack by') then
     local playerName = text:match('You lose %d+ hitpoints due to an attack by (.+)%.')
     local creature = getCreatureByName(playerName)
     if creature and creature:isPlayer() then
       if (not config.ignoreFriends.enabled or not isFriend) or (config.ignoreFriends.enabled and isFriend and not isFriend(playerName)) then 
        if not config.ignoreGuild.enabled and not config.ignoreParty.enabled  then
          return alarm("/sounds/Player_Attack.ogg", "Player Attack!", {tags = {"warning", "dagger"},priority = 5, message = "Your character " .. player:getName() .. " detected player attack: " .. creature:getName()}, config.playerAttack, "playerAttack")
        end
        if (config.ignoreGuild.enabled and not config.ignoreParty.enabled and creature:getEmblem() ~= 1) or (config.ignoreParty.enabled and not config.ignoreGuild.enabled and not creature:isPartyMember()) then
          return alarm("/sounds/Player_Attack.ogg", "Player Attack!", {tags = {"warning", "dagger"},priority = 5, message = "Your character " .. player:getName() .. " detected player attack: " .. creature:getName()}, config.playerAttack, "playerAttack")
        end
      end 
     end
    end
 end

  if mode == 22 and config.damageTaken.enabled then
    return alarm('/sounds/magnum.ogg', "Damage Received!", {tags = {"crossed_swords" , "warning"}, message = "Your character " .. player:getName() .. " received damage: " .. text}, config.damageTaken, "damageTaken")
  end

  if config.customMessage.enabled then
    local alertText = config.customMessage.value
    if alertText:len() > 0 then
      text = text:lower()
      for _, parte in ipairs(alertText:splitrim(",")) do
        if text:find(parte:lower()) then
          return alarm('/sounds/magnum.ogg', "Special Message!",{tags = {"incoming_envelope"},message = "Your character " .. player:getName() .. " received custom message: " .. text}, config.customMessage, "customMessage")
        end
      end
    end
  end

  if config.playerUpSkill.enabled then
    if string.match(text, "You advanced from" or string.match(text, "You advanced in")) then
      return alarm('/sounds/magnum.ogg', "Skill UP!",{tags = {"arrow_up", "clap"}, message = "Your character " .. player:getName() .. " advanced in skill: " .. text}, config.playerUpSkill, "playerUpSkill")
    end
  end
end)

-- default & private message
onTalk(function(name, level, mode, text, channelId, pos)
  if not config.enabled then return end
  if name == player:getName() then return end -- ignore self messages

  if config.ignoreFriends.enabled and isFriend and isFriend(name) then return end -- ignore friends if enabled

  if mode == 1 and config.defaultMsg.enabled then
    return alarm("/sounds/magnum.ogg", "Default Message!",{tags = {"inbox_tray"}, message = "Your character " .. player:getName() .. " received default message: " .. text}, config.privateMsg, "privateMsg")
  end

  if mode == 4 and config.privateMsg.enabled then
    return alarm("/sounds/Private_Message.ogg", "Private Message!",{tags = {"inbox_tray"}, message = "Your character " .. player:getName() .. " received private message: " .. text}, config.privateMsg, "privateMsg")
  end
end)

local function onStaminaSet(stamina)
  local hours = math.floor(stamina / 60)
  local minutes = stamina % 60
  if minutes < 10 then
      minutes = '0' .. minutes
  end
  return tr("You have %s hours and %s minutes left", hours, minutes), hours, minutes
end

local function getPartyShared()
  if g_game.getLocalPlayer():getShield() == modules.gamelib.ShieldYellowSharedExp or
      g_game.getLocalPlayer():getShield() == modules.gamelib.ShieldBlueSharedExp then
      return true
  end
  return false
end

-- health & mana
macro(100, function() 
  
  if not config.enabled then return end
  if config.playerDead.enabled then
    if modules.game_playerdeath.deathWindow then
      modules.game_playerdeath.deathWindow:destroy()
      modules.game_playerdeath.deathWindow = nil
      return alarm("/sounds/alarm.ogg", "Player Death!",{tags = {"sob", "skull_and_crossbones"}, priority = 5, message = "Your character " .. player:getName() .. " is dead"}, config.playerDead, "playerDead")
    end
  end

  if config.lowHealth.enabled then
    if hppercent() < config.lowHealth.value then
      return alarm("/sounds/Low_Health.ogg", "Low Health!",{tags = {"ghost"}, message = "Your character " .. player:getName() .. " has low health: " .. tostring(hppercent()) .. "%"}, config.lowHealth, "lowHealth")
    end
  end

  if config.lowMana.enabled then
    if manapercent() < config.lowMana.value then
      return alarm("/sounds/Low_Mana.ogg", "Low Mana!", {tags = {"ghost"}, message = "Your character " .. player:getName() .. " has low mana: " .. tostring(manapercent()) .. "%"} , config.lowMana, "lowMana")
    end
  end

  for i, spec in ipairs(getSpectators()) do
    if not spec:isLocalPlayer() and not (config.ignoreFriends.enabled and isFriend and isFriend(spec)) then
    
      if config.creatureDetected.enabled then
        return alarm("/sounds/magnum.ogg", "Creature Detected!", {tags = {"astonished"}, message = "Your character " .. player:getName() .. " detected creature: " .. spec:getName()} , config.creatureDetected, "creatureDetected")
      end

      if spec:isPlayer() then 
        if spec.isTimedSquareVisible and spec:isTimedSquareVisible() and config.playerAttack.enabled then
          if not config.ignoreGuild.enabled and not config.ignoreParty.enabled  then
            return alarm("/sounds/Player_Attack.ogg", "Player Attack!", {tags = {"warning", "dagger"},priority = 5, message = "Your character " .. player:getName() .. " detected player attack: " .. spec:getName()}, config.playerAttack, "playerAttack")
          end
          if (config.ignoreGuild.enabled and not config.ignoreParty.enabled and spec:getEmblem() ~= 1) or (config.ignoreParty.enabled and not config.ignoreGuild.enabled and not spec:isPartyMember()) then
            return alarm("/sounds/Player_Attack.ogg", "Player Attack!", {tags = {"warning", "dagger"},priority = 5, message = "Your character " .. player:getName() .. " detected player attack: " .. spec:getName()}, config.playerAttack, "playerAttack")
          end
        end
        if config.playerDetected.enabled then
          return alarm("/sounds/Player_Detected.ogg", "Player Detected!", {tags = {"warning", "eyes", "eyes"}, message = "Your character " .. player:getName() .. " detected player: " .. spec:getName()} , config.playerDetected, "playerDetected")
        end
      end

      if config.creatureName.enabled then
        local name = spec:getName():lower()
        for _, value in ipairs(config.creatureName.value:splitrim(",")) do
          if name:find(value:lower()) then
            return alarm("/sounds/alarm.ogg", "Special Creature Detected!",{tags = {"biohazard", "warning"},priority = 5 ,message = "Your character " .. player:getName() .. " detected special creature: " .. name}, config.creatureName, "creatureName")
          end
        end
      end
    end
  end

  if config.noParty.enabled then
    if  not player:isPartyMember() then
      return alarm("/sounds/alarm.ogg", "No party!", {priority = 4, message = "Your character " .. player:getName() .. " is not in a party!"}, config.noParty, "noParty")
    end
  end

  if config.noPartySharedExperience.enabled then
    if not getPartyShared() then
      return alarm("/sounds/alarm.ogg", "No shared party experience!", {priority = 4, message = "Your character " .. player:getName() .. " has no shared party experience"}, config.noPartySharedExperience, "noPartySharedExperience")
    end
  end

  if config.lowStamina.enabled then
    if math.floor(player:getStamina() / 60) <= config.lowStamina.value then
      return alarm("/sounds/alarm.ogg", "Low Stamina!", {tags = {"person_in_manual_wheelchair"}, priority = 4, message = "Your character " .. player:getName() .. " has low stamina: " .. onStaminaSet(player:getStamina())}, config.lowStamina, "lowStamina")
    end
  end
end)
