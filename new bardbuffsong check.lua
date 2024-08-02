---@param songSpell MQSpell
---@return boolean
function RGMercUtils.BuffSong(songSpell)
    if not songSpell or not songSpell() then return false end
    local me = mq.TLO.Me
	
	local delay = 6
	if combat_state = "Downtime" then
		delay = 12
	end
	
    local res = RGMercUtils.SongMemed(songSpell) and
        (me.Song(songSpell.Name()).Duration.TotalSeconds() or 0) <= (songSpell.MyCastTime.Seconds() + delay)	
    RGMercsLogger.log_verbose("\ayBuffSong(%s) => memed(%s), duration(%0.2f) < casttime(%0.2f) --> result(%s)",
        songSpell.Name(),
        RGMercUtils.BoolToColorString(me.Gem(songSpell.Name())() ~= nil),
        me.Song(songSpell.Name()).Duration.TotalSeconds() or 0, songSpell.MyCastTime.Seconds() + delay,
        RGMercUtils.BoolToColorString(res))
    return res
end