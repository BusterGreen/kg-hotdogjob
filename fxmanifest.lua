fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Knuckls'
description 'Allows players to sell hotdogs to npcs for money'
version '1.2.2'

ui_page 'html/ui.html'

shared_scripts {
    '@kg-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    'client/main.lua'
}

server_script 'server/main.lua'

files {
    'html/ui.html',
    'html/ui.css',
    'html/ui.js',
    'html/icon.png',
}