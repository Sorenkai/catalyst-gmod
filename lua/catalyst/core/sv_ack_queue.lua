Catalyst.AckQueue = Catalyst.AckQueue or {}

function Catalyst.AckQueue.Send(results)
    if not results or #results < 0 then return end

    Catalyst.Http.Post("/ack", {
        results = results
    }, function(response)
        Catalyst.Logger.Debug("Ack set successfully")
    end, function(errMsg)
        Catalyst.Logger.Error("Ack failed: "..tostring(errMsg))
        // Add persistency later for failed acks
    end)
end