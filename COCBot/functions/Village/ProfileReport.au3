
; #FUNCTION# ====================================================================================================================
; Name ..........: ProfileReport
; Description ...: This function will report Attacks Won, Defenses Won, Troops Donated and Troops Received from Profile info page
; Syntax ........: ProfileReport()
; Parameters ....:
; Return values .: None
; Author ........: Sardo
; Modified ......: KnowJack (July 2015) add wait loop for slow PC read of OCR
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func ProfileReport()
	Local $iCount
	ClickP($aTopLeftClient, 1, 0, "#0221") ;Click Away
	If _Sleep(500) Then Return

	SetLog("Profile Report", $COLOR_BLUE)
	SetLog("Opening Profile page to read atk, def, donated ad received...", $COLOR_BLUE)
	Click(220, 33, 1, 0, "#0222") ; Click Info Profile Button
	If _Sleep(1000) Then Return

	While _ColorCheck(_GetPixelColor(222, 56, True), Hex(0x000000, 6), 20) = False ; wait for Info Profile to open
		$iCount += 1
		If _Sleep(500) Then Return
		If $iCount >= 25 Then ExitLoop
	WEnd
	If _Sleep(500) Then Return
	$AttacksWon = ""
	$AttacksWon = getProfile(578, 268)
	$iCount = 0
	While $AttacksWon = ""  ; Wait for $attacksWon to be readable in case of slow PC
		If _Sleep(500) Then Return
		$AttacksWon = getProfile(578, 268)
		$iCount += 1
		If $iCount >= 20 Then ExitLoop
	WEnd
	$DefensesWon = getProfile(790, 268)
	$TroopsDonated = getProfile(158, 268)
	$TroopsReceived = getProfile(360, 268)

	SetLog(" [ATKW]: " & _NumberFormat($AttacksWon) & " [DEFW]: " & _NumberFormat($DefensesWon) & " [TDON]: " & _NumberFormat($TroopsDonated) & " [TREC]: " & _NumberFormat($TroopsReceived), $COLOR_GREEN)
	Click(820, 40, 1, 0, "#0223") ; Close Profile page

EndFunc   ;==>ProfileReport
