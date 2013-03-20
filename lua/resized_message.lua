-------- Set font size for [message] tag ----------------

local H = wesnoth.require "lua/helper.lua"

local old_message = wesnoth.wml_actions.message

function wesnoth.wml_actions.message(cfg)
    local new_cfg = cfg.__literal

    -- Changing the message font size
    if new_cfg.message then
        new_cfg.message = "<span font='" .. message_size .. "'>" .. cfg.message .. "</span>"
    end

    -- Also the message keys of the [option] tags
    for i,tag in ipairs(new_cfg) do
        if (tag[1] == "option") then
            local msg = tostring(tag[2].message)
            local first = string.sub(msg, 1, 1)
            if (first == '&') then
                -- This is a message in DescriptionWML format, we leave it unchanged for now
            else
                tag[2].message = "<span font='" .. message_size .. "'>" .. tag[2].message .. "</span>"
            end
        end
    end

    -- All the rest is just for getting the caption text right, if it is not set
    local caption = cfg.caption
    if (not caption) then

        -- if speaker is set, use it to get the caption
        if cfg.speaker then
            if (cfg.speaker == "narrator") then
                -- Nothing needs to be done in this case,
                -- but we need this option in case to distinguish if from an id
            elseif cfg.speaker == "unit" then
                -- get unit name
                local ec = wesnoth.current.event_context
                if (ec.x1 and ec.y1) then
                    local unit = wesnoth.get_unit(ec.x1,ec.y1)
                    if unit then caption = unit.__cfg.name end
                end
            elseif cfg.speaker == "second_unit" then
                -- get second_unit name
                local ec = wesnoth.current.event_context
                if (ec.x2 and ec.y2) then
                    local second_unit = wesnoth.get_unit(ec.x2,ec.y2)
                    if second_unit then caption = second_unit.__cfg.name end
                end
            else
                -- In all other cases, assume it's a unit id and get it, if it exists
                local speaker = wesnoth.get_units { id = cfg.speaker }
                if speaker[1] then caption = speaker[1].name end
            end
        end
    end

    -- Finally, use larger font for caption
    if caption then
        new_cfg.caption = "<span font='" .. caption_size .. "'>" .. caption .. "</span>"
    end

    old_message(new_cfg)
end
