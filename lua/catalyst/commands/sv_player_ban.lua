Catalyst = Catalyst or {}
Catalyst.SuppressBanSync = Catalyst.SuppressBanSync or {}

Catalyst.Commands.Register("player.ban", function(payload, command)
    local steamId = payload.steam_id
    local reason = payload.reason
    local durationMinutes = payload.duration_minutes

    if not steamId then
        error("Missing steam_id")
    end
    Catalyst.SuppressBanSync[steamId] = true

    Catalyst.Custom.BanPlayer(steamId, reason, durationMinutes)

    timer.Simple(2, function()
        Catalyst.SuppressBanSync[steamId] = nil
    end)
    Catalyst.Logger.Info("Banned player "..tostring(steamId))
    return {
        status = "success"
    }
end)