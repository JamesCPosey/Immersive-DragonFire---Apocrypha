Scriptname KYW_EffectScript extends activemagiceffect

KYW_DQuestScript property DQuest auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Utility.Wait(1)
	;debug.messagebox("The Dragon Awakens")
	DQuest.GetKnowledge(akTarget)
EndEvent