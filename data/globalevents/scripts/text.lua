local effects = {
{position = Position(32360, 32239, 7), text = 'EVENTS ROOM!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(32055, 31886, 6), text = 'SORCERERS!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(32073, 31886, 6), text = 'DRUIDS!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(32069, 31886, 6), text = 'KNIGHTS!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(32059, 31886, 6), text = 'PALADINS!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(32365, 32236, 7), text = 'TRAINING ISLAND!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(33559, 31280, 11), text = 'TIME OF BOSSES!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(33646, 31261, 11), text = 'TIME OF BOSSES!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(33436, 31247, 11), text = 'TIME OF BOSSES!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(33479, 31315, 7), text = 'TIME OF BOSSES!', effect = CONST_ME_GROUNDSHAKER},
{position = Position(32584, 31401, 8), text = 'Click here for final mission!', effect = CONST_ME_GROUNDSHAKER},
}

function onThink(interval)
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end