LIB31ST_ESCORT = {}

--- Create an Escort AirGroup to protect another group
-- @param #string escortTemplate name of the escort group in the mission editor
-- @param #string popupZone Name zone defined in the mission editor for escort popup.
-- @param #GROUP escortedGroup the Moose group object to protect
-- @param #number escortFreq not used yet
-- @param #string skill Skill of the escort group
-- @param #bool agressive Will the escort group shoot first or not
-- @return #GROUP Escort group created
function LIB31ST_ESCORT:spawnEscortInZone(escortTemplate, popupZone, escortedGroup, escortFreq, skill, agressive)
  if not(escortedGroup) then
    BASE:E("spawnEscortInZone(): group " + escortedGroup + " not found !!!")
    return nil
  end
  local popupZoneObject = ZONE:New(popupZone)
  if not(popupZoneObject) then
    BASE:E("spawnEscortInZone(): popup zone not found !!!")
    return nil
  end
  local groupEscort = SPAWN
    :New(escortTemplate)
    :InitSkill(skill)
    :OnSpawnGroup(
      function( escortGroup )
        BASE:E(string.format("group escorte : %s", escortGroup:GetName()))
        BASE:E(string.format("is alive ? %s",tostring(escortGroup:IsAlive())))
        escortGroup:PushTask(escortGroup:TaskEscort(escortedGroup, POINT_VEC3:New( 1000, 0, 1000 ), nil , 40, {"Air"}), 0)
      end)     
    :SpawnInZone(popupZoneObject, true)
  return groupEscort
end