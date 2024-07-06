--[[
  Script made by Lee (Discord: l33_) - www.trainorcreations.com
  If you want to support my work, feel free to donate at https://trainorcreations.com/donate
  PS. Stop ripping off my work and selling it as your own.
]]--

local macroName = 'Sense';
local macroDelay = 100;
local tabName = setDefaultTab('Main');

UI.TextEdit(storage.exivaSpell or "sense", function(widget, text)
  storage.exivaSpell = text;
end, tabName);

local panelName = "tcLastExiva"
local tcLastExiva = setupUI([[
ExivaLabel < Label
  height: 12
  background-color: #00000055
  opacity: 0.89
  anchors.horizontalCenter: parent.horizontalCenter
  text-auto-resize: true
  font: verdana-11px-rounded

Panel
  id: msgPanel
  height: 26
  width: 100
  anchors.bottom: parent.bottom
  anchors.horizontalCenter: parent.horizontalCenter
  margin-bottom: 20

  ExivaLabel
    id: lblMessage
    color: green
    anchors.bottom: parent.bottom
    !text: 'None.'

  ExivaLabel
    id: lblExiva
    color: orange
    anchors.bottom: prev.top
    !text: 'Last Exiva: None'

]], modules.game_interface.getMapPanel())

local tclastExivaUI = setupUI([[
Panel
  margin: 3
  height: 66
  layout:
    type: verticalBox

  HorizontalSeparator
    id: separator

  Label
    id: title
    text: Last Exiva
    margin-top: 1
    text-align: center
    font: verdana-11px-rounded

  Panel
    id: time
    height: 22
    Label
      !text: 'Time in seconds:'
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.right: next.left
      text-align: center
      height: 15
      margin-right: 6
      font: verdana-11px-rounded

    BotTextEdit
      id: text
      text: 5
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      margin-left: 5
      height: 17
      width: 55
      font: verdana-11px-rounded

  ]], parent)

if not storage[panelName] then
  storage[panelName] = {
    name = '',
    timer = 5,
  }
end

tclastExivaUI.time.text:setText(storage[panelName].timer)
tclastExivaUI.time.text.onTextChange = function(widget, text)
  storage[panelName].timer = tonumber(text)
end

local lastExiva = ''
lastExiva = storage[panelName].name
tcLastExiva.lblExiva:setText('Last Exiva: ' .. lastExiva)

onTalk(function(name, level, mode, text, channelId, pos)
  if name ~= player:getName() then return end
  text = text:lower()
  -- uncomment the warn below to find the channel mode if this doesn't work
  -- cast exiva and you should see NUMBER :  exiva "name"
  -- warn(mode.. ':'..text)
  if (mode == 34 or mode == 44) and text:find(storage.exivaSpell:lower() .. ' ') then
    lastExiva = string.match(text, storage.exivaSpell .. [[ "([^"]+)]])

    if lastExiva then
      storage[panelName].name = lastExiva;
      tcLastExiva.lblExiva:setText('Last '.. storage.exivaSpell ..' : ' .. lastExiva)
    end
  end
end)

onTextMessage(function(mode, text)
  if mode ~= 20 then return end
  local regex = "([a-z A-Z]*) is ([a-z -A-Z]*)(?:to the|standing|below|above) ([a-z -A-Z]*)."
  local data = regexMatch(text, regex)[1]
  if data and data[2] and data[3] then
    schedule(10, function()
      tcLastExiva.lblMessage:setText(text)
    end)
  end
end)

macro(macroDelay, macroName, function()
  if lastExiva == '' then return end
  local findPlayer = getCreatureByName(lastExiva)
  if findPlayer then return end
  say(storage.exivaSpell .. ' "' .. lastExiva)
  delay(tonumber(storage[panelName].timer) * 1000)
end, tclastExivaUI)



