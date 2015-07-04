local name = unpack(ARGV)
if not name or #name == 0 then
    return -1 -- empty name
end

local projectKey = 'project:' .. name

if redis.pcall('EXISTS', projectKey) == 0 then
    return -2 -- project not exists
end

return redis.pcall('DEL', projectKey)
