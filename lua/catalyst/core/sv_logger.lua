Catalyst.Logger = {}

function Catalyst.Logger.Info(message)
    print("[Catalyst] "..tostring(message))
end

function Catalyst.Logger.Error(message)
    print("[Catalyst ERROR] "..tostring(message))
end

function Catalyst.Logger.Debug(message)
    if not Catalyst.Config.Debug then return end
    print("[Catalyst DEBUG] "..tostring(message))
end
