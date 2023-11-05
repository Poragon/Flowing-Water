local mod = game.mod_runtime[ game.current_mod ]

--Grid definition and handover for OMT Resources
local water_grid = {
    ["resource_id"] = "fw_water",
    ["resource_name"] = "water",
    ["starting_amount"] = 0,
    ["flags"] = {""},
    ["passive_mod"] = 0,
    ["base_capacity"] = 0,
    ["modifying_furniture"] = {
        ["f_water_pump_on"] = {
            ["active_mod"] = 1000,
            ["capacity_mod"] = 0
        },
        ["f_wind_mill"] = {
            ["active_mod"] = 100,
            ["capacity_mod"] = 0
        },
        ["f_water_heater"] = {
            ["active_mod"] = 0,
            ["capacity_mod"] = 240
        },
        ["f_standing_tank"] = {
            ["active_mod"] = 0,
            ["capacity_mod"] = 1200
        }
    }
}

table.insert(game.mod_runtime.omt_resources.resource_table_list, water_grid)

--Iuse hooks
---Iuse for the fake items attatched to furniture to enable bathing
---@param who creature
---@param item item
---@param pos ms
mod.bathing_iuse_function = function(who, item, pos)

    --Menu creation for choice
    local menu = UiList.new()
    menu:title("Select Action")
    menu:add(0,"Bathe")
    local choice = menu:query()
    --Choice functionality
    if choice == 0 then
        if game.mod_runtime.omt_resources.grid_functions.Modify_resource_amount_call("fw_water", pos, -367) then
            who:add_effect(EffectTypeId.new( "morale_shower_effect" ), TimeDuration.from_hours(24))
            gapi.add_msg("The warm shower rejuvenates you!")
        else
            gapi.add_msg("Not enough water")
        end
    end
    ---Breaks without, game looks for a return on iuse functions that's an int
    return 0
end