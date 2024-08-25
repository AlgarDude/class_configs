AlgarInclude = { _version = '1.0', _name = "AlgarInclude", _author = 'Algar', }
--AlgarInclude.__index = AlgarInclude

function AlgarInclude.GroupBuffCheck(spell, targetId, targetName)
	if not spell or not spell() then return false end
	--check our buffs if we are the target
	if targetId == mq.TLO.Me.ID() then
		return RGMercUtils.SelfBuffCheck(spell)
		--check dannet if we aren't the target
	elseif mq.TLO.DanNet(targetName)() ~= nil then
		local spellName = spell.RankName.Name()
		local spellID = spell.RankName.ID()
		local spellResult = DanNet.query(targetName, string.format("Me.FindBuff[id %d]", spellID), 1000)
		RGMercsLogger.log_verbose("GroupBuffCheck() Querying via DanNet for %s(ID:%d) on %s", spellName, spellID, targetName)
		--RGMercsLogger.log_verbose("AlgarInclude.GroupBuffCheckNeedsBuff() DanNet result for %s: %s", spellName, spellResult)
		if spellResult == spellName then
			RGMercsLogger.log_verbose("GroupBuffCheck() DanNet detects that %s(ID:%d) is already present on %s, ending.", spellName, spellID, targetName)
			return false
		elseif spellResult == "NULL" then
			RGMercsLogger.log_verbose("GroupBuffCheck() DanNet detects %s(ID:%d) is missing on %s, let's check for triggers.", spellName, spellID, targetName)
			local numEffects = spell.NumEffects()
			local triggerCt = 0
			for i = 1, numEffects do
				local triggerSpell = spell.RankName.Trigger(i)
				if triggerSpell and triggerSpell() then
					local triggerRankResult = DanNet.query(targetName, string.format("Me.FindBuff[id %d]", triggerSpell.ID()), 1000)
					--RGMercsLogger.log_verbose("GroupBuffCheck() DanNet result for trigger %d of %d (%s, %s): %s", i, numEffects, triggerSpell.Name(), triggerSpell.ID(), triggerRankResult)
					if triggerRankResult == "NULL" then
						RGMercsLogger.log_verbose("GroupBuffCheck() DanNet found a missing trigger for %s(ID:%d) on %s, let's check stacking.", triggerSpell.Name(),
							triggerSpell.ID(), targetName)
						local triggerStackResult = DanNet.query(targetName, string.format("Spell[%s].Stacks", triggerSpell.Name()), 1000)
						--RGMercsLogger.log_verbose("GroupBuffCheck() DanNet result for stacking check of %s (ID:%d) on %s : %s", triggerSpell.Name(), triggerSpell.ID(), targetName, triggerStackResult)
						if triggerStackResult == "TRUE" then
							RGMercsLogger.log_verbose("GroupBuffCheck() %s (ID:%d) seems to stack on %s, let's do it!", triggerSpell.Name(), triggerSpell.ID(), targetName)
							return true
						end
						RGMercsLogger.log_verbose("GroupBuffCheck() %s(ID:%d) does not stack on %s, moving on.", triggerSpell.Name(), triggerSpell.ID(), targetName)
					end
					triggerCt = triggerCt + 1
				else
					RGMercsLogger.log_verbose("GroupBuffCheck() DanNet found no triggers for %s(ID:%d), let's check stacking.", spellName, spellID)
				end
			end
			if triggerCt >= numEffects then
				RGMercsLogger.log_verbose("GroupBuffCheck() DanNet found %d of %d existing triggers for %s(ID:%d) on %s, ending.", triggerCt, numEffects, spellName, spellID,
					targetName)
				return false
			end
			local stackResult = DanNet.query(targetName, string.format("Spell[%s].Stacks", spellName), 1000)
			--RGMercsLogger.log_verbose("GroupBuffCheck() DanNet result for stacking check of %s (ID:%d) on %s : %s", spellName, spellID, targetName, stackResult)
			if stackResult == "TRUE" then
				RGMercsLogger.log_verbose("GroupBuffCheck() %s (ID:%d) seems to stack on %s, let's do it!", spellName, spellID, targetName)
				return true
			end
			RGMercsLogger.log_verbose("GroupBuffCheck() %s(ID:%d) does not stack on %s, moving on.", spellName, spellID, targetName)
		end
	else
		--check the group manually for a mercenary or um... other weird thing?
		RGMercUtils.SetTarget(targetId)
		mq.delay("2s", function() return mq.TLO.Target.BuffsPopulated() end)
		return not RGMercUtils.TargetHasBuff(spell) and RGMercUtils.SpellStacksOnTarget(spell)
	end
end

--Allow us to ignore debuffing based on con color (and optionally always debuff named)
--TODO: Improve this? Refactor? It may be possible to use a passed target ID for better accuracy, wrote this earlier on.
function AlgarInclude.DebuffConCheck()
	local conLevel = RGMercConfig.Constants.ConColorsNameToId[mq.TLO.Target.ConColor()]
	if conLevel >= RGMercUtils.GetSetting('DebuffMinCon') or (RGMercUtils.IsNamed(mq.TLO.Target) and RGMercUtils.GetSetting('DebuffNamedAlways')) then return true end
	return false
end

--this is already present in my BST (which is now default), can likely get this pushed to RGMercUtils
function AlgarInclude.DotSpellCheck(spell) --Check dot stacking, stop dotting when a dynamic HP threshold is met(Named vs Trash)
	if not spell or not spell() then return false end
	local named = RGMercUtils.IsNamed(mq.TLO.Target)
	local targethp = RGMercUtils.GetTargetPctHPs()

	return not RGMercUtils.TargetHasBuff(spell) and RGMercUtils.SpellStacksOnTarget(spell) and
		((named and (RGMercUtils.GetSetting('NamedStopDOT') < targethp)) or (not named and RGMercUtils.GetSetting('HPStopDOT') < targethp))
end
