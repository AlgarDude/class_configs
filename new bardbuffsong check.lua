--Re-sings earlier outside of combat to keep durations fresh on higher-priority songs, lets songs tick down a bit more to fit in more insults/dots/etc during combat.
--These numbers require playtesting and may need to be tweaked, I am considering making them a configurable amount but not sure if that is overly complex for typical usecases.
---@param songSpell MQSpell
---@return boolean
--TODO: REFACTOR THIS PUPPY
function RGMercUtils.BuffSong(songSpell)
    if not songSpell or not songSpell() then return false end
    local me = mq.TLO.Me
	local casttime = songSpell.MyCastTime.Seconds()
	local threshold = 6
	if RGMercUtils.GetXTHaterCount() == 0 then threshold = 12 end
	
    local res = RGMercUtils.SongMemed(songSpell) and
        (me.Song(songSpell.Name()).Duration.TotalSeconds() or 0) <= (casttime + threshold)
    RGMercsLogger.log_verbose("\ayBuffSong(%s) => memed(%s), duration(%0.2f) < reusetime(%0.2f) --> result(%s)",
        songSpell.Name(),
        RGMercUtils.BoolToColorString(me.Gem(songSpell.RankName.Name())() ~= nil),
        me.Song(songSpell.Name()).Duration.TotalSeconds() or 0, casttime + threshold,
        RGMercUtils.BoolToColorString(res))
    return res
end