
; #FUNCTION# ====================================================================================================================
; Name ..........: BoostBarracks
; Description ...:
; Syntax ........: BoostBarracks()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #11
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func BoostBarracks()
	If $bTrainEnabled = False Then Return

	If (GUICtrlRead($cmbBoostBarracks) > 0) And ($boostsEnabled = 1) Then
		If $barrackPos[0] = "" Then
			LocateBarrack()
			SaveConfig()
			If _Sleep(2000) Then Return
		EndIf
		While 1
			SetLog(getLocaleString("logBoostBarracks"), $COLOR_BLUE)


			ClickP($aTopLeftClient,1,0,"#0157")
			If _Sleep(1000) Then ExitLoop
			Click($barrackPos[0], $barrackPos[1],1,0,"#0158")
			If _Sleep(1000) Then ExitLoop
			_CaptureRegion()
			$Boost = _PixelSearch(410, 603, 493, 621, Hex(0xfffd70, 6), 10)
			If IsArray($Boost) Then
				If $DebugSetlog = 1 Then Setlog("Boost Button X|Y = "&$Boost[0]&"|"&$Boost[1]&", color = "&_GetPixelColor($Boost[0], $Boost[1]), $COLOR_PURPLE)
				Click($Boost[0], $Boost[1],1,0,"#0159")
				If _Sleep(1000) Then Return
				If _ColorCheck(_GetPixelColor(420, 375, True), Hex(0xD0E978, 6), 20) Then
					Click(420, 375,1,0,"#0160")
					If _Sleep(2000) Then Return
					If _ColorCheck(_GetPixelColor(586, 267, True), Hex(0xd80405, 6), 20) Then
						_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, 0)
						SetLog(getLocaleString("logBoostGemsNotEnough"), $COLOR_RED)
					Else
						_GUICtrlComboBox_SetCurSel($cmbBoostBarracks, (GUICtrlRead($cmbBoostBarracks) - 1))
						SetLog(getLocaleString("logBoostCompleted") & (GUICtrlRead($cmbBoostBarracks)), $COLOR_GREEN)
					EndIf
				Else
					SetLog(getLocaleString("logBoostAlreadyBarracks"), $COLOR_RED)
				EndIf
				If _Sleep(500) Then ExitLoop
				ClickP($aTopLeftClient,1,0,"#0161")
			Else
				SetLog(getLocaleString("logBoostNoButton"), $COLOR_RED)
				If _Sleep(1000) Then Return
			EndIf

			ExitLoop
		WEnd
	EndIf
	If _Sleep(500) Then Return
	checkMainScreen(False)  ; Check for errors during function

EndFunc   ;==>BoostBarracks


Func BoostSpellFactory()

	If $bTrainEnabled = False Then Return

	If (GUICtrlRead($cmbBoostSpellFactory) > 0) And ($boostsEnabled = 1) Then
		If $barrackPos[0] = "" Then
			LocateBarrack()
			SaveConfig()
			If _Sleep(2000) Then Return
		EndIf
		SetLog(getLocaleString("logBoostSpellFactory"), $COLOR_BLUE)
		If $SFPos[0] = -1 Then
			LocateSpellFactory()
			SaveConfig()
		Else
			Click($SFPos[0], $SFPos[1],1,0,"#0162")
			If _Sleep(600) Then Return
			_CaptureRegion()
			$Boost = _PixelSearch(382, 603, 440, 621, Hex(0xfffd70, 6), 10)
			If IsArray($Boost) Then
				If $DebugSetlog = 1 Then Setlog("Boost Button X|Y = "&$Boost[0]&"|"&$Boost[1]&", color = "&_GetPixelColor($Boost[0], $Boost[1]), $COLOR_PURPLE)
				Click($Boost[0], $Boost[1],1,0,"#0163")
				If _Sleep(1000) Then Return
				If _ColorCheck(_GetPixelColor(420, 375, True), Hex(0xD0E978, 6), 20) Then
					Click(420, 375,1,0,"#0164")
					If _Sleep(2000) Then Return
					If _ColorCheck(_GetPixelColor(586, 267, True), Hex(0xd80405, 6), 20) Then
						_GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory, 0)
						SetLog(getLocaleString("logBoostGemsNotEnough"), $COLOR_RED)
					Else
						_GUICtrlComboBox_SetCurSel($cmbBoostSpellFactory, (GUICtrlRead($cmbBoostSpellFactory) - 1))
						SetLog(getLocaleString("logBoostCompleted") & (GUICtrlRead($cmbBoostSpellFactory)), $COLOR_GREEN)
					EndIf
				Else
					SetLog(getLocaleString("logBoostAlreadyFactory"), $COLOR_RED)
				EndIf
				If _Sleep(500) Then Return
				ClickP($aTopLeftClient,1,0,"#0165")
			Else
				SetLog(getLocaleString("logBoostNoButtonSF"), $COLOR_RED)
				If _Sleep(1000) Then Return
			EndIf
		EndIf
	EndIf
	If _Sleep(500) Then Return
	checkMainScreen(False)  ; Check for errors during function

EndFunc   ;==>BoostSpellFactory
