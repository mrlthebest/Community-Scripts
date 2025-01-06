addItem('mwallId', 'MW ID' , 3180, mainTab, '');

local offsetDirections = {
    [North] = { 0, -2 },
    [East] = { 2, 0 },
    [South] = { 0, 2 },
    [West] = { -2, 0 },
    [NorthEast] = { 2, -2 },
    [SouthEast] = { 2, 2 },
    [SouthWest] = { -2, 2 },
    [NorthWest] = { -2, -2 }
}

macro(1000, "Mwall Frente Target", function()
    local target = g_game.getAttackingCreature()
    if not target then
        return
    end

    local targetPos = target:getPosition()
    local targetDir = target:getDirection()

    targetPos.x = targetPos.x + offsetDirections[targetDir][1]
    targetPos.y = targetPos.y + offsetDirections[targetDir][2]
    
    local mwallTile = g_map.getTile(targetPos)
    useWith(storage.itemValues.mwallId, mwallTile:getTopUseThing())
end, mainTab)
