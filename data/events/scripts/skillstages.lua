function Player:onGainSkillTries(skill, tries)
	if APPLY_SKILL_MULTIPLIER == false then
		return tries
	end

	if skill == SKILL_MAGLEVEL then
		return tries * configManager.getNumber(configKeys.RATE_MAGIC)
	end
	return tries * configManager.getNumber(configKeys.RATE_SKILL)
end


if getPlayerMagLevel(self) < 70 then end
if self:getSkillLevel(skill) < 100 then	end

function Player:onGainSkillTries(skill, tries)
	local skills = {10, 80}
	local mult = {2, 1}
		
	if APPLY_SKILL_MULTIPLIER == false then
		return tries
	end

	if skill == SKILL_MAGLEVEL then
	local var = getPlayerMagLevel(self)
	for i = 1, #skills do

	end
		return (tries*gain) * configManager.getNumber(configKeys.RATE_MAGIC)
	end
	local var = self:getSkillLevel(skill)
	return (tries*gain) * configManager.getNumber(configKeys.RATE_SKILL)
end
