description = [[
Retrieves HTTP response information and displays the status
and selected headers in organised sections.
]]

author = "Mahek"

license = "Same as Nmap"

categories = {"safe", "discovery"}

local shortport = require "shortport"
local http = require "http"

portrule = shortport.http

action = function(host, port)
    local path = "/"
    local response = http.get(host, port, path)

    if not response then
        return "Unable to retrieve HTTP response."
    end

    local output = {}

    table.insert(output, "HTTP Response Profiler")
    table.insert(output, "Requested Path: " .. path)

    if response.status then
        table.insert(output, "HTTP Status: " .. tostring(response.status))
    else
        table.insert(output, "HTTP Status: Not Available")
    end

    local headers = {
        "server",
        "content-type",
        "content-length",
        "date",
        "last-modified",
        "cache-control",
        "location",
        "x-frame-options",
        "x-content-type-options",
        "content-security-policy"
    }

    table.insert(output, "")
    table.insert(output, "Selected Response Headers:")

    for _, name in ipairs(headers) do
        local value = response.header and response.header[name]

        if value then
            table.insert(output, name .. ": " .. tostring(value))
        else
            table.insert(output, name .. ": Not Returned")
        end
    end

    return table.concat(output, "\n")
end
