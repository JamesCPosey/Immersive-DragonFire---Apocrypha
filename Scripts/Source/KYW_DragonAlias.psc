Scriptname KYW_DragonAlias extends ReferenceAlias  
{Using player reference alias to capture spell casts. Needed for self casted effects on Dragon Breath shouts}
Formlist property KYW_VoiceSpells auto ;for the voice power spells to proc, needed to be Formlist as OnSpellCast passes akSpell in FormID instead of Editor ID
;spells to cast that will set the armor for the length of the shout
Spell property KYW_DragonAspectHeadSpell auto 
Spell property KYW_DragonAspectArmsSpell auto 

MagicEffect property DragonAspect auto
Actor Property Player  Auto  

Event OnSpellCast(Form akSpell)
		If(akSpell == KYW_VoiceSpells.GetAt(0) || akSpell == KYW_VoiceSpells.GetAt(1) || akSpell == KYW_VoiceSpells.GetAt(4))
			KYW_DragonAspectArmsSpell.Cast(Player,Player)
		ElseIf (akSpell == KYW_VoiceSpells.GetAt(2) || akSpell == KYW_VoiceSpells.GetAt(3) || akSpell == KYW_VoiceSpells.GetAt(5))
			KYW_DragonAspectHeadSpell.Cast(Player,Player)
		EndIf
EndEvent