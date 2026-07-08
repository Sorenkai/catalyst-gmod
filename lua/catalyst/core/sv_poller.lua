Catalyst.Poller = Catalyst.Poller or {}
Catalyst.Poller.IsRunning = false 

function Catalyst.Poller.Poll()
    if Catalyst.Poller.IsRunning then return end

    Catalyst.Poller.IsRunning = true 
    
    local path = "/commands?limit="..tostring(Catalyst.Config.CommandLimit or 25)


    Catalyst.Http.Get(path, function(response)
        Catalyst.Poller.IsRunning = false
        local commands = response.commands or {}

        if #commands <= 0 then
            Catalyst.Logger.Debug("No commands available")
            return
        end

        Catalyst.Logger.Info("Received "..tostring(#commands).." command(s)")
        
        local results = {}

        for _, command in ipairs(commands) do
            local result = Catalyst.Commands.Execute(command)
            table.insert(results, result)
        end

        PrintTable(results)
        Catalyst.AckQueue.Send(results)
    end, function(errMsg)
        Catalyst.Poller.IsRunning = false 
        Catalyst.Logger.Error("Poll failed: "..tostring(errMsg))
    end)
end

timer.Create("Catalyst.Poller", Catalyst.Config.PollInterval or 10, 0, function()
    Catalyst.Poller.Poll()
end)

hook.Add("Initialize", "Catalyst.InitialPoll", function()
    timer.Simple(5, function()
        Catalyst.Poller.Poll()
    end)
end)