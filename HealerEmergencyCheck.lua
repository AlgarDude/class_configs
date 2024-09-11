function RGMercUtils.HealerEmergencyCheck()
    if not RGMercUtils.IsHealing() then return true end

    return (mq.TLO.Group.MainTank.PctHPs() or RGMercUtils.GetMainAssistPctHPs()) > RGMercUtils.GetSetting('BigHealPoint')
end
