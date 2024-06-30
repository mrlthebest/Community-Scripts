---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

script_bot = {};
script_path = '/scripts_storage/';
script_path_json = script_path .. player:getName() .. '.json';
script_manager = {
    _cache = {
        Dbo = {

        },
        Nto = {

        },
        Tibia = {

        },
        PvP = {
            ['Attack Follow'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/Follow_Attack.lua',
                description = 'Script de follow attack.',
                author = 'VictorNeox',
                enabled = false
            },
            ['Attack Target'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/ATTACK-TARGET.lua',
                description = 'Script de hold target.',
                author = 'Ryan',
                enabled = false
            },
            ['Change Weapons'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/change_weapon.lua',
                description = 'Script de alterar arma por distancia do target.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Chase Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/chase_icon.lua',
                description = 'Esse script ira criar um icone para desativar/ativar o chase.',
                author = 'mrlthebest',
                enabled = false
            },
        },
        Healing = {
            ['Heal Friend(Say)'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/healFriend.lua',
                description = 'Script de heal friend editavel por text edit.',
                author = 'mrlthebest',
                enabled = false
            },
        },
        Utilities = {
            ['Buff'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/buff.lua',
                description = 'Script de buff por mensagem laranja.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Bug Map'] = {
                url = 'https://raw.githubusercontent.com/ryanzin/OTCV8/main/BUG-MAP.lua',
                description = 'Script de bug map pc.',
                author = 'Ryan',
                enabled = false
            },
            ['Bug Map Mobile'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/Bug_Map_Mobile.lua',
                description = 'Script de bug map mobile.',
                author = 'VictorNeox',
                enabled = false
            },
            ['CaveBot/Targetbot Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/toggle.lua',
                description = 'Esse script ira criar um icone para deixar on/off o cavebot.',
                author = 'F. Almeida',
                enabled = false
            },
            ['Creature Health Percent'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/creature_health.lua',
                description = 'Script que ira mostrar a vida de qualquer creature na tela.',
                author = 'mrlthebest',
                enabled = false,
            },
            ['Loot Channel'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/loot_channel.lua',
                description = 'Cria um chat que ira mostrar os loots.',
                author = 'Dimitrys',
                enabled = false
            },
            ['Open Main BP'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/open%20main%20bp.lua',
                description = 'Script de abrir as BPs principais.',
                author = 'VivoDibra',
                enabled = false
            },
            ['Follow Player'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/follow%20player.lua',
                description = 'Script de follow player.',
                author = 'VictorNeox',
                enabled = false
            },
            ['PvP Mode Icon'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/pvp_mode_icon.lua',
                description = 'Esse script ira criar um icone para desativar/ativar a maozinha.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Spy Level'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/storage_cavebot.lua',
                description = 'Script de ver andar superior/inferior.',
                author = 'vbot',
                enabled = false
            },
            ['Storage CaveBot/TargetBot'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/storage_cavebot.lua',
                description = 'Script util para ter uma custom onde os cavebots nao se misturam pelos makers.',
                author = 'mrlthebest',
                enabled = false
            },
            ['Widget Skills'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/OTCV8/main/WidgetTrain.lua',
                description = 'Script de widget onde mostra todas skills.',
                author = 'mrlthebest',
                enabled = false
            },
        },
    },
};

_G = modules._G;
context = _G.getfenv();
g_resources = _G.g_resources;
listDirectoryFiles = g_resources.listDirectoryFiles;
readFileContents = g_resources.readFileContents;
fileExists = g_resources.fileExists;
