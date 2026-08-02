Catalyst.Custom = Catalyst.Custom or {}

function Catalyst.Custom.GrantPackage(steamId, packageId, transactionId)
    // Grant groups/roles/weapons etc.

    Catalyst.Logger.Info(
        "TODO: Grant package "..
        tostring(packageId) ..
        " to " ..
        tostring(steamId) ..
        " for purchase " ..
        tostring(transactionId)
    )
end

function Catalyst.Custom.BanPlayer(steamId, reason, durationMinutes)
    // Ban user
    reason = reason or nil 
    durationMinutes = durationMinutes or 0
    RunConsoleCommand("ulx", "banid", util.SteamIDFrom64(steamId), durationMinutes, reason)
end

function Catalyst.Custom.UnbanPlayer(steamId)
    // Unban user
    RunConsoleCommand("ulx", "unban", util.SteamIDFrom64(steamId))
end