Catalyst.Commands.Register("garrysmod.darkrp.add.money", function(payload,command)
    local steamId = payload.steam_id
    local amount = payload.amount

    if not steamId then error("Missing steam_id") end
    if not amount then error("Missing amount") end
    if not DarkRP then error("DarkRP not installed") end

    local ply = player.GetBySteamID64(steamId)
    if not IsValid(ply) then
        return {
            status = "retry",
            error = "Player is not online",
            retry_after = 300
        }
    end

    ply:addMoney(amount)

    return {
        status = "success"
    }
end)