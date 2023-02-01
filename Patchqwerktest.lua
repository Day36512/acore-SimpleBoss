local npcId = 400012 --defines a variable npcId with a value of 400012.

local function CastTrample(eventId, delay, calls, creature) --CastTrample, CastHatefulStrike, and CastGore are functions that cast spells on the creature's target (obtained through creature:GetVictim()). The spells cast are specified by their spell IDs (5568, 28308, and 48130 respectively).
    creature:CastSpell(creature:GetVictim(), 5568, true)
end

local function CastHatefulStrike(eventId, delay, calls, creature) 
    creature:CastSpell(creature:GetVictim(), 28308, true)
end

local function CastGore(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 48130, true)
end

local function OnEnterCombat(event, creature, target) --OnEnterCombat is a function that is triggered when the creature enters combat, it sends a unit yell message with text "Tasty!", and registers the spells from the first 3 functions to be cast every 10, 15 and 20 seconds respectively.
	creature:SendUnitYell("Tasty!", 0)
	creature:RegisterEvent(CastTrample, 10000, 0)
    creature:RegisterEvent(CastHatefulStrike, 15000, 0)
    creature:RegisterEvent(CastGore, 20000, 0)
	end
	
local function OnLeaveCombat(event, creature) --OnLeaveCombat is a function that is triggered when the creature leaves combat, it sends a unit yell message with text "You not so tasty after all..." and removes all registered events.
    creature:SendUnitYell("You not so tasty afterall...", 0)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer) --OnDied is a function that is triggered when the creature dies. If the killer is a player, it sends a broadcast message to the player with the text "You killed <creature name>!". The function also removes all registered events.
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("You killed " ..creature:GetName().."!")
    end
    creature:RemoveEvents()
end

RegisterCreatureEvent(npcId, 1, OnEnterCombat) --RegisterCreatureEvent is a function that registers the event handlers OnEnterCombat, OnLeaveCombat, and OnDied for the specified creature npcId with events 1, 2, and 4 respectively.
RegisterCreatureEvent(npcId, 2, OnLeaveCombat)
RegisterCreatureEvent(npcId, 4, OnDied)