local function log(...)
    if not VERBOSE then return end
    print(...)
end

if not MySQL then
    return log("MySQL not found, aborting")
end

local commandName = COMMAND_NAME or "change_license"

RegisterCommand(commandName, function(source, args)
    if not args or #args < 2 then return end

    local fromId = table.remove(args, 1)
    local toId = table.remove(args, 1)

    local targetTables = #args > 0 and args or nil

    if not fromId or fromId:len() == 0
    or not toId or toId:len() == 0
    then
        return log("Usage (* = optional): /" .. commandName .. " <fromId> <toId> <*tableName> ...")
    end

    local dbSchema

    if not targetTables then
        dbSchema = DB_SCHEMA
    else
        dbSchema = {}

        for _, tableName in ipairs(targetTables) do
            if DB_SCHEMA[tableName] then
                dbSchema[tableName] = DB_SCHEMA[tableName]
            end
        end
    end

    local count = 0

    for tableName,rowName in pairs(dbSchema) do
        local query = "UPDATE `" .. tableName .. "` SET `" .. rowName .. "` = '" .. toId .. "' WHERE `" .. rowName .. "` = '" .. fromId .. "'"

        MySQL.Async.execute(query)

        count = count + 1
    end

    log("Changed " .. count .. " row(s)")
end, true)