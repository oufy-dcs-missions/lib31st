LIB31ST_CAP = {}

function LIB31ST_CAP:spawnCAPInZone(CAPTemplate, popupZone, CAPFreq, skill)
  local popupZoneObject = ZONE:New(popupZone)
  if not(popupZoneObject) then
    BASE:E("spawnCAPInZone(): popup zone not found !!!")
    return nil
  end
  local groupCAP = SPAWN
    :New(CAPTemplate)
    :InitSkill(skill)
    :OnSpawnGroup(
      function( currentGroup )
        BASE:E(string.format("group CAP : %s", currentGroup:GetName()))
        BASE:E(string.format("is alive ? %s",tostring(currentGroup:IsAlive())))
        currentGroup:OptionROEWeaponFree()
        currentGroup:OptionAlarmStateRed()
        currentGroup:EnRouteTaskEngageTargets(200,{"Air"},0)
      end)
    :SpawnInZone(popupZoneObject, true)
  return groupCAP

end