; #FUNCTION# ====================================================================================================================
; Name ..........: BotDetectFirstTime
; Description ...: This script detects your builings on the first run
; Author ........: HungLe (april-2015)
; Modified ......: Hervidero (april-2015),(may-2015), HungLe (may-2015), KnowJack(July 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func BotDetectFirstTime()

	Local $collx, $colly, $Result, $i = 0

	If $Is_ClientSyncError = True Then Return ; if restart after OOS, and User stop/start bot, skip this.

	ClickP($aTopLeftClient, 1, 0, "#0166") ; Click away
	If _Sleep(1000) Then Return

	_WinAPI_DeleteObject($hBitmapFirst)
	$hBitmapFirst = _CaptureRegion2()

	SetLog(getLocaleString("logDetectBuildings"), $COLOR_BLUE)

	If $ichkTrap = 1 And (isInsideDiamond($TownHallPos) = False) Then
		Local $PixelTHHere = GetLocationItem("getLocationTownHall")
		If UBound($PixelTHHere) > 0 Then
			$pixel = $PixelTHHere[0]
			$TownHallPos[0] = $pixel[0]
			$TownHallPos[1] = $pixel[1]
			If $debugSetlog = 1 Then SetLog("Townhall: (" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_PURPLE)
		EndIf
	EndIf

	If Number($iTownHallLevel) < 2 Then
		$Result = GetTownHallLevel(True) ; Get the Users TH level
		If IsArray($Result) Then $iTownHallLevel = 0  ; Check for error finding TH level, and reset to zero if yes
	EndIf
	If Number($iTownHallLevel) > 1 And Number($iTownHallLevel) < 6 Then
		Setlog(getLocaleString("logWarnTHLv6"), $COLOR_RED)
		Setlog(getLocaleString("logWarnTHLv6_2"), $COLOR_RED)
	EndIf

	If _Sleep(100) Then Return

;~ 	If $barrackPos[0] = "" Or $barrackNum = 0 Then
;~ 		Local $PixelBarrackHere = GetLocationItem("getLocationBarrack")
;~ 		$barrackNum = UBound($PixelBarrackHere)
;~ 		SetLog("Total No. of Barracks: " & $barrackNum, $COLOR_PURPLE)
;~ 		If UBound($PixelBarrackHere) > 0 Then
;~ 			$pixel = $PixelBarrackHere[0]
;~ 			$barrackPos[0] = $pixel[0]
;~ 			$barrackPos[1] = $pixel[1]
;~ 			If $debugSetlog = 1 Then
;~ 				For $i = 0 To UBound($PixelBarrackHere) - 1
;~ 					$pixel = $PixelBarrackHere[$i]
;~ 					SetLog("- Barrack " & $i + 1 & ": (" & $pixel[0] & "," & $pixel[1] & ")", $COLOR_PURPLE)
;~ 				Next
;~ 			EndIf

;~ 		EndIf
;~ 	EndIf

;~ 	If _Sleep(50) Then Return

;~ 	If $barrackDarkNum = 0 Then
;~ 		Local $PixelBarrackDarkHere = GetLocationItem("getLocationDarkBarrack")
;~ 		$barrackDarkNum = UBound($PixelBarrackDarkHere)
;~ 		SetLog("Total No. of Dark Barracks: " & $barrackDarkNum, $COLOR_PURPLE)
;~ 		If UBound($PixelBarrackDarkHere) > 0 And $debugSetlog = 1 Then
;~ 			For $i = 0 To UBound($PixelBarrackDarkHere) - 1
;~ 				$pixel = $PixelBarrackDarkHere[$i]
;~ 				SetLog("- Dark Barrack " & $i + 1 & ": (" & $pixel[0] & "," & $pixel[1] & ")", $COLOR_PURPLE)
;~ 			Next
;~ 		EndIf

;~ 	EndIf
	If _Sleep(100) Then Return

	If isInsideDiamond($barrackPos) = False Then
		LocateBarrack()
	EndIf


	If _Sleep(100) Then Return

	If isInsideDiamond($ArmyPos) = False Then
		LocateBarrack(True)
	EndIf

	If _Sleep(100) Then Return

	If isInsideDiamond($aCCPos) = False Then
		LocateClanCastle()
	EndIf

	If _Sleep(100) Then Return

	If $listResourceLocation = "" Then
		While 1 ; Clear the collectors using old image find to reduce collector image finding errors
			If _Sleep(100) Or $RunState = False Then ExitLoop
			_CaptureRegion(0, 0, 780)
			If _ImageSearch(@ScriptDir & "\images\collect.png", 1, $collx, $colly, 20) Then
				Click($collx, $colly, 1, 0, "#0330") ;Click collector
				If _Sleep(100) Then Return
				ClickP($aTopLeftClient, 1, 0, "#0329") ;Click Away
			ElseIf $i >= 20 Then
				ExitLoop
			EndIf
			$i += 1
		WEnd
		SetLog (getLocaleString("logDetectMines"))
		$PixelMineHere = GetLocationItem("getLocationMineExtractor")
		If UBound($PixelMineHere) > 0 Then
			SetLog(getLocaleString("logTotalMines") & UBound($PixelMineHere))
		EndIf
		For $i = 0 To UBound($PixelMineHere) - 1
			$pixel = $PixelMineHere[$i]
			$listResourceLocation = $listResourceLocation & $pixel[0] & ";" & $pixel[1] & "|"
			If $debugSetlog = 1 Then SetLog("- Gold Mine " & $i + 1 & ": (" & $pixel[0] & "," & $pixel[1] & ")", $COLOR_PURPLE)
		Next
		If _Sleep(1000) Then Return
		$PixelElixirHere = GetLocationItem("getLocationElixirExtractor")
		If UBound($PixelElixirHere) > 0 Then
			SetLog(getLocaleString("logTotalCollectors") & UBound($PixelElixirHere))
		EndIf
		For $i = 0 To UBound($PixelElixirHere) - 1
			$pixel = $PixelElixirHere[$i]
			$listResourceLocation = $listResourceLocation & $pixel[0] & ";" & $pixel[1] & "|"
			If $debugSetlog = 1 Then SetLog("- Elixir Collector " & $i + 1 & ": (" & $pixel[0] & "," & $pixel[1] & ")", $COLOR_PURPLE)
		Next
		If _Sleep(1000) Then Return
		$PixelDarkElixirHere = GetLocationItem("getLocationDarkElixirExtractor")
		If UBound($PixelDarkElixirHere) > 0 Then
			SetLog(getLocaleString("logTotalDrills") & UBound($PixelDarkElixirHere))
		EndIf
		For $i = 0 To UBound($PixelDarkElixirHere) - 1
			$pixel = $PixelDarkElixirHere[$i]
			$listResourceLocation = $listResourceLocation & $pixel[0] & ";" & $pixel[1] & "|"
			If $debugSetlog = 1 Then SetLog("- Dark Ellxir Drill " & $i + 1 & ": (" & $pixel[0] & "," & $pixel[1] & ")", $COLOR_PURPLE)
		Next
	EndIf

EndFunc   ;==>BotDetectFirstTime
