-- 

function onThink(interval, lastExecution)
    local MESSAGE = {
        "[COMMANDS] !buyhouse - !sellhouse - !serverinfo - !online - !uptime - !outfit .",
        "[TIBIA CLIENTS COMPATIVEIS]  10.00 e 11.40",
        "[FEATURES] NPCS VIA BANK, CRITICAL, NEW POTS, PREY, IMBUEMENT, CASKS AND KEGS.",
		"[FEATURES] NEW BLESSING SYSTEM, FULL GLOBAL MAP WITH HALLS OF ROPE.",
		"[FEATURES] BATTLEFIELD, CAPTURE THE FLAG, LAST STANDING MAN AND ZOOMBIE EVENT.",
	}
    Game.broadcastMessage(MESSAGE[math.random(1, #MESSAGE)], MESSAGE_EVENT_ADVANCE) 
    return true
end
