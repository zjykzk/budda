-- name, bod, [teacher]
local kname, kbod, kteacher = unpack(KEYS)
local name, bod, teacher = unpack(ARGV)
local userKey = 'user:' .. name
if redis.pcall('EXISTS', userKey) == 0 then
    return -1 -- name not exists
end

if teacher and #teacher > 0 and 0 == redis.call('EXISTS', 'user:' .. teacher) then
    return -2 -- no teacher
end

local oldTeacher = redis.call('HGET', userKey, kteacher)

if teacher then
    redis.pcall('HMSET', userKey, kname, name, kbod, bod, kteacher, teacher)
else
    redis.pcall('HMSET', userKey, kname, name, kbod, bod)
end

if oldTeacher == name or oldTeacher == teacher then
    return 0
end

if oldTeacher and #oldTeacher then
    redis.pcall('SREM', 'user:stu:' .. oldTeacher, name)
end

if teacher and #teacher > 0 then
    redis.pcall('SADD', 'user:stu:' .. teacher, name)
end

return 0
