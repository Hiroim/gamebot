; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Control
; Description ...: This file Includes all functions to current GUI
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GkevinOD (2014)
; Modified ......: Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func chkUnbreakable()
	If GUICtrlRead($chkUnbreakable) = $GUI_CHECKED Then
		GUICtrlSetState($txtUnbreakable, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinGold, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxGold, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinElixir, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxElixir, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMinDark, $GUI_ENABLE)
		GUICtrlSetState($txtUnBrkMaxDark, $GUI_ENABLE)
		$iUnbreakableMode = 1
	ElseIf GUICtrlRead($chkUnbreakable) = $GUI_UNCHECKED Then
		GUICtrlSetState($txtUnbreakable, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinGold, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxGold, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinElixir, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxElixir, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMinDark, $GUI_DISABLE)
		GUICtrlSetState($txtUnBrkMaxDark, $GUI_DISABLE)
		$iUnbreakableMode = 0
	EndIf
EndFunc   ;==>chkUnbreakable

Func chkAttackNow()
	If GUICtrlRead($chkAttackNow) = $GUI_CHECKED Then
		$iChkAttackNow = 1
		GUICtrlSetState($lblAttackNow, $GUI_ENABLE)
		GUICtrlSetState($lblAttackNowSec, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_ENABLE)
	Else
		$iChkAttackNow = 0
		GUICtrlSetState($lblAttackNow, $GUI_DISABLE)
		GUICtrlSetState($lblAttackNowSec, $GUI_DISABLE)
		GUICtrlSetState($cmbAttackNowDelay, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkAttackNow

#comments-start
Func GUILightSpell()
	If GUICtrlRead($chkLightSpell) = $GUI_CHECKED Then
		$iChkLightSpell = 1
		GUICtrlSetState($lbliLSpellQ, $GUI_ENABLE)
		GUICtrlSetState($cmbiLSpellQ, $GUI_ENABLE)
		GUICtrlSetState($lbliLSpellQ2, $GUI_ENABLE)
	Else
		$iChkLightSpell = 0
		GUICtrlSetState($lbliLSpellQ, $GUI_DISABLE)
		GUICtrlSetState($cmbiLSpellQ, $GUI_DISABLE)
		GUICtrlSetState($lbliLSpellQ2, $GUI_DISABLE)
	EndIf
EndFunc   ;==>GUILightSpell
#comments-end

Func chkBullyMode()
	If GUICtrlRead($chkBullyMode) = $GUI_CHECKED Then
		$OptBullyMode = 1
		GUICtrlSetState($txtATBullyMode, $GUI_ENABLE)
		GUICtrlSetState($cmbYourTH, $GUI_ENABLE)
		GUICtrlSetState($radUseDBAttack, $GUI_ENABLE)
		GUICtrlSetState($radUseLBAttack, $GUI_ENABLE)
	Else
		$OptBullyMode = 0
		GUICtrlSetState($txtATBullyMode, $GUI_DISABLE)
		GUICtrlSetState($cmbYourTH, $GUI_DISABLE)
		GUICtrlSetState($radUseDBAttack, $GUI_DISABLE)
		GUICtrlSetState($radUseLBAttack, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBullyMode

Func chkSnipeMode()
	If GUICtrlRead($chkTrophyMode) = $GUI_CHECKED Then
		$OptTrophyMode = 1
		GUICtrlSetState($txtTHaddtiles, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_ENABLE)
	Else
		$OptTrophyMode = 0
		GUICtrlSetState($txtTHaddtiles, $GUI_DISABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkSnipeMode

Func chkMortar()
	If GUICtrlRead($chkMortar) = $GUI_CHECKED Then
		$skipMortar = 1
		SetLog("$skipMortar: " & $skipMortar, $COLOR_BLUE)
	Else
		$skipMortar = 0
		SetLog("$skipMortar: " & $skipMortar, $COLOR_RED)
	EndIf
EndFunc   ;==>chkMortar

Func chkWiz()
	If GUICtrlRead($chkWiz) = $GUI_CHECKED Then
		$skipWiz = 1
		SetLog("$skipWiz: " & $skipWiz, $COLOR_BLUE)
	Else
		$skipWiz = 0
		SetLog("$skipWiz: " & $skipWiz, $COLOR_RED)
	EndIf
EndFunc   ;==>chkWiz

Func chkInferno()
	If GUICtrlRead($chkInferno) = $GUI_CHECKED Then
		$skipInferno = 1
		SetLog("$skipInferno: " & $skipInferno, $COLOR_BLUE)
	Else
		$skipInferno = 0
		SetLog("$skipInferno: " & $skipInferno, $COLOR_RED)
	EndIf
EndFunc   ;==>chkInferno

Func chkTesla()
	If GUICtrlRead($chkTesla) = $GUI_CHECKED Then
		$skipTesla = 1
		SetLog("$skipTesla: " & $skipTesla, $COLOR_BLUE)
	Else
		$skipTesla = 0
		SetLog("$skipTesla: " & $skipTesla, $COLOR_RED)
	EndIf
EndFunc   ;==>chkTesla

Func chkAir()
	If GUICtrlRead($chkAir) = $GUI_CHECKED Then
		$skipAir = 1
		SetLog("$skipAir: " & $skipAir, $COLOR_BLUE)
	Else
		$skipAir = 0
		SetLog("$skipAir: " & $skipAir, $COLOR_RED)
	EndIf
EndFunc   ;==>chkAir

Func chkGrdTroops()
	If GUICtrlRead($chkGrdTroops) = $GUI_CHECKED Then
		$grdTroops = 1
		SetLog("$grdTroops: " & $grdTroops, $COLOR_BLUE)
	Else
		$grdTroops = 0
		SetLog("$grdTroops: " & $grdTroops, $COLOR_RED)
	EndIf
EndFunc   ;==>chkGrdTroops

Func chkAirTroops()
	If GUICtrlRead($chkAirTroops) = $GUI_CHECKED Then
		$airTroops = 1
		SetLog("$airTroops: " & $airTroops, $COLOR_BLUE)
	Else
		$airTroops = 0
		SetLog("$airTroops: " & $airTroops, $COLOR_RED)
	EndIf
EndFunc   ;==>chkAirTroops
