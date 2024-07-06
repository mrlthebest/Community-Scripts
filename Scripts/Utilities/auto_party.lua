local macroName = 'Utura';
local macroDelay = 100;
local tabName = 'Main';
setDefaultTab(tabName);


--[[
  Script made by Lee (Discord: l33_) - www.trainorcreations.com
  If you want to support my work, feel free to donate at https://trainorcreations.com/donate
  PS. Stop ripping off my work and selling it as your own.
]]--
local panelName = "autoParty"
local autopartyui = setupUI([[
Panel
  height: 38

  BotSwitch
    id: status
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    height: 18
    text: Auto Party

  Button
    id: editPlayerList
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Setup

  Button
    id: ptLeave
    text: Leave Party
    anchors.left: parent.left
    anchors.top: prev.bottom
    width: 86
    height: 17
    margin-top: 3
    color: #ee0000

  Button
    id: ptShare
    text: Share XP
    anchors.left: prev.right
    anchors.top: prev.top
    margin-left: 5
    height: 17
    width: 86

  ]], parent)

g_ui.loadUIFromString([[
AutoPartyName < Label
  background-color: alpha
  text-offset: 2 0
  focusable: true
  height: 16

  $focus:
    background-color: #00000055

  Button
    id: remove
    text: x
    anchors.right: parent.right
    margin-right: 15
    width: 15
    height: 15

AutoPartyListWindow < MainWindow
  text: Auto Party
  size: 180 275
  @onEscape: self:hide()

  Label
    id: lblLeader
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.right: parent.right
    text-align: center
    text: Leader Name

  TextEdit
    id: txtLeader
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
    margin-top: 5

  Label
    id: lblParty
    anchors.left: parent.left
    anchors.top: prev.bottom
    anchors.right: parent.right
    margin-top: 5
    text-align: center
    text: Party List

  TextList
    id: lstAutoParty
    anchors.top: prev.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 5
    margin-bottom: 5
    padding: 1
    height: 83
    vertical-scrollbar: AutoPartyListListScrollBar

  VerticalScrollBar
    id: AutoPartyListListScrollBar
    anchors.top: lstAutoParty.top
    anchors.bottom: lstAutoParty.bottom
    anchors.right: lstAutoParty.right
    step: 14
    pixels-scroll: true

  TextEdit
    id: playerName
    anchors.left: parent.left
    anchors.top: lstAutoParty.bottom
    margin-top: 5
    width: 120

  Button
    id: addPlayer
    text: +
    anchors.right: parent.right
    anchors.left: prev.right
    anchors.top: prev.top
    margin-left: 3

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.top: prev.bottom
    margin-top: 8

  CheckBox
    id: creatureMove
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
    margin-top: 6
    text: Invite on move
    tooltip: This will activate the invite on player move.

  HorizontalSeparator
    id: separator
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: closeButton.top
    margin-bottom: 8

  Button
    id: closeButton
    text: Close
    font: cipsoftFont
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    size: 45 21
]])

if not storage[panelName] then
    storage[panelName] = {
        leaderName = 'Leader',
        autoPartyList = {},
        enabled = true,
    }
end

if not storage[panelName].onMove then
    storage[panelName].onMove = false
end
rootWidget = g_ui.getRootWidget()
if rootWidget then
    tcAutoParty = autopartyui.status

    autoPartyListWindow = UI.createWindow('AutoPartyListWindow', rootWidget)
    autoPartyListWindow:hide()

    autopartyui.editPlayerList.onClick = function(widget)
        autoPartyListWindow:show()
        autoPartyListWindow:raise()
        autoPartyListWindow:focus()
    end

    autopartyui.ptShare.onClick = function(widget)
        g_game.partyShareExperience(not player:isPartySharedExperienceActive())
    end

    autopartyui.ptLeave.onClick = function(widget)
        g_game.partyLeave()
    end

    autoPartyListWindow.closeButton.onClick = function(widget)
        autoPartyListWindow:hide()
    end

    if storage[panelName].autoPartyList and #storage[panelName].autoPartyList > 0 then
        for _, pName in ipairs(storage[panelName].autoPartyList) do
            local label = g_ui.createWidget("AutoPartyName", autoPartyListWindow.lstAutoParty)
            label.remove.onClick = function(widget)
                table.removevalue(storage[panelName].autoPartyList, label:getText())
                label:destroy()
            end
            label:setText(pName)
        end
    end
    autoPartyListWindow.addPlayer.onClick = function(widget)
        local playerName = autoPartyListWindow.playerName:getText()
        if playerName:len() > 0 and not (table.contains(storage[panelName].autoPartyList, playerName, true)
                or storage[panelName].leaderName == playerName) then
            table.insert(storage[panelName].autoPartyList, playerName)
            local label = g_ui.createWidget("AutoPartyName", autoPartyListWindow.lstAutoParty)
            label.remove.onClick = function(widget)
                table.removevalue(storage[panelName].autoPartyList, label:getText())
                label:destroy()
            end
            label:setText(playerName)
            autoPartyListWindow.playerName:setText('')
        end
    end

    autopartyui.status:setOn(storage[panelName].enabled)
    autopartyui.status.onClick = function(widget)
        storage[panelName].enabled = not storage[panelName].enabled
        widget:setOn(storage[panelName].enabled)
    end

    autoPartyListWindow.creatureMove:setChecked(storage[panelName].onMove)
    autoPartyListWindow.creatureMove.onClick = function(widget)
        storage[panelName].onMove = not storage[panelName].onMove
        widget:setChecked(storage[panelName].onMove)
    end

    autoPartyListWindow.playerName.onKeyPress = function(self, keyCode, keyboardModifiers)
        if not (keyCode == 5) then
            return false
        end
        autoPartyListWindow.addPlayer.onClick()
        return true
    end

    autoPartyListWindow.playerName.onTextChange = function(widget, text)
        if table.contains(storage[panelName].autoPartyList, text, true) then
            autoPartyListWindow.addPlayer:setColor("#FF0000")
        else
            autoPartyListWindow.addPlayer:setColor("#FFFFFF")
        end
    end

    autoPartyListWindow.txtLeader.onTextChange = function(widget, text)
        storage[panelName].leaderName = text
    end
    autoPartyListWindow.txtLeader:setText(storage[panelName].leaderName)

    onTextMessage(function(mode, text)
        if tcAutoParty:isOn() then
            if mode == 20 then
                if text:find("has joined the party") then
                    local data = regexMatch(text, "([a-z A-Z-]*) has joined the party")[1][2]
                    if data then
                        if table.contains(storage[panelName].autoPartyList, data, true) then
                            if not player:isPartySharedExperienceActive() then
                                g_game.partyShareExperience(true)
                            end
                        end
                    end
                elseif text:find("has invited you") then
                    if player:getName():lower() == storage[panelName].leaderName:lower() then
                        return
                    end
                    local data = regexMatch(text, "([a-z A-Z-]*) has invited you")[1][2]
                    if data then
                        if storage[panelName].leaderName:lower() == data:lower() then
                            local leader = getCreatureByName(data, true)
                            if leader then
                                g_game.partyJoin(leader:getId())
                                return
                            end
                        end
                    end
                end
            end
        end
    end)

    function creatureInvites(creature)
        if not creature:isPlayer() or creature == player then return end
        if creature:getName():lower() == storage[panelName].leaderName:lower() then
            if creature:getShield() == 1 then
                g_game.partyJoin(creature:getId())
                return
            end
        end
        if player:getName():lower() ~= storage[panelName].leaderName:lower() then return end
        if not table.contains(storage[panelName].autoPartyList, creature:getName(), true) then return end
        if creature:isPartyMember() or creature:getShield() == 2 then return end
        g_game.partyInvite(creature:getId())
    end

    onCreatureAppear(function(creature)
        if tcAutoParty:isOn() then
            creatureInvites(creature)
        end
    end)
    onCreaturePositionChange(function(creature, newPos, oldPos)
        if tcAutoParty:isOn() and storage[panelName].onMove then
            creatureInvites(creature)
        end
    end)
end