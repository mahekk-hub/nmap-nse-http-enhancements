description = [[
Compares HTTP headers returned by HEAD and GET requests
to the same resource and reports differences.
]]

author = "Mahek"

license = "Same as Nmap"

categories = {"safe", "discovery"}

local shortport = require "shortport"
local http = require "http"

portrule = shortport.http

action = function(host, port)
    local path = "/"

    local head_response = http.head(host, port, path)
    local get_response = http.get(host, port, path)

    if not head_response then
        return "Unable to retrieve HEAD response."
    end

    if not get_response then
        return "Unable to retrieve GET response."
    end

    local output = {}

    table.insert(output, "HTTP HEAD-GET Response Comparator")
    table.insert(output, "Requested Path: " .. path)

    table.insert(output, "HEAD Status: " ..
        tostring(head_response.status or "Not Available"))

    table.insert(output, "GET Status: " ..
        tostring(get_response.status or "Not Available"))

    local head_headers = head_response.header or {}
    local get_headers = get_response.header or {}
    local names = {}

    for name, _ in pairs(head_headers) do
        names[name] = true
    end

    for name, _ in pairs(get_headers) do
        names[name] = true
    end

    local sorted_names = {}

    for name, _ in pairs(names) do
        table.insert(sorted_names, name)
    end

    table.sort(sorted_names)

    table.insert(output, "")
    table.insert(output, "Header Comparison:")

    for _, name in ipairs(sorted_names) do
        local head_value = head_headers[name]
        local get_value = get_headers[name]

        if head_value and get_value then
            if tostring(head_value) == tostring(get_value) then
                table.insert(output, name .. ": Same value")
            else
                table.insert(output, name .. ": Different values")
                table.insert(output, "  HEAD: " .. tostring(head_value))
                table.insert(output, "  GET: " .. tostring(get_value))
            end
        elseif head_value then
            table.insert(output, name .. ": Present only in HEAD")
        else
            table.insert(output, name .. ": Present only in GET")
        end
    end

    return table.concat(output, "\n")
end
