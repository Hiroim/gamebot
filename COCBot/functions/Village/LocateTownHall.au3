
; #FUNCTION# ====================================================================================================================
; Name ..........: LocateTownHall
; Description ...: Locates TownHall for Rearm Function
; Syntax ........: LocateTownHall()
; Parameters ....:
; Return values .: None
; Author ........:
; Modified ......: KnowJack (July 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateTownHall($bLocationOnly = False)

	Local $stext, $MsgBox, $Success, $sLocMsg
	Local	$iStupid = 0, $iSilly = 0, $sErrorText = ""

	SetLog(getLocaleString("logLocateTH"), $COLOR_BLUE)

	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1], True) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1], True) <> Hex($aTopRightClient[2], 6) Then
		Zoomout()
		Collect()
	EndIf

	While 1
		ClickP($aTopLeftClient)
		_ExtMsgBoxSet(1 + 64, 1, 0x004080, 0xFFFF00, 12, "Arial", 700)
		$stext = $sErrorText & @CRLF & getLocaleString("msgboxLocateTH_msg",1) & @CRLF
		$MsgBox = _ExtMsgBox(0, getLocaleString("msgboxLocateTH_controls"), getLocaleString("msgboxLocateTH_title"), $stext, 30, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$TownHallPos[0] = FindPos()[0]
			$TownHallPos[1] = FindPos()[1]
			If _Sleep(1000) Then Return
			If isInsideDiamond($TownHallPos) = False Then
				$iStupid += 1
				Select
					Case $iStupid = 1
						$sErrorText = getLocaleString("txtStupidCase1TH") & @CRLF
						SetLog(getLocaleString("logStupidCase1"), $COLOR_RED)
						ContinueLoop
					Case $iStupid = 2
						$sErrorText = getLocaleString("txtStupidCase2") & @CRLF
						ContinueLoop
					Case $iStupid = 3
						$sErrorText = getLocaleString("txtStupidCase3") & $TownHallPos[0] & "," & $TownHallPos[1] & getLocaleString("txtStupidCase3_2",1) & @CRLF
						ContinueLoop
					Case $iStupid = 4
						$sErrorText = getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iStupid > 4
						SetLog(getLocaleString("txtOperatorErrTH") & "(" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_RED)
						$TownHallPos[0] = -1
						$TownHallPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
			SetLog(getLocaleString("logPosTH") & "(" & $TownHallPos[0] & "," & $TownHallPos[1] & ")", $COLOR_GREEN)
		Else
			SetLog(getLocaleString("logLocateCancelledTH"), $COLOR_BLUE)
			ClickP($aTopLeftClient)
			Return
		EndIf
		If $bLocationOnly = False Then
			$Success = GetTownHallLevel() ; Get/Save the users updated TH level
			$iSilly += 1
			If IsArray($Success) Or $Success = False Then
				If $Success = False Then
					$sLocMsg = getLocaleString("txtLocMsgNothing")
				Else
					$sLocMsg = $Success[1]
				EndIf
				Select
					Case $iSilly = 1
						$sErrorText = getLocaleString("txtSillyCaseTH") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 2
						$sErrorText = getLocaleString("txtSillyCase2") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 3
						$sErrorText = getLocaleString("txtSillyCase3") & $sLocMsg & getLocaleString("txtSillyCase3_2") & @CRLF
						ContinueLoop
					Case $iSilly = 4
						$sErrorText = $sLocMsg&" ?!?!?!" & @CRLF & @CRLF & getLocaleString("txtStupidCase4",1)& @CRLF
						ContinueLoop
					Case $iSilly > 4
						SetLog(getLocaleString("txtSillyCase4TH"), $COLOR_RED)
						$TownHallPos[0] = -1
						$TownHallPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			Else
				SetLog(getLocaleString("logLocateTHSuccess"), $COLOR_RED)
			EndIf
		EndIf
		ExitLoop
	WEnd

	ClickP($aTopLeftClient, 1, 50, "#0209")

EndFunc   ;==>LocateTownHall
