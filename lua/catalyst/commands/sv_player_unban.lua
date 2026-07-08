Catalyst = Catalyst or {}
Catalyst.SuppressUnBanSync = Catalyst.SuppressUnBanSync or {}

Catalyst.Commands.Register("player.unban", function(payload, command)
    local steamId = payload.steam_id

    if not steamId then
        error("Missing steam_id")
    end
    Catalyst.SuppressUnBanSync[steamId] = true

    Catalyst.Custom.UnbanPlayer(steamId)
    timer.Simple(2, function()
        Catalyst.SuppressUnBanSync[steamId] = nil
    end)
    Catalyst.Logger.Info("Unbanned player "..tostring(steamId))
    return {
        status = "success"
    }
end)