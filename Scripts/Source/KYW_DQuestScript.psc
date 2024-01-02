Scriptname KYW_DQuestScript extends Quest  

;Formlists for checking words and adding/modifying shouts
Formlist property KYW_BreathAttacks auto
Formlist property KYW_AlphabetSoup auto
Formlist property KYW_Blessings auto
Formlist property KYW_VoiceSpells auto

;conditionals to see if player has previously learned DragonFire shouts
GlobalVariable property KYW_FirstForce auto
GlobalVariable property KYW_FirstFire auto
GlobalVariable property KYW_FirstFrost auto


Function GetKnowledge(Actor akBreather)
	;conditionals to pass to next functions
			bool forceBreath = akBreather.HasSpell(KYW_Blessings.GetAt(0))
			bool flameBreath = akBreather.HasSpell(KYW_Blessings.GetAt(1))
			bool frostBreath = akBreather.HasSpell(KYW_Blessings.GetAt(2))
			bool firstYol = KYW_AlphabetSoup.GetAt(0).PlayerKnows()
			bool firstFo = KYW_AlphabetSoup.GetAt(1).PlayerKnows()
			

		CompareKnowledge(forceBreath, flameBreath, frostBreath, firstYol, firstFo, akBreather)
	
EndFunction

Function CompareKnowledge(bool force, bool flame, bool frost, bool warm, bool chilly, Actor akBreather)
	;checks for each spell individually, one after the other
	
	
	If(force)
	RemoveKnowledge(0,akBreather)
	AddKnowledge(0,akBreather)		;Each section checks for the right spell, then removes shouts player shouldn't have. After that, passes an int and the player to the next function
	return
	ElseIf(flame)
		;checks if Player knows (but not necessarily unlocked) first word of fire or frost shouts. this way we can cut out checks without also accidentally giving shouts we don't need
		If(!warm)
		debug.notification("Your inner dragon yet sleeps...")
			return
		EndIf
	RemoveKnowledge(1,akBreather)
	AddKnowledge(1,akBreather)

	return
	ElseIf(frost)
		If(!chilly)
		debug.notification("Your inner dragon yet sleeps...")
			return
		EndIf
	RemoveKnowledge(2,akBreather)
	AddKnowledge(2,akBreather)
	
	EndIf

EndFunction

Function AddKnowledge(int dragonKnowledge, Actor akBreather)
		If (dragonKnowledge < 1) ;variable will only be 0, 1, or 2
			If(KYW_FirstForce.GetValue() as int < 1) ;First time needs to unlock words
					Game.TeachWord(KYW_AlphabetSoup.GetAt(10) as WordOfPower)
					Game.TeachWord(KYW_AlphabetSoup.GetAt(11) as WordOfPower)
					Game.TeachWord(KYW_AlphabetSoup.GetAt(12) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(10) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(11) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(12) as WordOfPower)
					KYW_FirstForce.SetValue(1.0)
			Else
				akBreather.addshout(KYW_BreathAttacks.GetAt(5) as shout)
				If (KYW_AlphabetSoup.GetAt(0).PlayerKnows())
					akBreather.addshout(KYW_BreathAttacks.GetAt(0) as shout)
				ElseIf (KYW_AlphabetSoup.GetAt(1).PlayerKnows())
					akBreather.addshout(KYW_BreathAttacks.GetAt(1) as shout)
				EndIf
			EndIf
		return
			
		ElseIf (dragonKnowledge > 1) ;starting with frost
			If(!Game.IsWordUnlocked(KYW_AlphabetSoup.GetAt(3) as WordOfPower))		;Checks if final word is unlocked. No check for Force since players need to  be in Apocrypha and that's post Horn of Jurgen
			debug.notification("Your breath chills but does not freeze...")
			return
			EndIf
				If(KYW_FirstFrost.GetValue() as int < 1) ;First time needs to unlock words
					Game.TeachWord(KYW_AlphabetSoup.GetAt(7) as WordOfPower)
					Game.TeachWord(KYW_AlphabetSoup.GetAt(8) as WordOfPower)
					Game.TeachWord(KYW_AlphabetSoup.GetAt(9) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(7) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(8) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(9) as WordOfPower)
					KYW_FirstFrost.SetValue(1.0)
					akBreather.addshout(KYW_BreathAttacks.GetAt(4) as shout)
					akBreather.addshout(KYW_BreathAttacks.GetAt(0) as shout)
					return
				Else
				akBreather.addshout(KYW_BreathAttacks.GetAt(4) as shout)
				akBreather.addshout(KYW_BreathAttacks.GetAt(3) as shout)
					If (KYW_AlphabetSoup.GetAt(0).PlayerKnows())
						akBreather.addshout(KYW_BreathAttacks.GetAt(0) as shout)
					EndIf
				EndIf
			return
		Else
			If(!Game.IsWordUnlocked(KYW_AlphabetSoup.GetAt(2) as WordOfPower)) 		;Checks if final word is unlocked. 
				debug.notification("Your breath chars but does not incinerate...")
				return
			EndIf
		
				If(KYW_FirstFire.GetValue() as int < 1) ;First time needs to unlock words
					Game.TeachWord(KYW_AlphabetSoup.GetAt(4) as WordOfPower)
					Game.TeachWord(KYW_AlphabetSoup.GetAt(5) as WordOfPower)
					Game.TeachWord(KYW_AlphabetSoup.GetAt(6) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(4) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(5) as WordOfPower)
					Game.UnlockWord(KYW_AlphabetSoup.GetAt(6) as WordOfPower)
					KYW_FirstFire.SetValue(1.0)
					akBreather.addshout(KYW_BreathAttacks.GetAt(4) as shout)
					akBreather.addshout(KYW_BreathAttacks.GetAt(1) as shout)
					return
				Else
				akBreather.addshout(KYW_BreathAttacks.GetAt(2) as shout)
				akBreather.addshout(KYW_BreathAttacks.GetAt(4) as shout)
					If (KYW_AlphabetSoup.GetAt(1).PlayerKnows())
						akBreather.addshout(KYW_BreathAttacks.GetAt(1) as shout)
					EndIf
				EndIf
		EndIf
EndFunction

Function RemoveKnowledge(int dragonKnowledge, Actor akBreather)
	If (dragonKnowledge < 1)
		akBreather.removeshout(KYW_BreathAttacks.GetAt(4) as shout) ;removes vanilla shout and other two Dragon Shouts
		akBreather.removeshout(KYW_BreathAttacks.GetAt(2) as shout)
		akBreather.removeshout(KYW_BreathAttacks.GetAt(3) as shout)
		return
	ElseIf (dragonKnowledge == 1)
		akBreather.removeshout(KYW_BreathAttacks.GetAt(0) as shout)	;removes vanilla shout and other two Dragon Shouts
		akBreather.removeshout(KYW_BreathAttacks.GetAt(5) as shout)
		akBreather.removeshout(KYW_BreathAttacks.GetAt(3) as shout)
		return
	Else
		akBreather.removeshout(KYW_BreathAttacks.GetAt(1) as shout)	;removes vanilla shout and other two Dragon Shouts
		akBreather.removeshout(KYW_BreathAttacks.GetAt(5) as shout)
		akBreather.removeshout(KYW_BreathAttacks.GetAt(2) as shout)
		return
	EndIf
	EndFunction
		