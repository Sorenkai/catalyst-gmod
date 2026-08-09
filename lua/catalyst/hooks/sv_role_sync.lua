local ignoredGroups = {
    ["user"] = true,
    ["operator"] = true,
    ["noaccess"] = true,
}

local function SyncRoles()
    if !Catalyst.ULX.IsAvailable() then return end
    local groups = {}
    for name in pairs(ULib.ucl.groups) do
        if not ignoredGroups[string.lower(name)] then 
            table.insert(groups, name)
        end
    end

    Catalyst.Http.Post("/events", {
        type = "role.server.sync",
        payload = groups
    }, function(response)
        Catalyst.Logger.Info("Syncing ULX groups to web")
    end, function(errMsg)
        Catalyst.Logger.Error("Failed to sync groups: "..tostring(errMsg))
    end)
end

hook.Add("InitPostEntity", "Catalyst.RoleSync", SyncRoles)
hook.Add("ULibGroupCreated", "Catalyst.GroupCreated", SyncRoles)
hook.Add("ULibGroupRemoved", "Catalyst.GroupRemoved", SyncRoles)