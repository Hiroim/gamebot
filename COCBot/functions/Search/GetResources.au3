; #FUNCTION# ====================================================================================================================
; Name ..........: CGB Bot
; Description ...: Uses the ColorCheck until the screen is clear from Clouds to Get Resources values.
; Author ........: HungLe (2015)
; Modified ......: ProMac (2015), Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================


Func GetResources() ;Reads resources

	If _Sleep($iDelayGetResources1) Then Return
	$searchGold = ""
	$searchElixir = ""
	$searchDark = ""
	$searchTrophy = ""
	Local $iResult = 0
	Local $i = 0

	While _CheckPixel($aNoCloudsAttack, $bCapturePixel) = False ; wait for clouds to be gone
		If _Sleep($iDelayGetResources2) Then Return
		$i += 1
		If $i >= 60 Or isProblemAffect(True) Then ; wait max 30 sec then restart bot
			checkMainScreen()
			If $Restart Then
				SetLog(getLocaleString("logCantLocateNextBtn"), $COLOR_RED)
				Pushmsg("OoSResources")
				$Is_ClientSyncError = True
				$iStuck = 0
				Return
			Else
				SetLog(getLocaleString("logStrangeProblem"), $COLOR_RED)
				$Is_ClientSyncError = True
				$iStuck = 0
				$Restart = True
				Return
			EndIf
		EndIf
		If $debugSetlog = 1 Then SetLog("Loop to clean screen without Clouds , n� :" & $i, $COLOR_PURPLE)
	WEnd

	If _Sleep($iDelayGetResources3) Then Return
	$searchGold = getGoldVillageSearch(48, 69)

	If _Sleep($iDelayGetResources3) Then Return
	$searchElixir = getElixirVillageSearch(48, 69 + 29)

	If _Sleep($iDelayGetResources3) Then Return
	If _ColorCheck(_GetPixelColor(30, 142, True), Hex(0x07010D, 6), 10) Then ; check if the village have a Dark Elixir Storage
		$searchDark = getDarkElixirVillageSearch(48, 69 + 57)
		$searchTrophy = getTrophyVillageSearch(48, 69 + 99)
	Else
		$searchDark = "N/A"
		$searchTrophy = getTrophyVillageSearch(48, 138)
	EndIf

	If $searchGold = $searchGold2 And $searchElixir = $searchElixir2 Then $iStuck += 1
	If $searchGold <> $searchGold2 Or $searchElixir <> $searchElixir2 Then $iStuck = 0
	$searchGold2 = $searchGold
	$searchElixir2 = $searchElixir

	If $iStuck >= 5 Then
		checkMainScreen()
		If $Restart Then
			SetLog(getLocaleString("logCantLocateNextBtn"), $COLOR_RED)
			Pushmsg("OoSResources")
			$Is_ClientSyncError = True
			$iStuck = 0
			Return
		Else
			SetLog(getLocaleString("logStrangeProblem"), $COLOR_RED)
			$Is_ClientSyncError = True
			$iStuck = 0
			$Restart = True
			Return
		EndIf
	EndIf

	Local $THString = ""
	$searchTH = "-"
	If ($OptBullyMode = 1 And $SearchCount >= $ATBullyMode) Or $OptTrophyMode = 1 Or ($iCmbSearchMode <> $LB And ($iChkMeetTH[$DB] = 1 Or $iChkMeetTHO[$DB] = 1)) Or ($iCmbSearchMode <> $DB And ($iChkMeetTH[$LB] = 1 Or $iChkMeetTHO[$LB] = 1)) Then
		If ($iCmbSearchMode <> $LB And $iChkMeetTHO[$DB] = 1) Or ($iCmbSearchMode <> $DB And $iChkMeetTHO[$LB] = 1) Or $OptTrophyMode = 1 Then
			$searchTH = checkTownhall()
        Else
			$searchTH = checkTownhall()
		EndIf

		If SearchTownHallLoc() = False And $searchTH <> "-" Then
			$THLoc = getLocaleString("txtTHIn")
		ElseIf $searchTH <> "-" Then
			$THLoc = getLocaleString("txtTHOut")
			If $OptTrophyMode = 1 And $OptTrappedTH = 1 Then
              $searchDef = checkDefense()
            EndIf
		Else
			$THLoc = $searchTH
			$THx = 0
			$THy = 0
		EndIf
		$THString = getLocaleString("txtTHStr") & StringFormat("%2s", $searchTH) & ", " & $THLoc
	EndIf

	$SearchCount += 1 ; Counter for number of searches
	SetLog(StringFormat("%3s", $SearchCount) & getLocaleString("logG") & StringFormat("%7s", $searchGold) & getLocaleString("logE") & StringFormat("%7s", $searchElixir) & getLocaleString("logDE") & StringFormat("%5s", $searchDark) & getLocaleString("logT") & StringFormat("%2s", $searchTrophy) & $THString, $COLOR_BLACK, "Lucida Console", 7.5)
	If $OptTrophyMode = 1 And $OptTrappedTH = 1 Then
    	If $THLoc = getLocaleString("txtTHOut") Then
    		SetLog($searchDef)
   		 EndIf
    EndIf

EndFunc   ;==>GetResources
