local interiors = {
    {
        ipl = 'gabz_mba_milo_', 
        coords = { x = -324.22030000, y = -1968.49300000, z = 20.60336000 },
        entitySets = {
            -- BASKETBALL - enable all of the entitySets below
            --{ name = 'mba_tribune', enable = true },
            --{ name = 'mba_tarps', enable = true },
            --{ name = 'mba_basketball', enable = true },
            --{ name = 'mba_jumbotron', enable = true },

            -- DERBY - enable all of the entitySets below
            --{ name = 'mba_cover', enable = true },
            --{ name = 'mba_terrain', enable = true },
            --{ name = 'mba_derby', enable = true },
            --{ name = 'mba_ring_of_fire', enable = true },

            -- PAINTBALL - enable all of the entitySets below
            -- { name = 'mba_tribune', enable = true },
            -- { name = 'mba_chairs', enable = true },
            -- { name = 'mba_paintball', enable = true },
            -- { name = 'mba_jumbotron', enable = true },

            -- CONCERT - enable all of the entitySets below
            --{ name = 'mba_tribune', enable = true },
            --{ name = 'mba_tarps', enable = true },
            --{ name = 'mba_backstage', enable = true },
            --{ name = 'mba_concert', enable = true },
            --{ name = 'mba_jumbotron', enable = true },
            
            -- FASHION - enable all of the entitySets below
            --{ name = 'mba_tribune', enable = true },
            --{ name = 'mba_tarps', enable = true },
            --{ name = 'mba_backstage', enable = true },
            --{ name = 'mba_fashion', enable = true },
            --{ name = 'mba_jumbotron', enable = true },

            -- FAME OR SHAME - enable all of the entitySets below
            --{ name = 'mba_tribune', enable = true },
            --{ name = 'mba_tarps', enable = true },
            --{ name = 'mba_backstage', enable = true },
            --{ name = 'mba_fameorshame', enable = true },
            --{ name = 'mba_jumbotron', enable = true },

            -- WRESTLING - enable all of the entitySets below
            --{ name = 'mba_tribune', enable = true },
            --{ name = 'mba_tarps', enable = true },
            --{ name = 'mba_fighting', enable = true },
            --{ name = 'mba_wrestling', enable = true },
            --{ name = 'mba_jumbotron', enable = true },

            -- MMA - enable all of the entitySets below
            { name = 'mba_tribune', enable = true },
            { name = 'mba_tarps', enable = true },
            { name = 'mba_fighting', enable = true },
            { name = 'mba_mma', enable = true },
            { name = 'mba_jumbotron', enable = true },

            -- BOXING - enable all of the entitySets below
            --{ name = 'mba_tribune', enable = true },
            --{ name = 'mba_tarps', enable = true },
            --{ name = 'mba_fighting', enable = true },
            --{ name = 'mba_boxing', enable = true },
            --{ name = 'mba_jumbotron', enable = true },

        },
        -- This sets what sign to display outside the arena, enable the sign you want for the entityset you are using
        exterior_ipl = {
            --"gabz_ipl_mba_sign_basketball",
            --"gabz_ipl_mba_sign_derby",
            -- "gabz_ipl_mba_sign_paintball",
            --"gabz_ipl_mba_sign_concert",
            --"gabz_ipl_mba_sign_fashion",
            --"gabz_ipl_mba_sign_fameorshame",
            --"gabz_ipl_mba_sign_wrestling",
            --"gabz_ipl_mba_sign_boxing",
            "gabz_ipl_mba_sign_mma",
        }
    },
}

CreateThread(function()
    for _, interior in ipairs(interiors) do
        if not interior.ipl or not interior.coords or not interior.entitySets then
            print('^5[GABZ]^7 ^1Error while loading interior.^7')
            return
        end
        RequestIpl(interior.ipl)
        local interiorID = GetInteriorAtCoords(interior.coords.x, interior.coords.y, interior.coords.z)
        if IsValidInterior(interiorID) then
            for __, entitySet in ipairs(interior.entitySets) do
                if entitySet.enable then
                    EnableInteriorProp(interiorID, entitySet.name)
                    if entitySet.color then
                        SetInteriorPropColor(interiorID, entitySet.name, entitySet.color)
                    end
                else
                    DisableInteriorProp(interiorID, entitySet.name)
                end
            end
            RefreshInterior(interiorID)
        end
        if interior.exterior_ipl ~= nil then
            for __, ext_ipl in ipairs(interior.exterior_ipl) do
                RequestIpl(ext_ipl)
            end
        end
    end
    print("^5[GABZ]^7 Interiors datas loaded.")
end)