; #FUNCTION# ====================================================================================================================
; Name ..........: LocateLab
; Description ...:
; Syntax ........: LocateLab()
; Parameters ....:
; Return values .: None
; Author ........: KnowJack (June 2015)
; Modified ......:
; Remarks .......:This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateLab()
	Local $stext, $MsgBox, $iStupid = 0, $iSilly = 0, $sErrorText = ""

	SetLog(getLocaleString("logLocateLab"), $COLOR_BLUE)

	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1], True) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1], True) <> Hex($aTopRightClient[2], 6) Then
		Zoomout()
		Collect()
	EndIf

	While 1
		ClickP($aTopLeftClient)
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Arial", 700)
		$stext =  $sErrorText & @CRLF& getLocaleString("msgboxLocateLab_msg",1) & @CRLF
		$MsgBox = _ExtMsgBox(0, getLocaleString("msgboxLocateLab_controls") , getLocaleString("msgboxLocateLab_title") , $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$aLabPos[0] = Int(FindPos()[0])
			$aLabPos[1] = Int(FindPos()[1])
			If isInsideDiamond($aLabPos) = False Then
				$iStupid += 1
				Select
					Case $iStupid = 1
						$sErrorText = getLocaleString("txtStupidCase1Lab") & @CRLF
						SetLog(getLocaleString("logStupidCase1"), $COLOR_RED)
						ContinueLoop
					Case $iStupid = 2
						$sErrorText = getLocaleString("txtStupidCase2") & @CRLF
						ContinueLoop
					Case $iStupid = 3
						$sErrorText = getLocaleString("txtStupidCase3") & $SFPos[0] & "," & $SFPos[1] & getLocaleString("txtStupicCase3_2",1) & @CRLF & @CRLF
						ContinueLoop
					Case $iStupid = 4
						$sErrorText = getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iStupid > 4
						SetLog(getLocaleString("txtOperatorErrCC") & "(" & $SFPos[0] & "," &$SFPos[1] & ")", $COLOR_RED)
						ClickP($aTopLeftClient)
						Return False
					Case Else
						SetLog(getLocaleString("txtOperatorErrCC") & "(" & $SFPos[0] & "," &$SFPos[1] & ")", $COLOR_RED)
						$aLabPos[0] = -1
						$aLabPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
		Else
			SetLog(getLocaleString("logLocateCancelledLab"), $COLOR_BLUE)
			ClickP($aTopLeftClient)
			Return
		EndIf
		$sLabInfo = BuildingInfo(242, 520)
		If $sLabInfo[0] > 1 Or $sLabInfo[0] = "" Then
			If  StringInStr($sLabInfo[1], "Lab") = 0 Then
				If $sLabInfo[0] = "" Then
					$sLocMsg = getLocaleString("txtLocMsgNothing")
				Else
					$sLocMsg = $sLabInfo[1]
				EndIf
				$iSilly += 1
				Select
					Case $iSilly = 1
						$sErrorText = getLocaleString("txtSillyCaseLab") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 2
						$sErrorText = getLocaleString("txtSillyCase2") & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 3
						$sErrorText = getLocaleString("txtSillyCase3") & $sLocMsg & getLocaleString("txtSillyCase3_2") & @CRLF
						ContinueLoop
					Case $iSilly = 4
						$sErrorText = $sLocMsg&" ?!?!?!" & @CRLF & @CRLF & getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iSilly > 4
						SetLog(getLocaleString("txtSillyCase4Lab"), $COLOR_RED)
						$aLabPos[0] = -1
						$aLabPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
		Else
			SetLog(getLocaleString("txtOperatorErrCC") & "(" & $aLabPos[0] & "," & $aLabPos[1] & ")", $COLOR_RED)
			$aLabPos[0] = -1
			$aLabPos[1] = -1
			ClickP($aTopLeftClient)
			Return False
		EndIf
		SetLog(getLocaleString("logPosLab") & "(" & $aLabPos[0] & "," & $aLabPos[1] & ")", $COLOR_GREEN)
		ExitLoop
	WEnd
	Clickp($aTopLeftClient, 2, 0, "#0207")

EndFunc   ;==>LocateLab
