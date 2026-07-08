Catalyst.Commands = Catalyst.Commands or {}
Catalyst.Commands.Handlers = Catalyst.Commands.Handlers or {}

function Catalyst.Commands.Register(commandType, callback)
    Catalyst.Commands.Handlers[commandType] = callback

    Catalyst.Logger.Debug("Registered command handler: "..commandType)
end

function Catalyst.Commands.Execute(command)
    if not command then
        return {
            status = "failed",
            error = "Missing command"
        }
    end

    if not command.type then
        return {
            status = "failed",
            error = "Missing command type"
        }
    end

    if not command.id then
        return {
            status = "failed",
            error = "Missing command id"
        }
    end

    local commandId = tonumber(command.id)

    if Catalyst.Sql.HasCommandBeenProcessed(commandId) then

        Catalyst.Logger.Debug("Command "..tostring(commandId).." has already been processed, skipping")
        return true, "Command has already been processed"
    end

    local handler = Catalyst.Commands.Handlers[command.type]
    if not handler then
        return {
            id = command.id,
            status = "failed",
            error = "Unknown command type: "..tostring(command.type)
        }
    end


    local ok, result = pcall(function()
        return handler(command.payload or {}, command)
    end)

    if not ok then
        return {
            id = command.id,
            status = "failed",
            error = tostring(result)
        }
    end

    if istable(result) and result.status then
        result.id = command.id

        if result.status == "success" then
            Catalyst.Sql.MarkCommandAsProcessed(command.id)
        end

        return result
    end

    if result == false then
        return {
            id = command.id,
            status = "failed",
            error = "Command handler returned false"
        }
    end

    Catalyst.Sql.MarkCommandAsProcessed(commandId)

    return {
        id = command.id,
        status = "success"
    }
end

function Catalyst.Commands.ListRegistered()
    Catalyst.Logger.Info("Registered command handlers:")

    for commandType, _ in pairs(Catalyst.Commands.Handlers) do
        Catalyst.Logger.Info(" - " .. tostring(commandType))
    end
end
