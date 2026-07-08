Catalyst.Commands.Register("garrysmod.ulx.group.set", function(payload, command)
    local steamId = payload.steam_id
    local group = payload.group

    if not steamId then
        error("Missing steam_id")
    end

    if not group then
        error("Missing group")
    end

    if not Catalyst.ULX or not Catalyst.ULX.IsAvailable() then
        error("ULX integration is not found")
    end

    Catalyst.ULX.SetGroup(steamId, group)
    Catalyst.Logger.Info("Set ULX Group for "..tostring(steamId).." to ".. tostring(group))
    return true
end)