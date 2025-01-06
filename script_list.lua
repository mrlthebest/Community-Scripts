
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
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Nto/bug_map_kunai.lua',
                description = 'Script de bug map kunai para pc.',
                author = 'Ryan',
                enabled = false
            },
            ['Bug Map Kunai Mobile'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Nto/bug_map_mobile_kunai.lua',
                description = 'Script de bug map kunai para mobile.',
                author = 'VictorNeox',
                enabled = false
            },
            ['Stack'] = {
                url = 'https://raw.githubusercontent.com/mrlthebest/Community-Scripts/main/Scripts/Nto/stack.lua',
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
