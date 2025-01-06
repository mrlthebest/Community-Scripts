local macroName = 'Enemy';
local macroDelay = 100;

UI.Button("Friends", function(newText)
  UI.MultilineEditorWindow(storage.FriendText or "", {title="Amigos", description="Coloque o nome dos amigos", width=250, height=200}, function(text)
      storage.FriendText = text
      reload()
  end, tabName)
end, tabName)

isAmigo = function(name)
  if type(name) ~= 'string' then
      name = name:getName()
  end
  local tabela = storage.FriendText:split('\n')
  tabela = #tabela > 0 and tabela or false
  if not tabela or #tabela == 0 then
    return false
end
      return table.find(tabela, name:trim(), true)
  end



local enemyMacro = macro(macroDelay, macroName, function(m)
  local possibleTarget = false;
  if not storage.FriendText or storage.FriendText == '' then
    warn('Adicione pelo menos um amigo na lista.')
    m:setOff();
    return
  end
  for _, creature in ipairs(getSpectators(posz())) do
      local specHP = creature:getHealthPercent()
      if creature:isPlayer() and specHP and specHP > 0 then
          if not isAmigo(creature) and creature:getEmblem() ~= 1 then
              if creature:canShoot(9) then
                  if not possibleTarget or possibleTargetHP > specHP or (possibleTargetHP == specHP and possibleTarget:getId() < creature:getId()) then
                      possibleTarget = creature
                      possibleTargetHP = possibleTarget:getHealthPercent()
                  end
              end
          end
      end
  end
  if possibleTarget and g_game.getAttackingCreature() ~= possibleTarget then
      g_game.attack(possibleTarget)
  end
end, tabName)


posEnemy = addIcon("Enemy", {item = 12621, text = "Enemy"}, enemyMacro)
posEnemy:breakAnchors()
posEnemy:move(200, 450)
