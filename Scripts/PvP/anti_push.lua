if not storage["antipushAnen"] then
  storage["antipushAnen"] = {
    enabled = false,
    trash ={},
    proximity = {
      enabled = false,
      value = 2
    }
  }
end
local config = storage["antipushAnen"]
local s = {}

g_ui.loadUIFromString([[
antiPushAnenWindow < MainWindow
  size: 400 400
  $mobile:
    size: 320 150
  !text: tr('Anti Push Anen')
  @onEnter: self:hide()
  @onEscape: self:hide()
  padding: 25 8 8 8

  Button
    id: btnClose
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    text: Close
    width: 50
    @onClick: self:getParent():hide()
    
  BotContainer
    id: container
    anchors.fill: parent
    anchors.bottom: parent.verticalCenter
    anchors.right: parent.horizontalCenter
    
  CheckBox
    id: proximity
    text: Proximity
    anchors.top: parent.top
    anchors.left: parent.horizontalCenter
    width: 95
    margin-left: 10

  SpinBox
    id: value
    anchors.top: prev.bottom
    anchors.left: parent.horizontalCenter
    margin-left: 10
    margin-top: 5
    maximum: 8
    minimum: 1
    
  Button
    id: generateIcon
    text: Generate Icon
    anchors.top: prev.bottom
    anchors.left: prev.left
    margin-top: 8
]])

local parent = UI.createWindow("antiPushAnenWindow", g_ui.getRootWidget())
parent:hide()

UI.Container(function(widget)
    config.trash = parent.container:getItems()
end, true, nil, parent.container) 
parent.container:setItems(config.trash)

parent.proximity:setChecked(config.proximity.enabled)
parent.proximity.onCheckChange = function(w, isOn)
  config.proximity.enabled = isOn
end

parent.value:setValue(config.proximity.value)
parent.value.onValueChange = function(wi, value)
  config.proximity.value = value
end



parent.generateIcon.onClick = function()
  CHECKER_ICON({ type = "bot", name =  "Anti Push", switch = true, nameIcon = "Anti Push"})
end


UI.SwitchAndButton({on = config.enabled, left = "Anti Push", right =
"setup"}, function()
  config.enabled = not config.enabled
  s.macro.setOn(config.enabled)
end, function()
  parent:show()
  parent:focus()
end)

function distanceFromPlayer(coords)
    if not coords then return false end
    return getDistanceBetween(pos(), coords)
end

function getPlayers(range, multifloor)
    if not range then range = 10 end
    local specs = 0;
    for _, spec in pairs(getSpectators(multifloor)) do
        if not spec:isLocalPlayer() and spec:isPlayer() and distanceFromPlayer(spec:getPosition()) <= range and not ((spec:getShield() ~= 1 and spec:isPartyMember()) or spec:getEmblem() == 1) then
            specs = specs + 1
        end
    end
    return specs;
end

s.macro = macro(100, "AntiPushAnen", function ()
  if config.proximity.enabled and getPlayers(config.proximity.value, false) <= 0 then return end
  
  local tile = g_map.getTile(pos())
  if #tile:getItems() <= 1 or (#tile:getItems() > 1 and not tile:getItems()[2]:isPickupable()) then
      for _, item in ipairs(config.trash) do
          schedule(_ * 30, function ()
              g_game.move(findItem(item.id), pos(), math.random(1,2))
          end)
      end
  end
end)
s.macro.switch:setVisible(false)
s.macro.setOn(config.enabled)
