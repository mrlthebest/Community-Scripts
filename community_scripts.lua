---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local urlDirectory = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/scripts_directory.lua';
modules.corelib.HTTP.get(urlDirectory, function(script) 
    assert(loadstring(script))() 
end);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if not fileExists(script_path) then
    g_resources.makeDir(script_path);
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

script_bot.readFileContents = function()
    local data = script_manager;
    if g_resources.fileExists(script_path_json) then
        local content = g_resources.readFileContents(script_path_json)
        local status, result = pcall(json.decode, content)
        if status then
            data = result;
        else
            print("Erro ao decodificar o arquivo JSON:", result)
        end
    else
        script_bot.saveScripts();
    end
    script_manager = data;
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

script_bot.saveScripts = function()
    local res = json.encode(script_manager, 4);
    local status, err = pcall(function() g_resources.writeFileContents(script_path_json, res) end);
    if not status then
        info("Error saving file:" .. err);
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
  
  Button
    id: closeButton
    !text: tr('Close')
    font: cipsoftFont
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    size: 45 21
    margin-top: 5
    margin-right: 5
      
]], g_ui.getRootWidget());
script_bot.widget:hide();
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UI.Separator()
script_bot.buttonWidget = UI.Button('Script Manager');
script_bot.buttonWidget:setColor('#d2cac5');

script_bot.buttonRemoveJson = UI.Button('Update Files');
script_bot.buttonRemoveJson:setColor('#d2cac5');
script_bot.buttonRemoveJson:setTooltip('So clique aqui quando houver uma att.')

script_bot.buttonWidget.onClick = function(widget)
    if script_bot.widget:isVisible() then
        reload();
    else
        script_bot.widget:show();
    end
end

script_bot.widget.closeButton.onClick = function(widget)
    reload();
    script_bot.widget:hide();
end


script_bot.buttonRemoveJson.onClick = function(widget)
    g_resources.deleteFile(script_path_json)
    reload();
end

UI.Separator()

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

script_bot.onLoading = function()
    script_bot.widget.scriptList:destroyChildren()

    local categories = {};
    for categoryName, categoryList in pairs(script_manager._cache) do
        table.insert(categories, categoryName)
        for key, value in pairs(categoryList) do
            if value.enabled then
                --loadRemoteScript(value.url)
                modules.corelib.HTTP.get(value.url, function(script) 
                    assert(loadstring(script))() 
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

                tab.onStyleApply = function(widget)
                    if script_bot.widget.macrosOptions:getCurrentTab() == widget then
                        widget:setColor('green');
                    else
                        widget:setColor('white') ;
                    end
                end
            end
        end
    end
    local function updateScriptList(tabName)
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
                    --loadRemoteScript(value.url)
                    end
                end

                if value.enabled then
                    label.textToSet:setColor('green');
                end
            end
        end
    end

    local currentTab = script_bot.widget.macrosOptions:getCurrentTab().text;
    updateScriptList(currentTab);
    script_bot.widget.macrosOptions.onTabChange = function(widget, tabName)
        updateScriptList(tabName:getText());
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

do
    script_bot.readFileContents();
    script_bot.onLoading();
end

