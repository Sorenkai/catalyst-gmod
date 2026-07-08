Catalyst = Catalyst or {}
Catalyst.Sql = Catalyst.Sql or {}


function Catalyst.Sql.Initialize()
    sql.Query([[
        CREATE TABLE IF NOT EXISTS catalyst_processed_commands (
        id INTEGER PRIMARY KEY,
        processed_at INTEGER NOT NULL)
    ]])
end

function Catalyst.Sql.HasCommandBeenProcessed(id)
    id = tonumber(id)
    if not id then return false end

    return sql.QueryValue("SELECT 1 FROM catalyst_processed_commands WHERE id = "..id) ~= nil
end

function Catalyst.Sql.MarkCommandAsProcessed(id)
    id = tonumber(id)
    if not id then return false end
    sql.Query(
        "INSERT OR IGNORE INTO catalyst_processed_commands (id, processed_at) VALUES (" .. id .. ", " .. os.time() .. ")"
    )
end

Catalyst.Sql.Initialize()