Catalyst.ULX = Catalyst.ULX or {}

function Catalyst.ULX.IsAvailable()
    return ulx ~= nil and ULib ~= nil
end

function Catalyst.ULX.SetGroup(steamId, group)

    RunConsoleCommand("ulx", "adduserid", util.SteamIDFrom64(steamId), group)
    return true
end