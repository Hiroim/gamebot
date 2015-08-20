; #FUNCTION# ====================================================================================================================
; Name ..........: UpgradeBuilding.au3
; Description ...: Upgrades buildings if loot and builders are available
; Syntax ........: UpgradeBuilding(), UpgradeNormal($inum), UpgradeHero($inum)
; Parameters ....: $inum = array index [0-3]
; Return values .:
; Author ........: KnowJack (April-2015)
; Modified ......: KnowJack (June-2015) edited for V3.x Bot and SC updates
;                  Sardo 2015-08
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
;

Func UpgradeBuilding()
	Local $iz = 0
	Local $iUpgradeAction = -1
	Local $iAvailBldr, $iAvailGold, $iAvailElixir, $iAvailDark
	$itxtUpgrMinGold = Number($itxtUpgrMinGold)
	$itxtUpgrMinElixir = Number($itxtUpgrMinElixir)
	$itxtUpgrMinDark = Number($itxtUpgrMinDark)

	; check to see if anything is enabled before wasting time.
	For $iz = 0 To 11
		If $ichkbxUpgrade[$iz] = 1 Then
			$iUpgradeAction += 2 ^ ($iz + 1)
		EndIf
	Next
	If $iUpgradeAction < 0 Then Return False
	$iUpgradeAction = -1 ; Reset action

	Setlog(getLocaleString("logCheckingUpgrades"), $COLOR_BLUE)

	; Need to update village report function to skip statistics and extra messages not required using a bypass?
	VillageReport(True) ; Get current loot available after training troops and update free builder status
	$iAvailGold = Number($GoldCount)
	$iAvailElixir = Number($ElixirCount)
	$iAvailDark = Number($DarkCount)

	If $iSaveWallBldr = 1 Then  ; If save wall builder is enable, make sure to reserve builder if enabled
		$iAvailBldr = $FreeBuilder - $iSaveWallBldr
	Else
		$iAvailBldr = $FreeBuilder
	EndIf

	If $iAvailBldr <= 0 Then
		Setlog(getLocaleString("logUpgradeNoBuilder"), $COLOR_RED)
		Return False
	EndIf

	For $iz = 0 To 11
		If $ichkbxUpgrade[$iz] = 0 Then ContinueLoop ; Is the upgrade checkbox selected?
		If $aUpgrades[$iz][0] <= 0 Or $aUpgrades[$iz][1] <= 0 Or $aUpgrades[$iz][3] = "" Then ContinueLoop ; Now check to see if upgrade manually located?
		If $iAvailBldr <= 0 Then ; Check free builder in case of multiple upgrades
			Setlog(getLocaleString("logUpgradeNoBuilderFor") & $iz + 1 & getLocaleString("logUpgradeNoBuilderFor2"), $COLOR_RED)
			Return False
		EndIf
		SetLog(getLocaleString("logCheckingUpgrade") & $iz + 1, $COLOR_GREEN) ; Tell logfile which upgrade working on.
		If $debugSetlog = 1 Then SetLog("-Upgrade location =  " & "(" & $aUpgrades[$iz][0] & "," & $aUpgrades[$iz][1] & ")", $COLOR_PURPLE) ;Debug
		If _Sleep($iDelayUpgradeBuilding1) Then Return

		Switch $aUpgrades[$iz][3] ;Change action based on upgrade type!
			Case "Gold"
				If $iAvailGold < $aUpgrades[$iz][2] + $itxtUpgrMinGold Then ; Do we have enough Gold?
					SetLog(getLocaleString("logInsufficientGold") & $iz + 1 & getLocaleString("logUpgradeRequires") & $aUpgrades[$iz][2] & getLocaleString("logUpgradeRequires2") & $itxtUpgrMinGold & getLocaleString("logUpgradeRequires3"), $COLOR_BLUE)
					ContinueLoop
				EndIf
				If UpgradeNormal($iz) = False Then ContinueLoop
				$iUpgradeAction += 2 ^ ($iz + 1)
				Setlog(getLocaleString("logUpgradeGoldUsed") & $aUpgrades[$iz][2], $COLOR_BLUE)
				$iAvailGold -= $aUpgrades[$iz][2]
				$CostGoldUpgrades += $aUpgrades[$iz][2]
				$iAvailBldr -= 1
				ContinueLoop
			Case "Elixir"
				If $LabNeedsElix = 1 Then
					SetLog("Lab Needs Elixir", $COLOR_RED)
					ContinueLoop
				EndIf
				If $iAvailElixir < $aUpgrades[$iz][2] + $itxtUpgrMinElixir Then
					SetLog(getLocaleString("logInsufficientElixir") & $iz + 1 & getLocaleString("logUpgradeRequires") & $aUpgrades[$iz][2] & getLocaleString("logUpgradeRequires2") & $itxtUpgrMinElixir & getLocaleString("logUpgradeRequires3"), $COLOR_BLUE)
					ContinueLoop
				EndIf
				If UpgradeNormal($iz) = False Then ContinueLoop
				$iUpgradeAction += 2 ^ ($iz + 1)
				Setlog(getLocaleString("logUpgradeElixirUsed") & $aUpgrades[$iz][2], $COLOR_BLUE)
				$iAvailElixir -= $aUpgrades[$iz][2]
				$CostElixirUpgrades += $aUpgrades[$iz][2]
				$iAvailBldr -= 1
				ContinueLoop
			Case "Dark"
				If $LabNeedsDE = 1 Then
					SetLog("Lab Needs DE", $COLOR_RED)
					ContinueLoop
				EndIf
				If $iAvailDark  < $aUpgrades[$iz][2] + $itxtUpgrMinDark Then
					SetLog(getLocaleString("logInsufficientDarkE") & $iz + 1 & getLocaleString("logUpgradeRequires") & $aUpgrades[$iz][2] & getLocaleString("logUpgradeRequires2") & $itxtUpgrMinDark & getLocaleString("logUpgradeRequires3"), $COLOR_BLUE)
					ContinueLoop
				EndIf
				If UpgradeHero($iz) = False Then ContinueLoop
				$iUpgradeAction += 2 ^ ($iz + 1)
				Setlog(getLocaleString("logUpgradeDarkUsed") & $aUpgrades[$iz][2], $COLOR_BLUE)
				$iAvailDark  -= $aUpgrades[$iz][2]
				$CostDElixirUpgrades += $aUpgrades[$iz][2]
				$iAvailBldr -= 1
				ContinueLoop
			Case Else
				Setlog(getLocaleString("logUpgradeWeirdoFor") & $iz + 1, $COLOR_RED)
				ExitLoop
		EndSwitch
	Next
	If $iUpgradeAction <= 0 Then Setlog(getLocaleString("logUpgradeUnavailable"), $COLOR_GREEN)
	If _Sleep($iDelayUpgradeBuilding2) Then Return
	checkMainScreen(False)  ; Check for screen errors during function
	Return $iUpgradeAction

EndFunc   ;==>UpgradeBuilding
;
Func UpgradeNormal($inum)
	Click($aUpgrades[$inum][0], $aUpgrades[$inum][1],1,0,"#0296") ; Select the item to be upgrade
	If _Sleep($iDelayUpgradeNormal1) Then Return ; Wait for window to open
	If $aUpgrades[$inum][3] = "Gold" Then
		Local $offColors[3][3] = [[0xD6714B, 47, 37], [0xF0E850, 70, 0], [0xF4F8F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
		Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 650, 1, 1, Hex(0xF3F3F1, 6), $offColors, 30) ; first gray/white pixel of button
		If $debugSetlog = 1 And IsArray($ButtonPixel) Then
			Setlog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_PURPLE) ;Debug
			Setlog("Color #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 47, $ButtonPixel[1] + 37, True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 70, $ButtonPixel[1], True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 79, $ButtonPixel[1], True), $COLOR_PURPLE)
		EndIf
	Else ;Use elxir button
		Local $offColors[3][3] = [[0xBC5B31, 38, 32], [0xF84CF9, 72, 0], [0xF5F9F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel pink, 4th pixel edge of button
		Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 650, 1, 1, Hex(0xF4F7F2, 6), $offColors, 30) ; first gray/white pixel of button
		If $debugSetlog = 1 And IsArray($ButtonPixel) Then
			Setlog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_PURPLE) ;Debug
			Setlog("Color #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 38, $ButtonPixel[1] + 32, True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 72, $ButtonPixel[1], True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 79, $ButtonPixel[1], True), $COLOR_PURPLE)
		EndIf
	EndIf
	If IsArray($ButtonPixel) Then
		If _Sleep($iDelayUpgradeNormal2) Then Return
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20,1,0,"#0297") ; Click Upgrade Button
		If _Sleep($iDelayUpgradeNormal3) Then Return ; Wait for window to open
		If $debugSetlog = 1 Then DebugImageSave("UpgradeRegBtn1")
		If _ColorCheck(_GetPixelColor(685, 150, True), Hex(0xE1090E, 6), 20) Then ; Check if the building Upgrade window is open
			If _ColorCheck(_GetPixelColor(471, 478, True), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(471, 482), Hex(0xE70A12, 6), 20) And _
					_ColorCheck(_GetPixelColor(471, 486, True), Hex(0xE70A12, 6), 20) Then ; Check for Red Zero = means not enough loot!
				SetLog("Upgrade Fail #" & $inum + 1 & getLocaleString("logUpgradeFailNoLoot"), $COLOR_RED)
				ClickP($aAway, 2,0,"#0298") ;Click Away
				Return False
			Else
				Click(440, 480,1,0,"#0299") ; Click upgrade buttton
				If _Sleep($iDelayUpgradeNormal3) Then Return
				If $debugSetlog = 1 Then DebugImageSave("UpgradeRegBtn2")
				If _ColorCheck(_GetPixelColor(573, 256, True), Hex(0xE1090E, 6), 20) Then ; Redundant Safety Check if the use Gem window opens
					SetLog(getLocaleString("logUpgradeFail") & $inum + 1 & getLocaleString("logUpgradeFailNoLoot"), $COLOR_RED)
					ClickP($aAway, 2,0,"#0300") ;Click Away to close windows
					Return False
				EndIf
				SetLog(getLocaleString("logUpgradeNo") & $inum + 1 & getLocaleString("logUpgradeCompl"), $COLOR_GREEN)
				$aUpgrades[$inum][0] = -1 ;Reset $UpGrade position coordinate variable to blank to show its completed
				$aUpgrades[$inum][1] = -1
				$aUpgrades[$inum][3] = ""
				GUICtrlSetImage($picUpgradeStatus[$inum], $pIconLib, $eIcnGreenLight) ; Change GUI upgrade status to done
				GUICtrlSetState($chkbxUpgrade[$inum], $GUI_UNCHECKED) ; Change upgrade selection box to unchecked
				ClickP($aAway, 2,0,"#0301") ;Click Away to close windows
				If _Sleep($iDelayUpgradeNormal3) Then Return ; Wait for window to close
				Return True
			EndIf
		Else
			Setlog(getLocaleString("logUpgradeNo") & $inum + 1 & getLocaleString("logUpgradeWinOpenFail"), $COLOR_RED)
			ClickP($aAway, 2,0,"#0302") ;Click Away
		EndIf
	Else
		Setlog(getLocaleString("logUpgradeNo") & $inum + 1 & getLocaleString("logUpgradeErrFindingBtn"), $COLOR_RED)
		ClickP($aAway, 2,0,"#0303") ;Click Away
		Return False
	EndIf
EndFunc   ;==>UpgradeNormal
;
Func UpgradeHero($inum)
	Click($aUpgrades[$inum][0], $aUpgrades[$inum][1],1,0,"#0304") ; Select the item to be upgrade
	If _Sleep($iDelayUpgradeHero1) Then Return ; Wait for window to open
	Local $offColors[3][3] = [[0x9B4C28, 41, 23], [0x040009, 72, 0], [0xF5F9F2, 79, 0]] ; 2nd pixel brown hammer, 3rd pixel black, 4th pixel edge of button
	Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 620, 1, 1, Hex(0xF6F9F3, 6), $offColors, 30) ; first gray/white pixel of button
	If IsArray($ButtonPixel) Then
		If $debugSetlog = 1 And IsArray($ButtonPixel) Then
			Setlog("ButtonPixel = " & $ButtonPixel[0] & ", " & $ButtonPixel[1], $COLOR_PURPLE) ;Debug
			Setlog("Color #1: " & _GetPixelColor($ButtonPixel[0], $ButtonPixel[1], True) & ", #2: " & _GetPixelColor($ButtonPixel[0] + 41, $ButtonPixel[1] + 23, True) & ", #3: " & _GetPixelColor($ButtonPixel[0] + 72, $ButtonPixel[1], True) & ", #4: " & _GetPixelColor($ButtonPixel[0] + 79, $ButtonPixel[1], True), $COLOR_PURPLE)
		EndIf
		If _Sleep($iDelayUpgradeHero2) Then Return
		Click($ButtonPixel[0] + 20, $ButtonPixel[1] + 20,1,0,"#0305") ; Click Upgrade Button
		If _Sleep($iDelayUpgradeHero3) Then Return ; Wait for window to open
		If $debugSetlog = 1 Then DebugImageSave("UpgradeDarkBtn1")
		If _ColorCheck(_GetPixelColor(715, 150, True), Hex(0xE1090E, 6), 20) Then ; Check if the Hero Upgrade window is open
			If _ColorCheck(_GetPixelColor(557, 486, True), Hex(0xE70A12, 6), 20) And _ColorCheck(_GetPixelColor(557, 490), Hex(0xE70A12, 6), 20) And _
					_ColorCheck(_GetPixelColor(557, 494, True), Hex(0xE70A12, 6), 20) Then ; Check for Red Zero = means not enough loot!
				SetLog(getLocaleString("logUpgradeHeroFail") & $inum + 1 & getLocaleString("logUpgradeFailNoDE"), $COLOR_RED)
				ClickP($aAway, 2,0,"#0306") ;Click Away to close window
				Return False
			Else
				Click(540, 490,1,0,"#0307") ; Click upgrade buttton
				ClickP($aAway, 1,0,"#0308") ;Click Away to close windows
				If _Sleep($iDelayUpgradeHero1) Then Return
				If $debugSetlog = 1 Then DebugImageSave("UpgradeDarkBtn2")
				If _ColorCheck(_GetPixelColor(573, 256, True), Hex(0xE1090E, 6), 20) Then ; Redundant Safety Check if the use Gem window opens
					SetLog(getLocaleString("logUpgradeFail") & $inum + 1 & getLocaleString("logUpgradeFailNoDE"), $COLOR_RED)
					ClickP($aAway, 2,0,"#0309") ;Click Away to close windows
					Return False
				EndIf
				SetLog(getLocaleString("logUpgradeHero") & $inum + 1 & getLocaleString("logUpgradeCompl"), $COLOR_GREEN)
				$aUpgrades[$inum][0] = -1 ;Reset $UpGrade position coordinate variable to blank to show its completed
				$aUpgrades[$inum][1] = -1
				$aUpgrades[$inum][3] = ""
				GUICtrlSetImage($picUpgradeStatus[$inum],  $pIconLib, $eIcnGreenLight) ; Change GUI upgrade status to done
				GUICtrlSetState($chkbxUpgrade[$inum], $GUI_UNCHECKED) ; Change upgrade selection box to unchecked
				ClickP($aAway, 2,0,"#0310") ;Click Away to close windows
				If _Sleep($iDelayUpgradeHero2) Then Return ; Wait for window to close
				Return True
			EndIf
		Else
			Setlog(getLocaleString("logUpgradeNo") & $inum + 1 & getLocaleString("logUpgradeWinOpenFail"), $COLOR_RED)
			ClickP($aAway, 2,0,"#0311") ;Click Away to close windows
		EndIf
	Else
		Setlog(getLocaleString("logUpgradeNo") & $inum + 1 & getLocaleString("logUpgradeErrFindingBtn"), $COLOR_RED)
		ClickP($aAway, 2,0,"#0312") ;Click Away to close windows
		Return False
	EndIf
EndFunc   ;==>UpgradeHero
