
fx_version('cerulean')
lua54    'yes'
game 'gta5'

author 'SQC_Max'
description 'Shops'
version '0.1'


shared_script(
'@ox_lib/init.lua',    
'@es_extended/imports.lua',
'config.lua');

server_scripts({
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/sv.lua'
});

client_scripts({
    'config.lua',
    'client/cl.lua'
});