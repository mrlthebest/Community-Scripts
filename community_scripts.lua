-- Initialize script_bot and script paths
script_bot = {};
script_path = '/scripts_storage/';
script_path_json = script_path .. player:getName() .. '.json';

-- Actual Version
actualVersion = 0.3;

-- Initialize script_manager with script cache
script_manager = {
    actualVersion = 0.3,
    _cache = {

        Dbo = {

            ['Reflect'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Dbo/reflect.lua',
                description = 'Script de reflect.',
                author = 'mrlthebest',
                enabled = false
            },
        },

        Nto = {
            ['Bug Map Kunai'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Nbo/bug_map_kunai.lua',
                description = 'Script de bug map kunai para pc.',
                author = 'Ryan',
                enabled = false
            },
            ['Bug Map Kunai Mobile'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Nbo/bug_map_mobile_kunai.lua',
                description = 'Script de bug map kunai para mobile.',
                author = 'VictorNeox',
                enabled = false
            },
            ['Stack'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Nbo/stack.lua',
                description = 'Script de stack, vai soltar a spell no monstro mais distante da tela.',
                author = 'VictorNeox',
                enabled = false
            },

        },
        Tibia = {

            ['Auto Mount'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/auto_mount.lua',
                description = 'Script de montagem automatica.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Cast Food'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/cast_food.lua',
                description = 'Script de castar/usar a food.',
                author = 'VivoDibra',
                enabled = false
            },
            ['E Ring'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/e_ring.lua',
                description = 'Script de e-ring.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Exeta Res'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/exeta_res.lua',
                description = 'Script de exeta res.',
                author = 'VivoDibra',
                enabled = false
            },
            ['MW Timer'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/mwall_timer.lua',
                description = 'Script de timer de MW.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Safe UE/SD'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/safe_ue_sd.lua',
                description = 'Script de safe UE/SD.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Share Exp'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/share_exp.lua',
                description = 'Script de safe UE/SD.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Utana Vid'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/utana_vid.lua',
                description = 'Script de utana vid.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Utura'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Tibia/utura.lua',
                description = 'Script de utura.',
                author = 'VivoDibra',
                enabled = false
            },

        },

        PvP = {
            ['Attack Target'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/ATTACK-TARGET.lua',
                description = 'Script de manter o target mesmo se ele sair da tela.',
                author = 'Ryan',
                enabled = false
            },
            ['Change Weapon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/change_weapons.lua',
                description = 'Script trocar a arma baseado na distancia do target.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Follow Attack'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/follow_attack.lua',
                description = 'Script de follow attack, seguir o target.',
                author = 'VictorNeox',
                enabled = false
            },
            ['Enemy'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/enemy.lua',
                description = 'Script enemy, atacar o inimigo com menos hp na tela.',
                author = 'Ryan',
                enabled = false
            },
            ['Pvp Mode Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/pvp_mode_icon.lua',
                description = 'Script alterar o modo da maozinha(pvp).',
                author = 'mrlthebest',
                enabled = false
            },
            ['Chase Mode Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/chase_icon.lua',
                description = 'Script alterar o modo do chase.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Sense Target'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/sense_target.lua',
                description = 'Script de dar sense no target.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Anti Push'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/anti_push.lua',
                description = 'Script de anti push.',
                author = 'AnenScripts',
                enabled = false
            },
            ['MW Frente Target'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/PvP/mwall_target.lua',
                description = 'Script de soltar MW na frente do target.',
                author = 'Gengo',
                enabled = false
            },
        },

        Healing = {
            ['Heal Friend'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Healing/heal_friend.lua',
                description = 'Script curar os amigos/party.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Potion'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Healing/potion.lua',
                description = 'Script de potion HP/MP.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Regeneration'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Healing/regeneration.lua',
                description = 'Script de regeneration.',
                author = 'mrlthebest',
                enabled = false
            },
        },

        Utilities = {
            ['Bug Map'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/BUG-MAP.lua',
                description = 'Script de Bug Map PC.',
                author = 'Ryan',
                enabled = false
            },
            ['Sense'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/xNameSense.lua',
                description = 'Script de sense, escreva "xNICK" para dar sense no nick e x0 para limpar o sense.',
                author = 'Ryan',
                enabled = false
            },
            ['Auto Party'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/auto_party.lua',
                description = 'Script de auto party.',
                author = 'Lee',
                enabled = false
            },
            ['Buff'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/buff.lua',
                description = 'Script de buff pela mensagem laranja.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Bug Map Mobile'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/bug_map_mobile.lua',
                description = 'Script de bug map mobile.',
                author = 'VictorNeox',
                enabled = false
            },
            ['Cave/Target Bot Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/cavebot_targetbot_icon.lua',
                description = 'Script de icone de targetbot e cavebot.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Change Gold'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/change_gold.lua',
                description = 'Script de change gold.',
                author = 'vBot',
                enabled = false
            },
            ['Combo + Combo Interrupt'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/combo_interrumpt.lua',
                description = 'Script de Combo+Combo Interrupt.',
                author = 'VictorNeox.',
                enabled = false
            },
            ['Creature HealthPercent'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/creature_hppercent.lua',
                description = 'Script de mostrar a % de todos as creatures na tela.',
                author = 'mrlthebest.',
                enabled = false
            },
            ['Death Counter'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/death_counter.lua',
                description = 'Script de contagem de morte.',
                author = 'Lee',
                enabled = false
            },
            ['Follow Player'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/follow_player.lua',
                description = 'Script de follow player.',
                author = 'VictorNeox',
                enabled = false
            },
            ['Hide Effects'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/hide_effects.lua',
                description = 'Script de esconder os efeitos.',
                author = 'UzumarTayhero',
                enabled = false
            },
            ['Hide Texts'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/hide_texts.lua',
                description = 'Script de esconder os textos.',
                author = 'UzumarTayhero',
                enabled = false
            },
            ['Kill Count'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/kill_count.lua',
                description = 'Script que conta os monstros que voce matou.',
                author = 'Lee',
                enabled = false
            },
            ['Last Exiva'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/last_exiva.lua',
                description = 'Script de last sense/exiva.',
                author = 'Lee',
                enabled = false
            },
            ['Loot Channel'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/loot_channel.lua',
                description = 'Script de canal exclusivo para loots.',
                author = 'Dimitrys',
                enabled = false
            },
            ['MW Cursor'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/mw_cursor.lua',
                description = 'Script de soltar MW onde o cursor do mouse esta.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Shield Defense'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/mystic_defense.lua',
                description = 'Script de shield defense.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Open Main BP'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/open_main_bp.lua',
                description = 'Script de abrir a bp principal.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Trade Message'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/send_message_trade.lua',
                description = 'Script de mandar msg no trade.',
                author = 'vBot',
                enabled = false
            },
            ['Speed'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/speed.lua',
                description = 'Script de speed.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Spy Level'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/spy_level.lua',
                description = 'Script de mostrar o andar de cima(=)/baixo(-)',
                author = 'vBot',
                enabled = false
            },
            ['Storage Cave/Target Bot'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/storage_cavebot.lua',
                description = 'Script que ira separar o cavebot/targetbot atual de cada personagem.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Time Spell'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/time_spell.lua',
                description = 'Script de Time Spell.',
                author = 'VictorNeox',
                enabled = false
            },

            ['Turn Target'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/turn.lua',
                description = 'Script virar o personagem para onde o target se encontra.',
                author = 'Ryan',
                enabled = false
            },
            ['Use Nearby Door'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/use_nearby_door.lua',
                description = 'Script de usar a porta mais proxima(5 sqm).',
                author = 'Lee',
                enabled = false
            },
            ['Use Nearby Door'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/widget_train.lua',
                description = 'Script de mostrar as porcentagens de treino.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Stamina'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/stamina.lua',
                description = 'Script de usar stamina.',
                author = 'Asking',
                enabled = false
            },
            ['Script Manager'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/script_manager.lua',
                description = 'Script de script manager, podendo adicionar icones e arquivos otuis de uma maneira mais simples.',
                author = 'AnenScripts',
                enabled = false
            },
            ['Alarm'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/alarm.lua',
                description = 'Script de alarm.',
                author = 'AnenScripts',
                enabled = false
            },
            ['Dance'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Utilities/dance.lua',
                description = 'Script de dance.',
                author = 'mrlthebest',
                enabled = false
            },

        },

    },
};

-- Global functions and initializations
_G = modules._G;
context = _G.getfenv();
g_resources = _G.g_resources;
listDirectoryFiles = g_resources.listDirectoryFiles;
readFileContents = g_resources.readFileContents;
fileExists = g_resources.fileExists;

-- Create script directory if it doesn't exist
if not fileExists(script_path) then
    g_resources.makeDir(script_path);
end

-- Function to read JSON file contents of scripts
script_bot.readFileContents = function()
    local data = script_manager;
    if g_resources.fileExists(script_path_json) then
        local content = g_resources.readFileContents(script_path_json);
        local status, result = pcall(json.decode, content);
        if status then
            data = result;
        else
            print("Error decoding JSON file:", result);
        end
    else
        script_bot.saveScripts();
    end
    script_manager = data;
end

-- Function to save scripts to JSON file
script_bot.saveScripts = function()
    local res = json.encode(script_manager, 4);
    local status, err = pcall(function() g_resources.writeFileContents(script_path_json, res) end);
    if not status then
        info("Error saving file:" .. err);
    end
end

-- Define the UI for script list
local script_add = [[
UIWidget
  background-color: alpha
  focusable: true
  height: 30

  $focus:
    background-color: #00000055

  Label
    id: textToSet
    font: terminus-14px-bold
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
]];

-- Define the main script manager UI
script_bot.widget = setupUI([[
MainWindow
  !text: tr('Community Scripts')
  font: terminus-14px-bold
  color: #d2cac5
  size: 300 400

  TabBar
    id: macrosOptions
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    width: 180

  ScrollablePanel
    id: scriptList
    layout:
      type: verticalBox
    anchors.fill: parent
    margin-top: 25
    margin-left: 2
    margin-right: 15
    margin-bottom: 30
    vertical-scrollbar: scriptListScrollBar
      
  VerticalScrollBar
    id: scriptListScrollBar
    anchors.top: scriptList.top
    anchors.bottom: scriptList.bottom
    anchors.right: scriptList.right
    step: 14
    pixels-scroll: true
    margin-right: -10

  HorizontalSeparator
    id: sep
    anchors.top: enemyList.bottom
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: prev.right
    margin-left: 10
    margin-top: 6

  TextEdit
    id: searchBar
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    margin-right: 5
    width: 130

  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.left: searchBar.right
    anchors.bottom: parent.bottom
    size: 45 21
    margin-bottom: 1
    margin-right: 5
    margin-left: 5
]], g_ui.getRootWidget())
script_bot.widget:hide();
script_bot.widget:setText('Community Scripts - ' .. actualVersion)

UI.Separator();

local updateLabel = UI.Label('Community Scripts. \n New version available, click "Update Files". \nVersion: ' .. actualVersion);
updateLabel:setColor('yellow');
updateLabel:hide();

-- Define buttons and their functionalities
--[[ Widget Button ]]--
script_bot.buttonWidget = UI.Button('Script Manager');
script_bot.buttonWidget:setColor('#d2cac5');
--[[ Update Script Button ]]--
script_bot.buttonRemoveJson = UI.Button('Update Files');
script_bot.buttonRemoveJson:setColor('#d2cac5');
script_bot.buttonRemoveJson:setTooltip('Click here only when there is an update.');
script_bot.buttonRemoveJson.onClick = function(widget)
    g_resources.deleteFile(script_path_json);
    reload();
end

--[[ Close Widget Button ]] --
script_bot.widget.closeButton:setTooltip('Close and add macros.');
script_bot.widget.closeButton.onClick = function(widget)
    reload();
    script_bot.widget:hide();
end

--[[ Close Button On Widget ]] --
script_bot.buttonWidget.onClick = function(widget)
    if script_bot.widget:isVisible() then
        reload();
    else
        script_bot.widget:show();
    end
end

--[[ Search Bar Tooltip ]] --
script_bot.widget.searchBar:setTooltip('Search macros.');

UI.Separator();

-- Function to filter scripts based on search text
function script_bot.filterScripts(filterText)
    for _, child in pairs(script_bot.widget.scriptList:getChildren()) do
        local scriptName = child:getId();
        if scriptName:lower():find(filterText:lower()) then
            child:show();
        else
            child:hide();
        end
    end
end

function script_bot.updateScriptList(tabName)
    script_bot.widget.scriptList:destroyChildren();
    local macrosCategory = script_manager._cache[tabName];

    if macrosCategory then
        for key, value in pairs(macrosCategory) do
            local label = setupUI(script_add, script_bot.widget.scriptList);
            label.textToSet:setText(key);
            label.textToSet:setColor('#bdbdbd');
            label:setTooltip('Description: ' .. value.description .. '\nAuthor: ' .. value.author);

            label.onClick = function(widget)
                value.enabled = not value.enabled;
                script_bot.saveScripts();
                label.textToSet:setColor(value.enabled and 'green' or '#bdbdbd');
                if value.enabled then
                    -- loadRemoteScript(value.url);
                end
            end

            if value.enabled then
                label.textToSet:setColor('green');
            end

            label:setId(key);
        end
    end
end

-- Function to load scripts
script_bot.onLoading = function()
    script_bot.widget.scriptList:destroyChildren();

    local categories = {};
    for categoryName, categoryList in pairs(script_manager._cache) do
        table.insert(categories, categoryName);
        for key, value in pairs(categoryList) do
            if value.enabled then
                modules.corelib.HTTP.get(value.url, function(script)
                    assert(loadstring(script))();
                end);
            end
        end
    end

    local numSteps = 6;
    local numCategories = #categories;
    local numLoops = math.ceil(numCategories / numSteps);

    for i = 1, numLoops do
        for j = 1, numSteps do
            local index = (i - 1) * numSteps + j;
            if index <= numCategories then
                local categoryName = categories[index];
                local tab = script_bot.widget.macrosOptions:addTab(categoryName);
                tab:setId(categoryName);
                tab:setTooltip(categoryName .. ' Macros');

                tab.onStyleApply = function(widget)
                    if script_bot.widget.macrosOptions:getCurrentTab() == widget then
                        widget:setColor('green');
                    else
                        widget:setColor('white');
                    end
                end
            end
        end
    end

    local currentTab = script_bot.widget.macrosOptions:getCurrentTab().text;
    script_bot.updateScriptList(currentTab);

    script_bot.widget.macrosOptions.onTabChange = function(widget, tabName)
        script_bot.updateScriptList(tabName:getText());
        script_bot.filterScripts(script_bot.widget.searchBar:getText());
    end

    script_bot.widget.searchBar.onTextChange = function(widget, text)
        script_bot.filterScripts(text);
    end
end

-- Main looping
do
    script_bot.readFileContents();
    script_bot.onLoading();
end


if script_manager.actualVersion ~= actualVersion then
    updateLabel:show();
end

