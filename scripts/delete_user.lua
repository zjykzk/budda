-- name
local name = unpack(ARGV)
if not name then
    return -2 -- empty name
end
local userKey = 'user:' .. name

if redis.pcall('EXISTS', userKey) == 0 then
    return -1 -- no user name
end

local name, teacher = unpack(redis.pcall('HMGET', userKey, 'name', 'teacher'))
redis.pcall('SREM', 'user:stu:' .. teacher, name)
redis.pcall('DEL', userKey)
redis.pcall('DEL', 'user:stu:' .. name)
