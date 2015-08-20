; #FUNCTION# ====================================================================================================================
; Name ..........: UpgradeWall.au3
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........:
; Modified ......: Sardo 2015-08
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func UpgradeWall()

	If GUICtrlRead($chkWalls) <> $GUI_CHECKED Then Return
	
	SetLog(getLocaleString("logWallCheckUpgrade"), $COLOR_BLUE)
	
	If $NoMoreWalls = 1 Then
		SetLog(getLocaleString("logWallNoMore"), $COLOR_RED)
		Return
	EndIf
	
	
	; Need to update village report function to skip statistics and extra messages not required using a bypass?
	VillageReport(True) ; Get current loot available after training troops and update free builder status
	$iAvailGold = Number($GoldCount)
	$iAvailElixir = Number($ElixirCount)
	$iAvailDark = Number($DarkCount)
	
	Local $GoldForBuilding, $ElixForBuilding

	If $FreeBuilder <= 0 Then
		SetLog(getLocaleString("logWallNoBuilderAvailable"), $COLOR_RED)
		Return False
	EndIf
	
	
		If $FreeBuilder > $iSaveWallBldr Then
			$GoldForBuilding = 0
			$ElixForBuilding = 0
			
			For $iz = 0 To 11				
				If $ichkbxUpgrade[$iz] = 0 Then ContinueLoop ; Is the upgrade checkbox selected?
				If $aUpgrades[$iz][0] <= 0 Or $aUpgrades[$iz][1] <= 0 Or $aUpgrades[$iz][3] = "" Then ContinueLoop ; Now check to see if upgrade manually located?				
				If _Sleep(200) Then Return				
				
				Switch $aUpgrades[$iz][3] ;Change action based on upgrade type!
					Case "Gold"
						If $aUpgrades[$iz][2] + $itxtUpgrMinGold > $GoldForBuilding Then $GoldForBuilding = $aUpgrades[$iz][2] + $itxtUpgrMinGold
					Case "Elixir"
						If $aUpgrades[$iz][2] + $itxtUpgrMinElixir > $ElixForBuilding Then $ElixForBuilding = $aUpgrades[$iz][2] + $itxtUpgrMinElixir							
					Case "Dark"						
						ContinueLoop					
				EndSwitch
			Next
			
			ClickP($aAway,1,0,"#0313") ; click away
			$itxtWallMinGold = GUICtrlRead($txtWallMinGold)
			$itxtWallMinElixir = GUICtrlRead($txtWallMinElixir)

			Local $MinWallGold = Number($GoldCount - $Wallcost) > ($GoldForBuilding + Number($itxtWallMinGold)) ; Check if enough Gold
			Local $MinWallElixir = Number($ElixirCount - $Wallcost) > ($ElixForBuilding + Number($itxtWallMinElixir)) ; Check if enough Elixir

			If GUICtrlRead($UseGold) = $GUI_CHECKED Then
				$iUseStorage = 1
			ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
				$iUseStorage = 2
			ElseIf GUICtrlRead($UseElixirGold) = $GUI_CHECKED Then
				$iUseStorage = 3
			EndIf

			Switch $iUseStorage
				Case 1
					If $MinWallGold Then
						SetLog(getLocaleString("logWallUpgradeUseGold"), $COLOR_GREEN)
						If CheckWall() Then UpgradeWallGold()
					Else
						If $GoldForBuilding > 0 Then
							SetLog(getLocaleString("logWallUpgradeGoldSave"), $COLOR_RED)
						Else
							SetLog(getLocaleString("logWallUpgradeGoldBelowMin"), $COLOR_RED)
						EndIf	
					EndIf
				Case 2
					If $MinWallElixir Then
						If $LabNeedsElix = 1 Then
							SetLog(getLocaleString("logWallUpgradeElixirSave"), $COLOR_RED)
							Return False
						EndIf
						SetLog(getLocaleString("logWallUpgradeUseElixir"), $COLOR_GREEN)
						If CheckWall() Then UpgradeWallElixir()
					Else
						If $ElixForBuilding > 0 Then
							SetLog(getLocaleString("logWallUpgradeElixirSaveBuilding"), $COLOR_RED)
						Else
							SetLog(getLocaleString("logWallUpgradeElixirBelowMin"), $COLOR_RED)
						EndIf	
					EndIf
				Case 3
					If $MinWallElixir Then
						If $LabNeedsElix = 1 Then
							SetLog(getLocaleString("logWallUpgradeElixirSave"), $COLOR_RED)
							Return False
						EndIf
						SetLog(getLocaleString("logWallUpgradeUseElixir"), $COLOR_GREEN)
						If CheckWall() Then UpgradeWallElixir()
					Else
						If $ElixForBuilding > 0 Then
							SetLog(getLocaleString("logWallUpgradeElixirSaveBuilding"), $COLOR_RED)
						Else
							SetLog(getLocaleString("logWallUpgradeElixirBelowMin"), $COLOR_RED)
						EndIf	
					EndIf
					If $MinWallGold Then
						SetLog(getLocaleString("logWallUpgradeUseGold"), $COLOR_GREEN)
						If CheckWall() Then UpgradeWallGold()
					Else
						If $GoldForBuilding > 0 Then
							SetLog(getLocaleString("logWallUpgradeGoldSave"), $COLOR_RED)
						Else
							SetLog(getLocaleString("logWallUpgradeGoldBelowMin"), $COLOR_RED)
						EndIf	
					EndIf
			EndSwitch
			ClickP($aAway,1,0,"#0313") ; click away
			If _Sleep(100) Then Return
			Click(820, 40,1,0,"#0315") ; Close Builder/Shop if open by accident
			If _Sleep(100) Then Return
			
		ElseIf $FreeBuilder > 0 Then
			ClickP($aTopLeftClient,1,0,"#0313") ; click away
			$itxtWallMinGold = GUICtrlRead($txtWallMinGold)
			$itxtWallMinElixir = GUICtrlRead($txtWallMinElixir)

			Local $MinWallGold = Number($GoldCount - $Wallcost) > Number($itxtWallMinGold) ; Check if enough Gold
			Local $MinWallElixir = Number($ElixirCount - $Wallcost) > Number($itxtWallMinElixir) ; Check if enough Elixir

			If GUICtrlRead($UseGold) = $GUI_CHECKED Then
				$iUseStorage = 1
			ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
				$iUseStorage = 2
			ElseIf GUICtrlRead($UseElixirGold) = $GUI_CHECKED Then
				$iUseStorage = 3
			EndIf

			Switch $iUseStorage
				Case 1
					If $MinWallGold Then
						SetLog(getLocaleString("logWallUpgradeUseGold"), $COLOR_GREEN)
						If CheckWall() Then UpgradeWallGold()
					Else
						SetLog(getLocaleString("logWallUpgradeGoldBelowMin"), $COLOR_RED)
					EndIf
				Case 2
					If $MinWallElixir Then
						If $LabNeedsElix = 1 Then
							SetLog(getLocaleString("logWallUpgradeElixirSave"), $COLOR_RED)
							Return False
						EndIf
						SetLog(getLocaleString("logWallUpgradeUseElixir"), $COLOR_GREEN)
						If CheckWall() Then UpgradeWallElixir()
					Else
						SetLog(getLocaleString("logWallUpgradeElixirBelowMin"), $COLOR_RED)
					EndIf
				Case 3
					If $MinWallElixir Then
						If $LabNeedsElix = 1 Then
							SetLog(getLocaleString("logWallUpgradeElixirSave"), $COLOR_RED)
							Return False
						EndIf
						SetLog(getLocaleString("logWallUpgradeUseElixir"), $COLOR_GREEN)
						If CheckWall() Then UpgradeWallElixir()
					Else
						If $GoldForBuilding > 0 Then
						SetLog(getLocaleString("logWallUpgradeElixirBelowMinTryGold"), $COLOR_RED)
						Else
							SetLog(getLocaleString("logWallUpgradeElixirBelowMin"), $COLOR_RED)
						EndIf
					EndIf
						If $MinWallGold Then
						SetLog(getLocaleString("logWallUpgradeUseGold"), $COLOR_GREEN)
							If CheckWall() Then UpgradeWallGold()
						Else
						If $GoldForBuilding > 0 Then
							SetLog(getLocaleString("logWallUpgradeGoldSave"), $COLOR_RED)
						Else
							SetLog(getLocaleString("logWallUpgradeGoldBelowMin"), $COLOR_RED)
						EndIf
					EndIf
			EndSwitch

			If _Sleep(100) Then Return
			ClickP($aAway,1,0,"#0314") ; click away
			If _Sleep(100) Then Return
			Click(820, 40,1,0,"#0315") ; Close Builder/Shop if open by accident
			If _Sleep(100) Then Return
		Else
			SetLog(getLocaleString("logWallNoFreeBuilder"), $COLOR_RED)
		EndIf
	If _Sleep($iDelayUpgradeWall1) Then Return
	checkMainScreen(False) ; Check for errors during function

EndFunc   ;==>UpgradeWall

Func UpgradeWallGold()

	;Click($WallxLOC, $WallyLOC)
	If _Sleep($iDelayUpgradeWallGold1) Then Return

	Local $offColors[3][3] = [[0xD6714B, 47, 37], [0xF0E850, 70, 0], [0xF4F8F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
	Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 650, 1, 1, Hex(0xF3F3F1, 6), $offColors, 30) ; first gray/white pixel of button
	If IsArray($ButtonPixel) Then
		If $debugSetLog = 1 Then
			SetLog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_PURPLE) ;Debug
			SetLog("Color #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 47, $ButtonPixel[1] + 37, True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 70, $ButtonPixel[1], True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 79, $ButtonPixel[1], True), $COLOR_PURPLE)
		EndIf
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20,1,0,"#0316") ; Click Upgrade Gold Button
		If _Sleep($iDelayUpgradeWallGold2) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(685, 150), Hex(0xE1090E, 6), 20) Then ; wall upgrade window red x
			If isNoUpgradeLoot(False) = True Then
				SetLog(getLocaleString("logWallStoppedDueNoLoot"), $COLOR_RED)
				Return False
			Endif
			Click(440, 480,1,0,"#0317")
			If _Sleep($iDelayUpgradeWallGold3) Then Return
			SetLog(getLocaleString("logWallUpgradeComplete"), $COLOR_GREEN)
			PushMsg("UpgradeWithGold")
			$wallgoldmake = $wallgoldmake + 1
			GUICtrlSetData($lblWallgoldmake, $wallgoldmake)
			Return True
		EndIf
	Else
		SetLog(getLocaleString("logWallUpgradeNoGoldBtn"), $COLOR_RED)
		Pushmsg("NowUpgradeGoldButton")
		Return False
	EndIf

EndFunc   ;==>UpgradeWallGold

Func UpgradeWallElixir()

	;Click($WallxLOC, $WallyLOC)
	If _Sleep($iDelayUpgradeWallElixir1) Then Return

	Local $offColors[3][3] = [[0xBC5B31, 38, 32], [0xF84CF9, 72, 0], [0xF5F9F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
	Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 650, 1, 1, Hex(0xF4F7F2, 6), $offColors, 30) ; first gray/white pixel of button
	If IsArray($ButtonPixel) Then
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20,1,0,"#0322") ; Click Upgrade Elixir Button
		If _Sleep($iDelayUpgradeWallElixir2) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(685, 150), Hex(0xE1090E, 6), 20) Then
			If isNoUpgradeLoot(False) = True Then
				SetLog(getLocaleString("logWallSkippedDueInsufficientLoot"), $COLOR_RED)
				Return False
			Endif
			Click(440, 480,1,0,"#0318")
			If _Sleep($iDelayUpgradeWallElixir3) Then Return
			SetLog(getLocaleString("logWallUpgradeComplete"), $COLOR_GREEN)
			PushMsg("UpgradeWithElixir")
			$wallelixirmake = $wallelixirmake + 1
			GUICtrlSetData($lblWallelixirmake, $wallelixirmake)
			Return True
		EndIf
	Else
		SetLog(getLocaleString("logWallUpgradeNoElixirBtn"), $COLOR_RED)
		Pushmsg("NowUpgradeElixirButton")
		Return False
	EndIf

EndFunc   ;==>UpgradeWallElixir
