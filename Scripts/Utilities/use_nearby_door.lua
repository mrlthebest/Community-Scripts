local macroName = 'Use Doors';
local macroDelay = 1000;
setDefaultTab(tabName);


--[[
  Script made by Lee (Discord: l33_) - www.trainorcreations.com
  If you want to support my work, feel free to donate at https://trainorcreations.com/donate
  PS. Stop ripping off my work and selling it as your own.
]]--
if not storage.doorIds then
  storage.doorIds = { 5129, 5102, 5111, 5120, 11246 }
end

local moveTime = 2000     -- Wait time between Move, 2000 milliseconds = 2 seconds
local moveDist = 5        -- How far to Walk
local useTime = 2000     -- Wait time between Use, 2000 milliseconds = 2 seconds
local useDistance = 5     -- How far to Use

local function properTable(t)
  local r = {}
  for _, entry in pairs(t) do
      table.insert(r, entry.id)
  end
  return r
end

UI.Separator(tabName)
UI.Label("Door IDs", tabName)

local doorContainer = UI.Container(function(widget, items)
  storage.doorIds = items
  doorId = properTable(storage.doorIds)
end, tabName)

doorContainer:setHeight(35)
doorContainer:setItems(storage.doorIds)
doorId = properTable(storage.doorIds)

clickDoor = macro(macroDelay, macroName, function()
  for i, tile in ipairs(g_map.getTiles(posz())) do
      local item = tile:getTopUseThing()
      if item and table.find(doorId, item:getId()) then
          local tPos = tile:getPosition()
          local distance = getDistanceBetween(pos(), tPos)
          if (distance <= useDistance) then
              use(item)
              return delay(useTime)
          end

          if (distance <= moveDist and distance > useDistance) then
              if findPath(pos(), tPos, moveDist, { ignoreNonPathable = true, precision = 1 }) then
                  autoWalk(tPos, moveTime, { ignoreNonPathable = true, precision = 1 })
                  return delay(waitTime)
              end
          end
      end
  end
end, tabName)
UI.Separator(tabName)
