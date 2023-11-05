--Grab mod table, register hooks
local mod = game.mod_runtime[ game.current_mod ]

game.iuse_functions["BATHING"] = function(...)
    return mod.bathing_iuse_function(...)
end