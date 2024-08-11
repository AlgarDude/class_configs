--Re-sings earlier outside of combat to keep durations fresh on higher-priority songs, lets songs tick down a bit more to fit in more insults/dots/etc during combat.
--These numbers require playtesting and may need to be tweaked, I am considering making them a configurable amount but not sure if that is overly complex for typical usecases.
---@param songSpell MQSpell
---@return boolean
function RGMercUtils.BuffSong(songSpell)
    if not songSpell or not songSpell() then return false end
	
	local duration = mq.TLO.Me.Song(songSpell.Name()).Duration.TotalSeconds() or 0
	local casttime = songSpell.MyCastTime.Seconds()
	local threshold = function(self) if RGMercUtils.GetXTHaterCount() == 0 then return casttime + 12 else return casttime + 6 end
	
	local res = RGMercUtils.SongMemed(songSpell) and duration <= threshold
    RGMercsLogger.log_verbose("BuffSong(%s) => memed(%s), duration(%0.2f) < threshold(%0.2f) --> result(%s)", songSpell.Name(), 
		RGMercUtils.BoolToColorString(me.Gem(songSpell.Name())() ~= nil), duration, threshold, RGMercUtils.BoolToColorString(res))
    return res
	end
end