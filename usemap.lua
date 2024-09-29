['usemap'] = {
        usage = "/rgl usemap \"<maptype>\" \"<mapname>\" <targetId?>",
        about = "RGMercs will use the mapped spell, song, AA, disc, or item (using smart targeting, or, if provided, on the specified <targetID>).",
        handler = function(mapType, mapName, targetId)
            local action = RGMercModules:ExecModule("Class", "GetResolvedActionMapItem", mapName)
            if not action or not action() then
                RGMercsLogger.log_debug("\arUseMap: \"\ay%s\ar\" does not appear to be a valid mapped action! \awPlease note this value is case-sensitive.", mapName)
                return false
            end
            targetId = targetId and tonumber(targetId)
            targetId = targetId or (mq.TLO.Target.ID() > 0 and mq.TLO.Target.ID() or mq.TLO.Me.ID())

            local actionHandlers = {
                spell = function() return RGMercUtils.UseSpell(action.RankName, targetId, true) end,
                song = function() return RGMercUtils.UseSong(action.RankName, targetId, true) end,
                aa = function() return RGMercUtils.UseAA(action, targetId) end,
                item = function() return RGMercUtils.UseItem(action, targetId) end,
                disc = function() return RGMercUtils.UseDisc(action, targetId) end,
            }

            local handlerFunc = actionHandlers[mapType:lower()]
            if handlerFunc then
                handlerFunc()
            else
                RGMercsLogger.log_debug("\arUseMap: \"\ay%s\ar\" is an invalid maptype. \awValid maptypes are : \agspell \aw| \agsong \aw| \agAA \aw| \agdisc \aw| \agitem", mapType)
            end
        end,
    },