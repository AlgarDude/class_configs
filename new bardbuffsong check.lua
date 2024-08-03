---@param songSpell MQSpell
---@return boolean
function RGMercUtils.BuffSong(songSpell)
    if not songSpell or not songSpell() then return false end
    local me = mq.TLO.Me

    local res = RGMercUtils.SongMemed(songSpell) and
        (me.Song(songSpell.Name()).Duration.TotalSeconds() or 0) <= (songSpell.MyCastTime.Seconds() + (mq.TLO.Me.Combat() and 6 or 12))
    RGMercsLogger.log_verbose("\ayBuffSong(%s) => memed(%s), duration(%0.2f) < casttime(%0.2f) --> result(%s)",
        songSpell.Name(),
        RGMercUtils.BoolToColorString(me.Gem(songSpell.Name())() ~= nil),
        me.Song(songSpell.Name()).Duration.TotalSeconds() or 0, songSpell.MyCastTime.Seconds() + (mq.TLO.Me.Combat() and 6 or 12),
        RGMercUtils.BoolToColorString(res))
    return res
end