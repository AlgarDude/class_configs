---@diagnostic disable: unused-local, redundant-value

                name = "Summon Modulation Shard",
                type = "AA",
                cond = function(self, aaName, target)
                    local modRodSpell = mq.TLO.Spell(aaName)
                    if not RGMercUtils.GetSetting('SummonModRods') or not modRodSpell or not modRodSpell() then return false end
                    local modRodItem = modRodSpell.RankName.Base(1)()
                    return RGMercUtils.AAReady(aaName) and self.HelperFunctions.modRodNeeded(modRodItem, target.CleanName()) and (mq.TLO.Cursor.ID() or 0) == 0
                end,
                post_activate = function(self, aaName, success)
                    if success then
                        RGMercUtils.SafeCallFunc("Autoinventory", self.ClassConfig.HelperFunctions.HandleItemSummon, self, aaName, "group")
                    end
                end,
            

modRodNeeded = function (item, targetName)
    if not targetName or not targetName() then return false end
    if targetName == mq.TLO.Me.CleanName() then
    local ineed =  mq.TLO.FindItemCount(modRodItem)() == 0
    elseif mq.TLO.DanNet(targetName)() ~= nil then
    local groupneeds = DanNet.query(targetName, string.format("FindItemCount[%s]", item), 1000) == 0
    end
    return ineed or groupneeds
end


BandolierSwap = function(indexName)
    if RGMercUtils.GetSetting('SwitchWeapons') and mq.TLO.Me.Bandolier(indexName).Index() and not mq.TLO.Me.Bandolier(indexName).Active() then
        RGMercUtils.DoCmd("/bandolier activate %s", indexName)
    end
end