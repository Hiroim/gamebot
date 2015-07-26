
; #FUNCTION# ====================================================================================================================
; Name ..........: LocateClanCastle
; Description ...: Locates Clan Castle manually (Temporary)
; Syntax ........: LocateClanCastle()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #69
; Modified ......: KnowJack (June 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func LocateClanCastle()
	Local $stext, $MsgBox, $iSilly = 0, $iStupid = 0, $sErrorText = "", $sInfo

	SetLog(getLocaleString("logLocateCC"), $COLOR_BLUE)

	If _GetPixelColor($aTopLeftClient[0], $aTopLeftClient[1], True) <> Hex($aTopLeftClient[2], 6) And _GetPixelColor($aTopRightClient[0], $aTopRightClient[1], True) <> Hex($aTopRightClient[2], 6) Then
		Zoomout()
		Collect()
	EndIf

	While 1
		ClickP($aTopLeftClient)
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Arial", 500)
		$stext =  $sErrorText & @CRLF & getLocaleString("msgboxLocateCC_msg",1) & @CRLF
		$MsgBox = _ExtMsgBox(0, getLocaleString("msgboxLocateCC_controls"), getLocaleString("msgboxLocateCC_title"), $stext, 15, $frmBot)
		If $MsgBox = 1 Then
			WinActivate($HWnD)
			$aCCPos[0] = FindPos()[0]
			$aCCPos[1] = FindPos()[1]
			If isInsideDiamond($aCCPos) = False Then
				$iStupid += 1
				Select
					Case $iStupid = 1
						$sErrorText = getLocaleString("txtStupidCase1CC") & @CRLF
						SetLog(getLocaleString("logStupidCase1"), $COLOR_RED)
						ContinueLoop
					Case $iStupid = 2
						$sErrorText = getLocaleString("txtStupidCase2") & @CRLF
						ContinueLoop
					Case $iStupid = 3
						$sErrorText = getLocaleString("txtStupicCase3") & $aCCPos[0] & "," & $aCCPos[1] & getLocaleString("txtStupicCase3_2",1) & @CRLF & @CRLF
						ContinueLoop
					Case $iStupid = 4
						$sErrorText = getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iStupid > 4
						SetLog(getLocaleString("txtOperatorErrCC")  & "(" & $aCCPos[0] & "," & $aCCPos[1] & ")", $COLOR_RED)
						ClickP($aTopLeftClient)
						Return False
					Case Else
						SetLog(getLocaleString("txtOperatorErrCC")  & "(" & $aCCPos[0] & "," & $aCCPos[1] & ")", $COLOR_RED)
						$aCCPos[0] = -1
						$aCCPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
			SetLog(getLocaleString("logPosCC")  & "(" & $aCCPos[0] & "," & $aCCPos[1] & ")", $COLOR_GREEN)
		Else
			SetLog(getLocaleString("logLocateCancelledCC") , $COLOR_BLUE)
			ClickP($aTopLeftClient)
			Return
		EndIf
		$sInfo = BuildingInfo(250, 520)
		If $sInfo[0] > 1 Or $sInfo[0] = "" Then
			If  StringInStr($sInfo[1], "clan") = 0 Then
				If $sInfo[0] = "" Then
					$sLocMsg = getLocaleString("txtLocMsgNothing") 
				Else
					$sLocMsg = $sInfo[1]
				EndIf
				$iSilly += 1
				Select
					Case $iSilly = 1
						$sErrorText = getLocaleString("txtSillyCaseCC")  & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 2
						$sErrorText = getLocaleString("txtSillyCase2")  & $sLocMsg & @CRLF
						ContinueLoop
					Case $iSilly = 3
						$sErrorText = getLocaleString("txtSillyCase3")  & $sLocMsg & getLocaleString("txtSillyCase3_2")  & @CRLF
						ContinueLoop
					Case $iSilly = 4
						$sErrorText = $sLocMsg & " ?!?!?!" & @CRLF & @CRLF & getLocaleString("txtStupidCase4",1) & @CRLF
						ContinueLoop
					Case $iSilly > 4
						SetLog(getLocaleString("txtSillyCase4CC") , $COLOR_RED)
						$aCCPos[0] = -1
						$aCCPos[1] = -1
						ClickP($aTopLeftClient)
						Return False
				EndSelect
			EndIf
		Else
			SetLog(getLocaleString("txtOperatorErrCC")  & "(" & $aCCPos[0] & "," & $aCCPos[1] & ")", $COLOR_RED)
			$aCCPos[0] = -1
			$aCCPos[1] = -1
			ClickP($aTopLeftClient)
			Return False
		EndIf
		ExitLoop
	WEnd

	ClickP($aTopLeftClient, 1, 200, "#0327")

EndFunc   ;==>LocateClanCastle
