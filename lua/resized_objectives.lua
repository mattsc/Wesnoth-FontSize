-------- Set font size for [objectives] and [show_objectives] tags ----------------

local old_objectives = wesnoth.wml_actions.objectives
function wesnoth.wml_actions.objectives(cfg)
    local parsed_cfg = cfg.__parsed

    local sides = wesnoth.get_sides(parsed_cfg)

    old_objectives(cfg)

    local function set_objectives(sides)
        for i, team in ipairs(sides) do
            local objectives = team.objectives
            objectives = "<span font='" .. objectives_size .. "'>" .. objectives .. "</span>"
            team.objectives = objectives
        end
    end

    if #sides == #wesnoth.sides or #sides == 0 then
        set_objectives(wesnoth.sides)
    else
        set_objectives(sides)
    end
end

local old_show_objectives = wesnoth.wml_actions.show_objectives
function wesnoth.wml_actions.show_objectives(cfg)
    local parsed_cfg = cfg.__parsed

    local sides = wesnoth.get_sides(parsed_cfg)

    old_show_objectives(cfg)

    local function set_objectives(sides)
        for i, team in ipairs(sides) do
            local objectives = team.objectives
            objectives = "<span font='" .. objectives_size .. "'>" .. objectives .. "</span>"
            team.objectives = objectives
        end
    end

    if #sides == #wesnoth.sides or #sides == 0 then
        set_objectives(wesnoth.sides)
    else
        set_objectives(sides)
    end
end
