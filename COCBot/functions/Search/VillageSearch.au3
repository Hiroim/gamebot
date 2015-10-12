
; #FUNCTION# ====================================================================================================================
; Name ..........: VillageSearch
; Description ...: Searches for a village that until meets conditions
; Syntax ........: VillageSearch()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #6
; Modified ......: kaganus (June 2015), Sardo 2015-07, kaganus (August 2015)
; Remarks .......:This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func VillageSearch() ;Control for searching a village that meets conditions
	$iSkipped = 0

	If $debugDeadBaseImage = 1 Then
		If DirGetSize(@ScriptDir & "\SkippedZombies\") = -1 Then DirCreate(@ScriptDir & "\SkippedZombies\")
		If DirGetSize(@ScriptDir & "\Zombies\") = -1 Then DirCreate(@ScriptDir & "\Zombies\")
		If DirGetSize(@ScriptDir & "\THOutside\") = -1 Then DirCreate(@ScriptDir & "\THOutside\")
		If DirGetSize(@ScriptDir & "\THOutside\skipped\") = -1 Then DirCreate(@ScriptDir & "\THOutside\skipped")
	EndIf

	If $Is_ClientSyncError = False Then
		For $i = 0 To $iModeCount - 1
			$iAimGold[$i] = $iMinGold[$i]
			$iAimElixir[$i] = $iMinElixir[$i]
			$iAimGoldPlusElixir[$i] = $iMinGoldPlusElixir[$i]
			$iAimDark[$i] = $iMinDark[$i]
			$iAimTrophy[$i] = $iMinTrophy[$i]
		Next
	EndIf

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title))

	If _Sleep($iDelayVillageSearch1) Then Return

	;	; Check Break Shield button again
	;	If _CheckPixel($aBreakShield, $bCapturePixel) Then
	;		ClickP($aBreakShield, 1, 0, "#0154");Click Okay To Break Shield
	;	EndIf

	For $x = 0 To $iModeCount - 1
		If $x = $iCmbSearchMode Or $iCmbSearchMode = 2 Then

			SetLog(_PadStringCenter(getLocaleString("logSearchingFor") & $sModeText[$x] & " ", 54, "="), $COLOR_BLUE)

			Local $MeetGxEtext = "", $MeetGorEtext = "", $MeetGplusEtext = "", $MeetDEtext = "", $MeetTrophytext = "", $MeetTHtext = "", $MeetTHOtext = "", $MeetWeakBasetext = "", $EnabledAftertext = ""

			SetLog(_PadStringCenter(getLocaleString("logSearchCond"), 50, "~"), $COLOR_BLUE)

			If $iCmbMeetGE[$x] = 0 Then $MeetGxEtext = getLocaleString("txtMeetGxE")
			If $iCmbMeetGE[$x] = 1 Then $MeetGorEtext = getLocaleString("txtMeetGorE")
			If $iCmbMeetGE[$x] = 2 Then $MeetGplusEtext = getLocaleString("txtMeetGplusE")
			If $iChkMeetDE[$x] = 1 Then $MeetDEtext = getLocaleString("txtMeetDE")
			If $iChkMeetTrophy[$x] = 1 Then $MeetTrophytext = getLocaleString("txtMeetTrophy")
			If $iChkMeetTH[$x] = 1 Then $MeetTHtext = getLocaleString("txtMeetTH") & $iMaxTH[$x] ;$icmbTH
			If $iChkMeetTHO[$x] = 1 Then $MeetTHOtext = getLocaleString("txtMeetTHO")
			If $iChkWeakBase[$x] = 1 Then $MeetWeakBasetext = getLocaleString("txtMeetWeakBase") & $iCmbWeakMortar[$x] & getLocaleString("txtMeetWeakBase2") & $iCmbWeakWizTower[$x] & ")"
			If $iChkEnableAfter[$x] = 1 Then $EnabledAftertext = getLocaleString("txtEnabledAfter") & $iEnableAfterCount[$x] & getLocaleString("txtEnabledAfter2")

			SetLog($MeetGxEtext & $MeetGorEtext & $MeetGplusEtext & $MeetDEtext & $MeetTrophytext & $MeetTHtext & $MeetTHOtext & $MeetWeakBasetext & $EnabledAftertext)

			If $iChkMeetOne[$x] = 1 Then SetLog(getLocaleString("txtMeetOne"))

			SetLog(_PadStringCenter(getLocaleString("logResourceCond"), 50, "~"), $COLOR_BLUE)
			If $iChkMeetTH[$x] = 1 Then $iAimTHtext[$x] = getLocaleString("txtAimTH") & StringFormat("%2s", $iMaxTH[$x]) ;$icmbTH
			If $iChkMeetTHO[$x] = 1 Then $iAimTHtext[$x] &= getLocaleString("txtAimTHO")


			If $iCmbMeetGE[$x] = 2 Then
				SetLog(getLocaleString("txtAimGplusE") & StringFormat("%7s", $iAimGoldPlusElixir[$x]) & getLocaleString("txtAimDE") & StringFormat("%5s", $iAimDark[$x]) & getLocaleString("txtAimTrophy") & StringFormat("%2s", $iAimTrophy[$x]) & $iAimTHtext[$x] & getLocaleString("txtAimMode") & $sModeText[$x], $COLOR_GREEN, "Lucida Console", 7.5)
			Else
				SetLog(getLocaleString("txtAimG") & StringFormat("%7s", $iAimGold[$x]) & getLocaleString("txtAimE") & StringFormat("%7s", $iAimElixir[$x]) & getLocaleString("txtAimDE") & StringFormat("%5s", $iAimDark[$x]) & getLocaleString("txtAimTrophy") & StringFormat("%2s", $iAimTrophy[$x]) & $iAimTHtext[$x] & getLocaleString("txtAimMode") & $sModeText[$x], $COLOR_GREEN, "Lucida Console", 7.5)
			EndIf

		EndIf
	Next

	If $OptBullyMode + $OptTrophyMode + $chkATH > 0 Then
		SetLog(_PadStringCenter(getLocaleString("logSearchCondAdv"), 50, "~"), $COLOR_BLUE)
		Local $YourTHText = "", $AttackTHTypeText = "", $chkATHText = "", $OptTrophyModeText = ""

		If $OptBullyMode = 1 Then
			For $i = 0 To 4
				If $YourTH = $i Then $YourTHText = getLocaleString("txtYourTH") & $THText[$i]
			Next
		EndIf

		If $OptBullyMode = 1 Then SetLog(getLocaleString("logTHBully") & $ATBullyMode & getLocaleString("logTHBully2") & $YourTHText)

		If $chkATH = 1 Then $chkATHText = getLocaleString("txtAttackTH")
		If $chkATH = 1 And $AttackTHType = 0 Then $AttackTHTypeText = getLocaleString("txtBarch")
		If $chkATH = 1 And $AttackTHType = 1 Then $AttackTHTypeText = getLocaleString("txtAttack1")
		If $chkATH = 1 And $AttackTHType = 2 Then $AttackTHTypeText = getLocaleString("txtAttack2")
		If $chkATH = 1 And $AttackTHType = 3 Then $AttackTHTypeText = getLocaleString("txtAttack3")
		If $chkATH = 1 And $AttackTHType = 4 Then $AttackTHTypeText = getLocaleString("txtAttack4")
		If $chkATH = 1 And $AttackTHType = 5 Then $AttackTHTypeText = getLocaleString("txtAttack5")
		If $OptTrophyMode = 1 Then $OptTrophyModeText = getLocaleString("txtOptTrophyMode") & $THaddtiles & getLocaleString("txtOptTrophyModeTiles")
		If $OptTrophyMode = 1 Or $chkATH = 1 Then SetLog($OptTrophyModeText & $chkATHText & $AttackTHTypeText)
	EndIf

	SetLog(_StringRepeat("=", 50), $COLOR_BLUE)

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNowDB, $GUI_SHOW)
		GUICtrlSetState($btnAttackNowLB, $GUI_SHOW)
		GUICtrlSetState($btnAttackNowTS, $GUI_SHOW)
		GUICtrlSetState($pic2arrow, $GUI_HIDE)
		GUICtrlSetState($lblVersion, $GUI_HIDE)
	EndIf

	If $Is_ClientSyncError = False Then
		$SearchCount = 0
	EndIf

	While 1

		; break every x searches when Snipe While Train mode is active
		If $isSnipeWhileTrain Then
			If $iSkipped >= GUICtrlRead($txtiSkipped) Then
				ClickP($aSurrenderButton, 1, 0, "#0099") ;Click Surrender
				$Restart = True
				$Is_ClientSyncError = False
				Return
			EndIf
		EndIf

		If $iVSDelay > 0 Then
			If _Sleep(1000 * $iVSDelay) Then Return
		EndIf

		Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
		Local $Time = @HOUR & "." & @MIN & "." & @SEC

		If $Restart = True Then Return ; exit func
		GetResources() ;Reads Resource Values
		If $Restart = True Then Return ; exit func
		$bBtnAttackNowPressed = False

		If Mod(($iSkipped + 1), 100) = 0 Then
			_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS memory
			If _Sleep($iDelayVillageSearch1) Then Return
			If CheckZoomOut() = False Then Return
		EndIf

		Local $noMatchTxt = ""
		Local $dbBase = False
		Local $match[$iModeCount]
		Local $isModeActive[$iModeCount]
		For $i = 0 To $iModeCount - 1
			$match[$i] = False
			$isModeActive[$i] = False
		Next

		If $iCmbSearchMode = 0 Then
			$isModeActive[$DB] = True
			$match[$DB] = CompareResources($DB)
		ElseIf $iCmbSearchMode = 1 Then
			$isModeActive[$LB] = True
			$match[$LB] = CompareResources($LB)
		ElseIf $iCmbSearchMode = 2 Then
			For $i = 0 To $iModeCount - 1
				$isModeActive[$i] = IsSearchModeActive($i)
				If $isModeActive[$i] Then
					$match[$i] = CompareResources($i)
				EndIf
			Next
		EndIf

		For $i = 0 To $iModeCount - 1
			If ($match[$i] And $iChkWeakBase[$i] = 1 And $iChkMeetOne[$i] <> 1) Or ($isModeActive[$i] And Not $match[$i] And $iChkWeakBase[$i] = 1 And $iChkMeetOne[$i] = 1) Then
				If IsWeakBase($i) Then
					$match[$i] = True
				Else
					$match[$i] = False
					$noMatchTxt &= getLocaleString("logNotWeakBase") & $sModeText[$i]
				EndIf
			EndIf
		Next

		If $match[$DB] Or $match[$LB] Then
			$dbBase = checkDeadBase()
		EndIf

		If $match[$DB] And $dbBase Then
			SetLog(_PadStringCenter(getLocaleString("logDBFound"), 50, "~"), $COLOR_GREEN)
			$iMatchMode = $DB
			If $debugDeadBaseImage = 1 Then
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\Zombies\" & $Date & " at " & $Time & ".jpg")
				_WinAPI_DeleteObject($hBitmap)
			EndIf
			ExitLoop
		ElseIf $match[$LB] And Not $dbBase Then
			SetLog(_PadStringCenter(getLocaleString("logLBFound"), 50, "~"), $COLOR_GREEN)
			$iMatchMode = $LB
			ExitLoop
		ElseIf $match[$LB] Or $match[$DB] Then
			If $OptBullyMode = 1 And ($SearchCount >= $ATBullyMode) Then
				If $SearchTHLResult = 1 Then
					SetLog(_PadStringCenter(getLocaleString("logTBFound"), 50, "~"), $COLOR_GREEN)
					$iMatchMode = $iTHBullyAttackMode
					ExitLoop
				EndIf
			EndIf
		EndIf

		If $OptTrophyMode = 1 Then ;Enables Triple Mode Settings ;---compare resources
			If SearchTownHallLoc() Then ; attack this base anyway because outside TH found to snipe
				If $skipBase = False Then
					SetLog(_PadStringCenter(getLocaleString("logTHOFound"), 50, "~"), $COLOR_GREEN)
					$iMatchMode = $TS
					If $debugDeadBaseImage = 1 and $OptTrappedTH = 1 Then
						_CaptureRegion()
						_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\THOutside\" & $Date & " at " & $Time & ".png")
						_WinAPI_DeleteObject($hBitmap)
					EndIf
					If $debugDeadBaseImage = 1 and $OptTrappedTH = 1 Then
						_CaptureTH()
						_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\THOutside\" & $Date & " at " & $Time & "_CaptureTH.png")
						_WinAPI_DeleteObject($hBitmap)
					EndIf
					ExitLoop
				Else
                	SetLog(getLocaleString("logTrapFound"), $COLOR_RED)
					If $debugDeadBaseImage = 1 and $OptTrappedTH = 1 Then
						_CaptureRegion()
						_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\THOutside\skipped\" & $Date & " at " & $Time & ".png")
						_WinAPI_DeleteObject($hBitmap)
					EndIf
					If $debugDeadBaseImage = 1 and $OptTrappedTH = 1 Then
						_CaptureTH()
						_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\THOutside\skipped\" & $Date & " at " & $Time & "_CaptureTH.png")
						_WinAPI_DeleteObject($hBitmap)
					EndIf
                EndIf
			EndIf
		EndIf

		If $match[$DB] And Not $dbBase Then
			$noMatchTxt &= getLocaleString("logNotA") & $sModeText[$DB] & getLocaleString("logNotA2")
			If $debugDeadBaseImage = 1 Then
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\SkippedZombies\" & $Date & " at " & $Time & ".jpg")
				_WinAPI_DeleteObject($hBitmap)
			EndIf
		ElseIf $match[$LB] And $dbBase Then
			$noMatchTxt &= getLocaleString("logNotA") & $sModeText[$LB] & getLocaleString("logNotA2")
		EndIf

		If $noMatchTxt <> "" Then
			SetLog(_PadStringCenter(" " & StringMid($noMatchTxt, 3) & " ", 50, "~"), $COLOR_PURPLE)
		EndIf

		If $iChkAttackNow = 1 Then
			If _Sleep(1000 * $iAttackNowDelay) Then Return ; add human reaction time on AttackNow button function
		EndIf

		If $bBtnAttackNowPressed = True Then ExitLoop

		Local $i = 0
		While $i < 100
			$i += 1
			If ( _ColorCheck(_GetPixelColor($NextBtn[0], $NextBtn[1], True), Hex($NextBtn[2], 6), $NextBtn[3])) Then
				ClickP($NextBtn, 1, 0, "#0155") ;Click Next
				ExitLoop
			Else
				If $debugsetlog = 1 Then SetLog("Wait to see Next Button... " & $i, $COLOR_PURPLE)
			EndIf
			If $i >= 99 Then ; if we can't find the next button or there is an error, then restart
				$Restart = True
				$Is_ClientSyncError = True
				$iStuck = 0
				$Restart = True
				If isProblemAffect(True) Then
					SetLog(getLocaleString("logCantLocateNextBtn"), $COLOR_RED)
					Pushmsg("OoSResources")
					Return
				Else
					SetLog(getLocaleString("logStrangeProblem"), $COLOR_RED)
					Return
				EndIf
		EndIf
			_Sleep($iDelayVillageSearch2)
		WEnd

		If _Sleep($iDelayVillageSearch3) Then Return

		If isGemOpen(True) = True Then
			Setlog(getLocaleString("logOutOfGoldSearching"), $COLOR_RED)
			Click(585, 252, 1, 0, "#0156") ; Click close gem window "X"
			If _Sleep($iDelayVillageSearch3) Then Return
			$OutOfGold = 1 ; Set flag for out of gold to search for attack
			ReturnHome(False, False)
			Return
		EndIf

		$iSkipped = $iSkipped + 1
		GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
	WEnd

	If $bBtnAttackNowPressed = True Then
		Setlog(_PadStringCenter(getLocaleString("logAttackNowPressed"), 50, "~"), $COLOR_GREEN)
	EndIf

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNowDB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowLB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowTS, $GUI_HIDE)
		GUICtrlSetState($pic2arrow, $GUI_SHOW)
		GUICtrlSetState($lblVersion, $GUI_SHOW)
		$bBtnAttackNowPressed = False
	EndIf

	If $AlertSearch = 1 Then
		TrayTip($sModeText[$iMatchMode] & getLocaleString("logMatchFound"), getLocaleString("logMatchG") & $searchGold & getLocaleString("logMatchE") & $searchElixir & getLocaleString("logMatchDE") & $searchDark & getLocaleString("logMatchT") & $searchTrophy, "", 0)
		If FileExists(@WindowsDir & "\media\Festival\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
		ElseIf FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
		EndIf
	EndIf

	SetLog(_PadStringCenter(getLocaleString("logSearchCompleted"), 50, "="), $COLOR_BLUE)
	PushMsg("MatchFound")

	; TH Detection Check Once Conditions
	If $OptBullyMode = 0 And $OptTrophyMode = 0 And $iChkMeetTH[$iMatchMode] = 0 And $iChkMeetTHO[$iMatchMode] = 0 And $chkATH = 1 Then
		$searchTH = checkTownhall()
		If SearchTownHallLoc() = False And $searchTH <> "-" Then
			SetLog(getLocaleString("logTHLocIn"))
		ElseIf $searchTH <> "-" Then
			SetLog(getLocaleString("logTHLocOut"))
		Else
			SetLog(getLocaleString("logTHLocErr"))
		EndIf
	EndIf

;~	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS Memory

;~	readConfig()
	_BlockInputEx(0, "", "", $HWnD) ; block all keyboard keys

	$Is_ClientSyncError = False

EndFunc   ;==>VillageSearch

Func IsSearchModeActive($pMode)
	If $iChkEnableAfter[$pMode] = 0 Then Return True
	If $SearchCount = $iEnableAfterCount[$pMode] Then SetLog(_PadStringCenter(" " & $sModeText[$pMode] & getLocaleString("logSearchModeActivated"), 50, "~"), $COLOR_BLUE)
	If $SearchCount >= $iEnableAfterCount[$pMode] Then Return True
	Return False
EndFunc   ;==>IsSearchModeActive

Func IsWeakBase($pMode)
	_WinAPI_DeleteObject($hBitmapFirst)
	$hBitmapFirst = _CaptureRegion2()
	Local $resultHere = DllCall($pFuncLib, "str", "CheckConditionForWeakBase", "ptr", $hBitmapFirst, "int", ($iCmbWeakMortar[$pMode] + 1), "int", ($iCmbWeakWizTower[$pMode] + 1), "int", 10)
	Return $resultHere[0] = "Y"
EndFunc   ;==>IsWeakBase
