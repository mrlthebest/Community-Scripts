-- Initialize script_bot and script paths
script_bot = {};
script_path = '/scripts_storage/';
script_path_json = script_path .. player:getName() .. '.json';

-- Actual Version
actualVersion = 0.2;

-- Initialize script_manager with script cache
script_manager = {
    actualVersion = 0.2,
    _cache = {
        Dbo = {},
        Nto = {},
        Tibia = {},
        PvP = {
            ['Attack Follow'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/Follow_Attack.lua',
                description = 'Follow attack script.',
                author = 'VictorNeox',
                enabled = false
            },
            ['Attack Target'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/ATTACK-TARGET.lua',
                description = 'Hold target script.',
                author = 'Ryan',
                enabled = false
            },
            ['Change Weapons'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/change_weapon.lua',
                description = 'Script to change weapons based on target distance.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Chase Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/chase_icon.lua',
                description = 'This script will create an icon to enable/disable chase.',
                author = 'mrlthebest',
                enabled = false
            },
        },
        Healing = {
            ['Heal Friend(Say)'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/healFriend.lua',
                description = 'Script to heal a friend editable via text edit.',
                author = 'mrlthebest',
                enabled = false
            },
        },
        Utilities = {
            ['Buff'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/buff.lua',
                description = 'Script for buff via orange message.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Bug Map'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/BUG-MAP.lua',
                description = 'PC map bug script.',
                author = 'Ryan',
                enabled = false
            },
            ['Sense'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/xNameSense.lua',
                description = 'Sense script, type "xNICK" to sense the nick, x0 to clear the sense.',
                author = 'Ryan',
                enabled = false
            },
            ['Bug Map Mobile'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/Bug_Map_Mobile.lua',
                description = 'Mobile map bug script.',
                author = 'VictorNeox',
                enabled = false
            },
            ['CaveBot/Targetbot Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/toggle.lua',
                description = 'This script will create an icon to turn on/off the cavebot.',
                author = 'F. Almeida',
                enabled = false
            },
            ['Creature Health Percent'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/creature_health.lua',
                description = 'Script that will show the health of any creature on the screen.',
                author = 'mrlthebest',
                enabled = false,
            },
            ['Loot Channel'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/loot_channel.lua',
                description = 'Creates a chat to show loots.',
                author = 'Dimitrys',
                enabled = false
            },
            ['Open Main BP'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/open%20main%20bp.lua',
                description = 'Script to open the main BPs.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Follow Player'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/follow%20player.lua',
                description = 'Script to follow player.',
                author = 'VictorNeox',
                enabled = false
            },
            ['PvP Mode Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/pvp_mode_icon.lua',
                description = 'This script will create an icon to enable/disable PvP mode.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Spy Level'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/storage_cavebot.lua',
                description = 'Script to see upper/lower floors.',
                author = 'vbot',
                enabled = false
            },
            ['Storage CaveBot/TargetBot'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/storage_cavebot.lua',
                description = 'Useful script to have custom cavebots that do not mix with makers.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Widget Skills'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/WidgetTrain.lua',
                description = 'Widget script that shows all skills.',
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

-- Function to update script list based on the selected tab
function script_bot.updateScriptList(tabName)
    script_bot.widget.scriptList:destroyChildren();
    local macrosCategory = script_manager._cache[tabName];

    if macrosCategory then
        for key, value in pairs(macrosCategory) do
            local label = setupUI(script_add, script_bot.widget.scriptList);
            label.textToSet:setText(key);
            label.textToSet:setColor('#bdbdbd');
            label:setTooltip('Description: ' .. value.description .. ' \nAuthor: ' .. value.author);

            label.onClick = function(widget)
                value.enabled = not value.enabled;
                script_bot.saveScripts();
                label.textToSet:setColor(value.enabled and 'green' or '#bdbdbd');
                if value.enabled then
                --loadRemoteScript(value.url);
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
