local function UpdateStatus()
    local playerCount = player.GetCount()
    local maxPlayer = game.MaxPlayers()
    local map = game.GetMap()
    local hostname = GetHostName()
    
    Catalyst.Http.Post("/status", {
        type = "server.status",
        payload = {
            player_count = playerCount,
            max_players = maxPlayer,
            map = map,
            hostname = hostname,
        }
    }, function (response)
        Catalyst.Logger.Debug("Updated server status to web")
    end, function (errMsg)
        Catalyst.Logger.Error("Failed to update server status: "..tostring(errMsg))
    end)
end

timer.Create("Catalyst.ServerStatus", 10, 0, UpdateStatus)