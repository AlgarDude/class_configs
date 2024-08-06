function RGMercUtils.CheckPCNeedsBuff(spell, targetId, targetName)
    if not spell or not spell() then return false end
		--check our buffs if we are the target
    if targetId == mq.TLO.Me.ID() then return RGMercUtils.SelfBuffCheck(spell)
		--check dannet if we aren't the target
	elseif mq.TLO.DanNet(targetName)() ~= nil then
		
		RGMercsLogger.log_verbose("CheckPCNeedsBuff() Querying via DanNet for %s(ID:%d) on %s", spell.RankName.Name(), spell.ID(), targetName)
		local spellResult = DanNet.query(targetName, string.format("Me.FindBuff[id %d]", spell.RankName.ID()), 1000)
			RGMercsLogger.log_verbose("CheckPCNeedsBuff() DanNet result for %s: %s", spell.RankName.Name(), queryResult)
		if spellResult ~= (nil or "NULL") then
			RGMercsLogger.log_verbose("CheckPCNeedsBuff() DanNet detects that %s(ID:%d) is already present on %s, ending.", spell.RankName.Name(), spell.ID(), targetName)
			return false end
		if spellResult == (nil or "NULL") then
			RGMercsLogger.log_verbose("CheckPCNeedsBuff() DanNet detects %s(ID:%d) is missing on %s, let's check for triggers.", spell.RankName.Name(), spell.ID(), targetName)
			local numEffects = spell.NumEffects()
			local triggerCt = 0
			for i = 1, numEffects do
				local triggerSpell = spell.Trigger(i)
				if triggerSpell and triggerSpell() then
					RGMercUtils.SetTarget(targetId)
					--RGMercsLogger.log_verbose("CheckPCNeedsBuff() Querying via DanNet for %d triggers of %s(ID:%d) on %s", numEffects, spell.Name(), spell.ID(), targetName)
					--local triggerResult = DanNet.query(targetName, string.format("Me.FindBuff[id %d]", triggerSpell.ID()), 1000)
					local triggerRankResult = DanNet.query(targetName, string.format("Me.FindBuff[id %d]", triggerSpell.ID()), 1000)
					RGMercsLogger.log_verbose("CheckPCNeedsBuff() DanNet result for trigger %d of %d (%s, %s): %s", i, numEffects, triggerSpell.Name(), triggerSpell.ID(), triggerRankResult)
					if triggerRankResult == (nil or "NULL") then--(triggerResult or triggerRankResult) == "NULL" then
						RGMercsLogger.log_verbose("CheckPCNeedsBuff() DanNet found a missing trigger for %s(ID:%d) on %s, let's check stacking.", triggerSpell.Name(), triggerSpell.ID(), targetName)
						if RGMercUtils.SpellStacksOnTarget(triggerSpell) then 
							RGMercsLogger.log_verbose("CheckPCNeedsBuff() %s (ID:%d) seems to stack on %s, let's do it!", triggerSpell.Name(), triggerSpell.ID(), targetName)
							return true 
						end
						RGMercsLogger.log_verbose("CheckPCNeedsBuff() %s(ID:%d) does not stack on %s, moving on.", triggerSpell.Name(), triggerSpell.ID(), targetName)
					end
					triggerCt = triggerCt + 1
				end
			end
            if triggerCt >= numEffects then
			    RGMercsLogger.log_verbose("CheckPCNeedsBuff() DanNet found %d of %d existing triggers for %s(ID:%d) on %s, ending.", triggerCt, numEffects, spell.Name(), spell.ID(), targetName)
			    return false
		    end
			RGMercsLogger.log_verbose("CheckPCNeedsBuff() DanNet found no triggers for %s(ID:%d), let's check stacking.", spell.RankName.Name(), spell.ID())
			RGMercUtils.SetTarget(targetId)
			if RGMercUtils.SpellStacksOnTarget(spell) then
				RGMercsLogger.log_verbose("CheckPCNeedsBuff() %s (ID:%d) seems to stack on %s, let's do it!", spell.RankName.Name(), spell.ID(), targetName)
				return true
			end
			RGMercsLogger.log_verbose("CheckPCNeedsBuff() %s(ID:%d) does not stack on %s, moving on.", spell.Name(), spell.ID(), targetName)
		end
	else
	--check the group manually on the offchance dannet doesn't report (although if dannet crashes, RGL surely follows)
    RGMercUtils.SetTarget(targetId)
    mq.delay("2s", function() return mq.TLO.Target.BuffsPopulated() end)
    return not RGMercUtils.TargetHasBuff(spell) and RGMercUtils.SpellStacksOnTarget(spell)	
	end
end