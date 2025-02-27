require "kemal"

error 404 do
    "404 not found"
end

error 403 do
    "403 unauthorized"
end

error 400 do
    "400 bad request"
end