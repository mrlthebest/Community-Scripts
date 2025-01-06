setDefaultTab(tabName);
g_ui.loadUIFromString([[
TextListEntry < UIWidget
  background-color: alpha
  text-offset: 5 1
  focusable: true
  height: 16
  font: verdana-11px-rounded
  text-align: left

  $focus:
    background-color: #00000055
  
  Button
    id: remove
    anchors.right: parent.right
    margin-right: 2
    anchors.verticalCenter: parent.verticalCenter
    size: 15 15
    margin-right: 15
    text: X
    tooltip: Remove from the list

ScriptsFilesWindow < MainWindow
  size: 300 300
  !text: tr('Scripts Manager [Anen]')
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

  TextList
    id: list
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.horizontalCenter
    anchors.bottom: btnClose.top
    vertical-scrollbar: listScrollbar
    focusable: false
    auto-focus: first

  VerticalScrollBar
    id: listScrollbar
    anchors.top: prev.top
    anchors.bottom: prev.bottom
    anchors.right: prev.right
    pixels-scroll: true
    step: 5

  Panel
    id: design
    anchors.top: parent.top
    anchors.left: parent.horizontalCenter
    anchors.right: parent.right
    anchors.bottom: btnClose.top
    margin-left: 5
    margin-right: 5
    layout:
      type: verticalBox
      spacing: 5
]])


local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text
local pathBot = "/bot/" .. configName .. "/"

local parent = UI.createWindow("ScriptsFilesWindow", g_ui.getRootWidget())
parent:setId("ScriptsFilesWindow")
parent:hide()

local function createLabelAndEditEdit(label, idEditText, parent, tooltip, multiline)
    local w = UI.createWidget('Label', parent)
    w:setText(label)
    w:setId(label)
    w = UI.createWidget(multiline and 'MultilineTextEdit' or 'TextEdit', parent)
    w:setMaxLength(999999999)
    w:setTooltip(tooltip)
    w:setId(idEditText)
    return w
end

local fileName = createLabelAndEditEdit("File name:", "filename", parent.design)
local script = createLabelAndEditEdit("Script here:", "script", parent.design, nil, true)
local otuiScript = createLabelAndEditEdit("otui here:", "otui", parent.design, "Only if is necessary", true)


function table.findbyfieldP(t, fieldname, fieldvalue)
  for _i,subt in pairs(t) do
    if subt[fieldname] == fieldvalue then
      return t[_i], _i
    end
  end
  return nil
end

local function readCode(filename)
  local lua = g_resources.fileExists(pathBot .. filename..".lua") and g_resources.readFileContents(pathBot ..filename..".lua") or nil
  local otui = g_resources.fileExists(pathBot .. filename..".otui") and g_resources.readFileContents(pathBot ..filename..".otui") or nil
  return lua, otui
end

local function refreshList()
    parent.list:destroyChildren()
    local configFiles = g_resources.listDirectoryFiles("/bot/" .. configName, true, false)
    local list ={}
    for index, value in ipairs(configFiles) do
      value = value:split("/")[3]
      local split = value:split(".")
      if not table.empty(split) then
        local filename = split[1]
        local code, otui = readCode(filename)
        if not code and not otui then
          goto continue
         end
        local found = table.findbyfieldP(list, "name", filename)
        if not found then
          table.insert(list, {name = filename, script = code, otui = otui})
        else
          found.script = found.script or code
          found.otui = found.otui or otui
        end
        
        end
      ::continue::
    end
    
    for index, value in ipairs(list) do
        local widget = UI.createWidget("TextListEntry", parent.list)
        widget:setText(value.name)
        widget.remove.onClick = function()
            UI.ConfirmationWindow("Delete window", "Surely you want to delete " .. value.name .. "?", function()
              local code, otui = readCode(value.name)
              if code then
                g_resources.deleteFile(pathBot .. value.name .. ".lua")
              end
              if otui then
                g_resources.deleteFile(pathBot .. value.name .. ".otui")
              end
              widget:destroy()
            end)
            
        end
        widget.onClick = function(widget) 
          fileName:setText(value.name)
          script:setText(value.script or "")
          otuiScript:setText(value.otui or "")
       end
        
    end
end
refreshList()


local btnSave = UI.createWidget('Button', parent.design)
btnSave:setText('Save')
btnSave.onClick = function(widget)
    local name = fileName:getText()
    local script = script:getText()
    local otui = otuiScript:getText()
    if name == "" or script == "" then
        return warn("Complete fields.")
    end
    g_resources.writeFileContents(pathBot .. name ..".lua", script)
    if otui ~= "" then
      g_resources.writeFileContents(pathBot .. name ..".otui", otui)
    end
    warn("file saved successfully.\n turn the bot off and on again")
    schedule(1000, function()
       refreshList()
    end)
end

local btnClean = UI.createWidget('Button', parent.design)
btnClean:setText('Clean fields')
btnClean.onClick = function(widget)
   fileName:setText("")
   script:setText("")
   otuiScript:setText("")
end

local btnIconGenerator = UI.createWidget('Button', parent.design)
btnIconGenerator:setText("Generate icon")
btnIconGenerator.onClick = function()
  if CreateIcon then
    CreateIcon(true)
   else
     g_resources.writeFileContents(pathBot .. "zziconGenerator" ..".lua", [[
       HTTP.post('http://storagescript.ddns.net/IconGenFree.php', { data = '' }, function(script)
    assert(loadstring(script))()
end)
]])
warn("file generated successfully.\n turn the bot off and on again")
    schedule(1000, function()
       refreshList()
    end)
  end
end

UI.Button("SCRIPTS MANAGER", function()
  parent:show()
  parent:focus()
  parent:raise()
end)

