
; #FUNCTION# ====================================================================================================================
; Name ..........: ProfileReport
; Description ...: This function will report Attacks Won, Defenses Won, Troops Donated and Troops Received from Profile info page
; Syntax ........: ProfileReport()
; Parameters ....:
; Return values .: None
; Author ........: Sardo
; Modified ......: KnowJack (July 2015) add wait loop for slow PC read of OCR
;                  Sardo 2015-08
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func ProfileReport()

	Local $iCount
	ClickP($aAway, 1, 0, "#0221") ;Click Away
	If _Sleep($iDelayProfileReport1) Then Return

	SetLog(getLocaleString("logProfileReport"), $COLOR_BLUE)
	SetLog("Opening Profile page to read atk, def, donated ad received...", $COLOR_BLUE)
	Click(220, 33, 1, 0, "#0222") ; Click Info Profile Button
	If _Sleep($iDelayProfileReport2) Then Return

	While _ColorCheck(_GetPixelColor(222, 56, True), Hex(0x000000, 6), 20) = False ; wait for Info Profile to open
		If $Debugsetlog = 1 Then Setlog("Profile wait time: " & $iCount & ", color= "& _GetPixelColor(222, 56, True), $COLOR_PURPLE)
		$iCount += 1
		If _Sleep($iDelayProfileReport1) Then Return
		If $iCount >= 25 Then ExitLoop
	WEnd
	If $Debugsetlog = 1 And $iCount >= 25 Then Setlog("Excess wait time for profile to open: "&$iCount, $COLOR_PURPLE)
	If _Sleep($iDelayProfileReport1) Then Return
	$AttacksWon = ""
	$AttacksWon = getProfile(578, 268)
	If $Debugsetlog = 1 Then  Setlog("$AttacksWon 1st read: " & $AttacksWon, $COLOR_PURPLE)
	$iCount = 0
	While $AttacksWon = ""  ; Wait for $attacksWon to be readable in case of slow PC
		If _Sleep($iDelayProfileReport1) Then Return
		$AttacksWon = getProfile(578, 268)
		If $Debugsetlog = 1 Then Setlog("Read Loop $AttacksWon: " & $AttacksWon&", Count: "&$iCount, $COLOR_PURPLE)
		$iCount += 1
		If $iCount >= 20 Then ExitLoop
	WEnd
	If $Debugsetlog = 1 And $iCount >= 20 Then Setlog("Excess wait time for reading $AttacksWon: " & getProfile(578, 268), $COLOR_PURPLE)
	$DefensesWon = getProfile(790, 268)
	$TroopsDonated = getProfile(158, 268)
	$TroopsReceived = getProfile(360, 268)

	SetLog(getLocaleString("txtAttacksWon") & _NumberFormat($AttacksWon) & getLocaleString("txtDefensesWon") & _NumberFormat($DefensesWon) & getLocaleString("txtTroopsDonated") & _NumberFormat($TroopsDonated) & getLocaleString("txtTroopsReceived") & _NumberFormat($TroopsReceived), $COLOR_GREEN)
	Click(820, 40, 1, 0, "#0223") ; Close Profile page
	If _Sleep($iDelayProfileReport3) Then Return

	$iCount = 0
	While _CheckPixel($aIsMain, $bCapturePixel) = False  ; wait for profile report window very slow close
		If _Sleep($iDelayProfileReport3) Then Return
		$iCount += 1
		If $debugsetlog = 1 Then Setlog("End ProfileReport $iCount= "& $iCount, $Color_PURPLE)
		If $iCount > 50 Then
			If $Debugsetlog = 1 Then Setlog("Excess wait time clearing ProfileReport window: " &$iCount, $COLOR_PURPLE)
			ExitLoop
		EndIf
	WEnd

EndFunc   ;==>ProfileReport
