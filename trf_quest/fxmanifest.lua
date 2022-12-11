fx_version 'adamant'
games{"gta5"}

server_scripts{
    '@vrp/lib/utils.lua',
    'config.lua',
    'server.lua'
}

client_scripts {
   '@vrp/client/Tunnel.lua',
   '@vrp/client/Proxy.lua',
   'config.lua',
   'client.lua'
}
