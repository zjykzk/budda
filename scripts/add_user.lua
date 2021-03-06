-- name, bod, [teacher]
local kname, kbod, kteacher = unpack(KEYS)
local name, bod, teacher = unpack(ARGV)
local userKey = 'user:' .. name
if redis.pcall('EXISTS', userKey) == 1 then
    return -1 -- name exists
end

if teacher and #teacher > 0 and 0 == redis.call('EXISTS', 'user:' .. teacher) then
    return -2 -- no teacher
end

if teacher then
    redis.pcall('HMSET', userKey, kname, name, kbod, bod, kteacher, teacher)
else
    redis.pcall('HMSET', userKey, kname, name, kbod, bod)
end

if teacher and #teacher > 0 then
    redis.pcall('SADD', 'user:stu:' .. teacher, name)
end

return 0
