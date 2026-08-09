Catalyst = Catalyst or {}

local function load(path)
    include(path)
    print("[Catalyst] Loaded "..path)
end

load("catalyst/sv_config.lua")
load("catalyst/core/sv_logger.lua")
load("catalyst/core/sv_sql.lua")
load("catalyst/core/sv_http.lua")
load("catalyst/core/sv_command_registry.lua")
load("catalyst/core/sv_ack_queue.lua")
load("catalyst/commands/sv_package_grant.lua")
load("catalyst/commands/sv_player_ban.lua")
load("catalyst/commands/sv_player_unban.lua")
load("catalyst/commands/sv_ulx.lua")
load("catalyst/integrations/sv_custom.lua")
load("catalyst/integrations/sv_ulx.lua")
load("catalyst/hooks/sv_ulx_bans.lua")
load("catalyst/hooks/sv_role_sync.lua")
load("catalyst/core/sv_poller.lua")
load("catalyst/core/sv_status.lua")