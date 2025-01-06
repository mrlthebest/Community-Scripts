script_bot = {};

tabName = nil;
if ragnarokBot then
    script_path = ragnarokBot.path .. 'scripts_storage/';
    script_path_json = script_path .. player:getName() .. '.json';
    setDefaultTab('HP')
    tabName = setDefaultTab('HP')
else
    script_path = '/scripts_storage/';
    script_path_json = script_path .. player:getName() .. '.json';
    setDefaultTab('Main')
    tabName = setDefaultTab('Tools')
end


-- Initialize script_bot and script paths


-- Actual Version
actualVersion = 0.4;

local libraryList = {
    'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/refs/heads/main/library.lua',
    'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/refs/heads/main/script_list.lua'
}

-- Load libraries
for _, library in ipairs(libraryList) do
    HTTP.get(library, function(content, error)
        if content then
            loadstring(content)()
            if not error then
                if script_manager then
                    -- Global functions and initializations
                    local _G = modules._G;
                    local context = _G.getfenv();
                    local g_resources = _G.g_resources;
                    local listDirectoryFiles = g_resources.listDirectoryFiles;
                    local readFileContents = g_resources.readFileContents;
                    local fileExists = g_resources.fileExists;

                    -- Create script directory if it doesn't exist
                    if not fileExists(script_path) then
                        g_resources.makeDir(script_path);
                    end
                    -- Function to read JSON file contents of scripts
                    script_bot.readScripts = function()
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
                    -- Set up script_bot UI
                    if not script_bot.widget then
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

                        -- Initialize the UI widgets
                        script_bot.widget:hide();
                        script_bot.widget:setText('Community Scripts - ' .. actualVersion);


                        -- Update label
                        local updateLabel = UI.Label('Community Scripts. \n New version available, click "Update Files". \nVersion: ' .. actualVersion);
                        updateLabel:setColor('yellow');
                        updateLabel:hide();

                        -- Define buttons
                        script_bot.buttonWidget = UI.Button('Script Manager');
                        script_bot.buttonWidget:setColor('#d2cac5');

                        script_bot.buttonRemoveJson = UI.Button('Update Files');
                        script_bot.buttonRemoveJson:setColor('#d2cac5');
                        script_bot.buttonRemoveJson:setTooltip('Click here only when there is an update.');
                        script_bot.buttonRemoveJson:hide();

                        script_bot.restartStorage = function()
                            g_resources.deleteFile(script_path_json);
                            reload();
                        end

                        script_bot.buttonRemoveJson.onClick = function(widget)
                            script_bot.restartStorage();
                        end

                        -- Close Widget Button
                        script_bot.widget.closeButton:setTooltip('Close and add macros.');
                        script_bot.widget.closeButton.onClick = function(widget)
                            reload();
                            script_bot.widget:hide();
                        end

                        -- Show or hide the widget
                        script_bot.buttonWidget.onClick = function(widget)
                            if script_bot.widget:isVisible() then
                                reload();
                            else
                                script_bot.widget:show();
                                script_bot.widget.macrosOptions:selectPrevTab()
                            end
                        end

                        -- Search bar functionality
                        script_bot.widget.searchBar:setTooltip('Search macros.');
                        script_bot.widget.searchBar.onTextChange = function(widget, text)
                            script_bot.filterScripts(text);
                        end

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

                        -- Update script list based on tab selection
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

                        -- Loading the scripts
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
                        end

                        -- Main execution flow
                        do
                            script_bot.readScripts();
                            script_bot.onLoading();
                        end

                        -- Check for version update
                        if script_manager.actualVersion ~= actualVersion then
                            script_bot.buttonRemoveJson:show();
                            updateLabel:show();
                        end
                    end
                end
            end
        end
    end);
end
