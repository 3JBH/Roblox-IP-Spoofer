spoofedIP = "69.69.69.69"
spoofedHttpbin = [[{
  "args": {}, 
  "headers": {
    "Accept": "*/*", 
    "Accept-Encoding": "gzip, deflate", 
    "Cache-Control": "no-cache", 
    "Host": "httpbin.org", 
    "Playercount": "1", 
    "Requester": "Client", 
    "Roblox-Game-Id": "null", 
    "Roblox-Place-Id": "0",
    "User-Agent": "Roblox/WinInet", 
    "X-Amzn-Trace-Id": "Root=1-61827c5a-49a624474a3382ac2079cb1f"
  }, 
  "origin": "69.69.69.69", 
  "url": "https://httpbin.org/get"
}]]

local old
old = hookfunction(game.HttpGet, function(self, url)
        -- Checking if the protection is enabled
    if type(url) == "string" then
        -- Checks if the URL is in the IP_Trackers table
        if url:find("ipify") or url:find("ident") then
            warn(url,"tried to log your IP. It was protected.")
            return spoofedIP -- Spoofed IP
        end
    end
    return old(self, url)
end)

local old
old = hookfunction(game.HttpGet, function(self, url)
        -- Checking if the protection is enabled
    if type(url) == "string" then
        -- Checks if the URL is in the IP_Trackers table
        if url:find("httpbin") then
            warn(url,"tried to log your httpbin. It was protected.")
            return spoofedHttpbin -- Spoofed Http Bin
        end
    end
    return old(self, url)
end)

local oldSyn
oldSyn = hookfunction((syn and syn.request or request),function(a,b)
    if type(a) == "string" then
        for i,v in pairs(a) do
            if i == "Url" and v:find("ipify") or v:find("ident") then
                warn(v,"tried to log your IP. It was protected.")
                return {
                    StatusCode = 200,
                    Body = spoofedIP
                }
            end
        end
    end
    return oldSyn(a,b)
end)

local oldSyn
oldSyn = hookfunction((syn and syn.request or request),function(a,b)
    if type(a) == "string" then
        for i,v in pairs(a) do
            if i == "Url" and v:find("httpbin") then
                warn(v,"tried to log your httpbin. It was protected.")
                return {
                    StatusCode = 200,
                    Body = spoofedHttpbin
                }
            end
        end
    end
    return oldSyn(a,b)
end)