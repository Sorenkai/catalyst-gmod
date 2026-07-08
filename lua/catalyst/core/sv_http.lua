Catalyst.Http = {}

local function buildUrl(path)
    return Catalyst.Config.BaseUrl .. path
end

function Catalyst.Http.Request(method, path, body, onSuccess, onFailure)
    local jsonBody = nil

    if body ~= nil then
        jsonBody = util.TableToJSON(body, false)
    end

    Catalyst.Logger.Debug("HTTP " .. method .. " " .. path)

    if jsonBody then
        Catalyst.Logger.Debug("Body: " .. jsonBody)
    end
    HTTP({
        url = buildUrl(path),
        method = method,
        headers = {
            ["Authorization"] = "Bearer "..Catalyst.Config.Token,
            ["Content-Type"] = "application/json",
            ["Accept"] = "application/json",
        },
        body = jsonBody,
        type = "application/json",
        timeout = Catalyst.Config.RequestTimeout or 15,

        success = function(code, body, headers)
            if code < 200 or code >= 300 then
                if onFailure then
                    onFailure("HTTP "..tostring(code)..": "..tostring(body))
                end
                return
            end

            local data = util.JSONToTable(body or "")
            if not data then
                if onFailure then
                    onFailure("Invalid JSON response")
                end
                return
            end
            if onSuccess then
                onSuccess(data)
            end
        end,

        failed = function(err)
            if onFailure then
                onFailure(err)
            end
        end,
    })
end

function Catalyst.Http.Get(path, onSuccess, onFailure)
    Catalyst.Http.Request("GET", path, nil, onSuccess, onFailure)
end

function Catalyst.Http.Post(path, body, onSuccess, onFailure)
    Catalyst.Http.Request("POST", path, body, onSuccess, onFailure)
end