function handle_get_hello(req)
    local name = req:query_param[[name]]
    if name then
        req:set_response("Hello, " .. name .. "!")
    else
        req:set_response("Hello, World, lua coming!")
    end
end
