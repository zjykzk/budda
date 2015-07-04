local kname, kshortDesc, kdesc = unpack(KEYS)
local name, shortDesc, desc = unpack(ARGV)
if not name or #name == 0 then
    return -1 -- empty name
end

local projectKey = 'project:' .. name

if redis.pcall('EXISTS', projectKey) == 1 then
    return -2 -- project exists
end

return redis.pcall('HMSET', projectKey, 
    kname, name, kshortDesc, shortDesc, kdesc, desc)
