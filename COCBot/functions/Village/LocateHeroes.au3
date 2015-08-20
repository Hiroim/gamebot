
; #FUNCTION# ====================================================================================================================
; Name ..........: LocateHeroes
; Description ...: Locates Heroes manually (Temporary)
; Syntax ........: LocateHeroes()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #69
; Modified ......: KnowJack (June 2015) Sardo 2015-08 z0mbie (Aug 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================


Func LocateKingAltar()
	Local $stext, $MsgBox, $iSilly = 0, $iStupid = 0, $sErrorText = "", $sInfo

	SetLog(getLocaleString("logLocateKing"), $COLOR_BLUE)

	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1], True) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1], True) <> Hex($aTopRightClient[2], 6) Then
		Zoomout()
		Collect()
	EndIf

	While 1
		ClickP($aTopLeftClient)
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Lucida Sans Unicode", 500)
		$MsgBox = _ExtMsgBox(0, getLocaleString("msgboxLocateHeroes_controls"), getLocaleString("msgboxLocateKing_title"), getLocaleString("msgboxLocateKing_msg",1), 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$KingPos[0] = FindPos()[0]
			$KingPos[1] = FindPos()[1]
			If isInsideDiamond($KingPos) = False Then
				$iStupid += 1
				Select
					Case $iStupid = 1
						$sErrorText = getLocaleString("txtStupidCase1King") & @CRLF
						SetLog(getLocaleString("logStupidCase1"), $COLOR_RED)
						ContinueLoop
					Case $iStupid = 2
						$sErrorText = getLocaleString("txtStupidCase2") & @CRLF
						ContinueLoop
					Case $iStupid = 3
						$sErrorText = getLocaleString("txtStupidCase3") & $KingPos[0] & "," & $KingPos[1] & getLocaleString("txtStupidCase3_2",1) & @CRLF & @CRLF
						ContinueLoop
					Case $iStupid = 4
						$sErrorText = getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iStupid > 4
						SetLog(getLocaleString("txtOperatorErrKing") & "(" & $KingPos[0] & "," & $KingPos[1] & ")", $COLOR_RED)
						ClickP($aTopLeftClient)
						Return False
					Case Else
						SetLog(getLocaleString("txtOperatorErrKing") & "(" & $KingPos[0] & "," & $KingPos[1] & ")", $COLOR_RED)
						$KingPos[0] = -1
						$KingPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
			SetLog(getLocaleString("logPosKing") & "(" & $KingPos[0] & "," & $KingPos[1] & ")", $COLOR_GREEN)
		Else
			SetLog(getLocaleString("logLocateCancelledKing"), $COLOR_BLUE)
			ClickP($aTopLeftClient)
			Return
		EndIf
		$sInfo = BuildingInfo(242, 520)
		If $sInfo[0] > 1 Or $sInfo[0] = "" Then
			If  (StringInStr($sInfo[1], "Bar") = 0) And (StringInStr($sInfo[1], "King") = 0) Then
				If $sInfo[0] = "" Then
					$sLocMsg = getLocaleString("txtLocMsgNothing")
				Else
					$sLocMsg = $sInfo[1]
				EndIf
				$iSilly += 1
				Select
					Case $iSilly = 1
						$sErrorText = getLocaleString("txtSillyCaseKing") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 2
						$sErrorText = getLocaleString("txtSillyCase2") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 3
						$sErrorText = getLocaleString("txtSillyCase3") & $sLocMsg & getLocaleString("txtSillyCase3_2") & @CRLF
						ContinueLoop
					Case $iSilly = 4
						$sErrorText = $sLocMsg & " ?!?!?!" & @CRLF & @CRLF & getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iSilly > 4
						SetLog(getLocaleString("txtSillyCase4King"), $COLOR_RED)
						$KingPos[0] = -1
						$KingPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
		Else
			SetLog(getLocaleString("txtOperatorErrKing") & "(" & $KingPos[0] & "," & $KingPos[1] & ")", $COLOR_RED)
			$KingPos[0] = -1
			$KingPos[1] = -1
			ClickP($aTopLeftClient)
			Return False
		EndIf
		ExitLoop
	WEnd
	
	ClickP($aTopLeftClient, 1, 200, "#0327")
	If _Sleep(1000) Then Return		
	
EndFunc   ;==>LocateKingAltar

Func LocateQueenAltar()
	Local $stext, $MsgBox, $iSilly = 0, $iStupid = 0, $sErrorText = "", $sInfo

	SetLog(getLocaleString("logLocateQueen"), $COLOR_BLUE)

	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1], True) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1], True) <> Hex($aTopRightClient[2], 6) Then
		Zoomout()
		Collect()
	EndIf

	While 1
		ClickP($aTopLeftClient)
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Lucida Sans Unicode", 500)
		$MsgBox = _ExtMsgBox(0, getLocaleString("msgboxLocateHeroes_controls"), getLocaleString("msgboxLocateQueen_title"), getLocaleString("msgboxLocateQueen_msg",1), 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$QueenPos[0] = FindPos()[0]
			$QueenPos[1] = FindPos()[1]
			If isInsideDiamond($QueenPos) = False Then
				$iStupid += 1
				Select
					Case $iStupid = 1
						$sErrorText = getLocaleString("txtStupidCase1Queen") & @CRLF
						SetLog(getLocaleString("logStupidCase1"), $COLOR_RED)
						ContinueLoop
					Case $iStupid = 2
						$sErrorText = getLocaleString("txtStupidCase2") & @CRLF
						ContinueLoop
					Case $iStupid = 3
						$sErrorText = getLocaleString("txtStupidCase3") & $QueenPos[0] & "," & $QueenPos[1] & getLocaleString("txtStupidCase3_2",1) & @CRLF & @CRLF
						ContinueLoop
					Case $iStupid = 4
						$sErrorText = getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iStupid > 4
						SetLog(getLocaleString("txtOperatorErrQueen") & "(" & $QueenPos[0] & "," & $QueenPos[1] & ")", $COLOR_RED)
						ClickP($aTopLeftClient)
						Return False
					Case Else
						SetLog(getLocaleString("txtOperatorErrQueen") & "(" & $QueenPos[0] & "," & $QueenPos[1] & ")", $COLOR_RED)
						$QueenPos[0] = -1
						$QueenPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
			SetLog(getLocaleString("logPosQueen") & "(" & $QueenPos[0] & "," & $QueenPos[1] & ")", $COLOR_GREEN)
		Else
			SetLog(getLocaleString("logLocateCancelledQueen"), $COLOR_BLUE)
			ClickP($aTopLeftClient)
			Return
		EndIf
		$sInfo = BuildingInfo(242, 520)
		If $sInfo[0] > 1 Or $sInfo[0] = "" Then
			If  StringInStr($sInfo[1], "Quee") = 0 Then
				If $sInfo[0] = "" Then
					$sLocMsg = getLocaleString("txtLocMsgNothing")
				Else
					$sLocMsg = $sInfo[1]
				EndIf
				$iSilly += 1
				Select
					Case $iSilly = 1
						$sErrorText = getLocaleString("txtSillyCaseQueen") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 2
						$sErrorText = getLocaleString("txtSillyCase2") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 3
						$sErrorText = getLocaleString("txtSillyCase3") & $sLocMsg & getLocaleString("txtSillyCase3_2") & @CRLF
						ContinueLoop
					Case $iSilly = 4
						$sErrorText = $sLocMsg & " ?!?!?!" & @CRLF & @CRLF & getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iSilly > 4
						SetLog(getLocaleString("txtSillyCase4Queen"), $COLOR_RED)
						$QueenPos[0] = -1
						$QueenPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
		Else
			SetLog(getLocaleString("txtOperatorErrQueen") & "(" & $QueenPos[0] & "," & $QueenPos[1] & ")", $COLOR_RED)
			$QueenPos[0] = -1
			$QueenPos[1] = -1
			ClickP($aTopLeftClient)
			Return False
		EndIf
		ExitLoop
	WEnd

	ClickP($aTopLeftClient, 1, 200, "#0327")
	If _Sleep(1000) Then Return
	
EndFunc   ;==>LocateQueenAltar