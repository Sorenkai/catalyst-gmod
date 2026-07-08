hook.Add("ULibPlayerBanned", "Catalyst.UlibPlayerBanned", function(steamId, banData)
    local duration = 0
    if Catalyst.SuppressBanSync and Catalyst.SuppressBanSync[util.SteamIDTo64(steamId)] then
        Catalyst.Logger.Debug("Ignoring laravel-originated ban sync for "..tostring(util.SteamIDTo64(steamId)))
        return
    end

    Catalyst.Http.Post("/events", {
        type = "player.banned",
        payload = {
            steam_id = util.SteamIDTo64(steamId),
            reason = banData.reason,
            expires_at = banData.unban,
        }
    }, function(response)
        Catalyst.Logger.Debug("Ban event synced to web")
    end, function (errMsg)
        Catalyst.Logger.Error("Failed to sync ban event: "..tostring(errMsg))
    end)
    
    Catalyst.Logger.Info("ULX ban detected: "..tostring(steamId))
end)

hook.Add("ULibPlayerUnBanned", "Catalyst.UlibPlayerUnbanned", function(steamId, admin)
    if Catalyst.SuppressUnBanSync and Catalyst.SuppressUnBanSync[util.SteamIDTo64(steamId)] then
        Catalyst.Logger.Debug("Ignoring laravel-originated unban sync for "..tostring(util.SteamIDTo64(steamId)))
        return
    end

    Catalyst.Http.Post('/events', {
        type = "player.unbanned",
        payload = {
            steam_id = util.SteamIDTo64(steamId),
        },
    }, function(response)
        Catalyst.Logger.Debug("Unban event synced to web")
    end,function(errMsg)
        Catalyst.Logger.Error("Failed to sync unban event: "..tostring(errMsg))
    end)
end)