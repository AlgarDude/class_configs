function RGMercUtils.MemorizeSpell(gem, spell, waitSpellReady, maxWait)
    RGMercsLogger.log_info("\ag Meming \aw %s in \ag slot %d", spell, gem)
    RGMercUtils.DoCmd("/memspell %d \"%s\"", gem, spell)

    while (mq.TLO.Me.Gem(gem)() ~= spell or (waitSpellReady and not mq.TLO.Me.SpellReady(gem)())) and maxWait > 0 do
		if RGMercUtils.GetXTHaterCount() > 0 then
			RGMercsLogger.log_verbose("MemorizeSpell() I was interrupted by combat while waiting for spell '%s' to load in slot %d'! Aborting.", spell, gem)
			break
		end
        RGMercsLogger.log_verbose("\ayWaiting for '%s' to load in slot %d'...", spell, gem)
        mq.delay(100)
        maxWait = maxWait - 100
    end
end