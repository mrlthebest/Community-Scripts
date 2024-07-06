--[[
  Script made by Lee (Discord: l33_) - www.trainorcreations.com
  If you want to support my work, feel free to donate at https://trainorcreations.com/donate
  PS. Stop ripping off my work and selling it as your own.
]]--
local macroName = 'Monster Kill';
local macroDelay = 100;
local tabName = 'Main';
setDefaultTab(tabName);
local mkPanelname = "monsterKill"
if not storage[mkPanelname] then storage[mkPanelname] = { min = false } end

local monsterKill = setupUI([[
Panel
  margin-top:2
  height: 115
  Button
    id: resetList
    anchors.left: parent.left
    anchors.top: parent.top
    width: 20
    height: 17
    margin-top: 2
    margin-left: 3
    text: !
    color: red
    tooltip: Reset Data
  Button
    id: showList
    anchors.right: parent.right
    anchors.top: parent.top
    width: 20
    height: 17
    margin-top: 2
    margin-right: 3
    text: -
    color: red

  Label
    id: title
    text: Monster Kills
    text-align: center
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 20

  ScrollablePanel
    id: content
    image-source: /images/ui/menubox
    image-border: 4
    image-border-top: 17
    anchors.top: showList.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 5
    height: 88
    padding: 3
    vertical-scrollbar: mkScroll
    layout:
      type: verticalBox

  BotSmallScrollBar
    id: mkScroll
    anchors.top: content.top
    anchors.bottom: content.bottom
    anchors.right: content.right
    margin-top: 2
    margin-bottom: 5
    margin-right: 5
  ]], parent)
monsterKill:setId(mkPanelname)

killList = {}
local lbls = {}

local function toggleWin(load)
  if load then
    monsterKill:setHeight(20)
    monsterKill.showList:setText("+")
    monsterKill.showList:setColor("green")
  else
    monsterKill:setHeight(115)
    monsterKill.showList:setText("-")
    monsterKill.showList:setColor("red")
  end
end

function refreshMK()
  if #lbls > 0 and (#killList == #lbls) then
    local i = 1
    for k, v in pairs(killList) do
      lbls[i].name:setText(k .. ':')
      lbls[i].count:setText("x"..v)
      i = i + 1
    end
  else
    for _, child in pairs(monsterKill.content:getChildren()) do
      child:destroy()
    end
    for k, v in pairs(killList) do
      lbls[k] = g_ui.loadUIFromString([[
Panel
  height: 16
  margin-left: 2

  Label
    id: name
    text:
    anchors.top: parent.top
    anchors.left: parent.left
    margin-top: 2
    text-auto-resize: true
    font: verdana-11px-bold

  Label
    id: count
    text:
    anchors.top: name.top
    anchors.right: parent.right
    margin-right: 15
    text-auto-resize: true
    color: orange
    font: verdana-11px-bold

]], monsterKill.content)
      if lbls[k] then
        lbls[k].name:setText(k .. ':')
        lbls[k].count:setText("x"..v)
      end
    end
  end
end
refreshMK()
toggleWin(storage[mkPanelname].min)

monsterKill.showList.onClick = function(widget)
  storage[mkPanelname].min = (monsterKill:getHeight() == 115)
  toggleWin(storage[mkPanelname].min)
end

monsterKill.resetList.onClick = function(widget)
  killList = {}
  refreshMK()
end

function checkKill(mode, text)
  local mobName = nil
  local reg = { "Loot of a (.*):", "Loot of an (.*):", "Loot of the (.*):","Loot of (.*):"}
  for x = 1, #reg do
    _, _, mobName = string.find(text, reg[x])
    if mobName then
      if killList[mobName] then
        killList[mobName] = killList[mobName] + 1
      else
        killList[mobName] = 1
      end
      refreshMK()
      break
    end
  end
end

onTalk(function(name, level, mode, text, channelId, pos)
  if channelId == 11 then checkKill(mode, text) end
end)

onTextMessage(function(mode, text)
  checkKill(mode, text)
end)

--- examples NOT NEEDED
function getKills(mobName)
  -- example: warn(getKills("Troll"))
  if killList[mobName] then
    return killList[mobName]
  end
  return nil
end

function getDumpAllKills() -- test dump
  for k, v in pairs(killList) do
    warn(v .. "x " .. k)
  end
end