description = [[
Checks whether an HTTP server is running.
Retrieves the Server HTTP header.
Provides a basic security recommendation.
]]

author = "Mahek"

license = "Same as Nmap"

categories = {"safe","discovery"}

local shortport = require "shortport"
local http = require "http"

portrule = shortport.http

action = function(host, port)

        local response = http.get(host, port, "/")

        if not response then
                return "Unable to connect to HTTP service."
        end

        local output = {}
        table.insert(output, "HTTP Security Header Check")

        if response.header["server"] then
                table.insert(output,
                        "Server Header : " .. response.header["server"])
        else
                table.insert(output,
                        "Server Header : Not Found")
        end

        return table.concat(output, "\n")

end
