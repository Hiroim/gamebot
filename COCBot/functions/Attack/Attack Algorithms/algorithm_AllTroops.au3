; #FUNCTION# ====================================================================================================================
; Name ..........: algorith_AllTroops
; Description ...: This file contens all functions to attack algorithm will all Troops , using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available
; Syntax ........: algorithm_AllTroops()
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: Didipe (May-2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func algorithm_AllTroops() ;Attack Algorithm for all existing troops
	$King = -1
	$Queen = -1
	$CC = -1
	For $i = 0 To UBound($atkTroops) - 1
		If $atkTroops[$i][0] = $eCastle Then
			$CC = $i
		ElseIf $atkTroops[$i][0] = $eKing Then
			$King = $i
		ElseIf $atkTroops[$i][0] = $eQueen Then
			$Queen = $i
		EndIf
	Next

	If _Sleep($iDelayalgorithm_AllTroops1) Then Return

	If $iMatchMode = $TS Or ($chkATH = 1 And SearchTownHallLoc()) Then
		Switch $AttackTHType
			Case 0
				algorithmTH()
				;_CaptureRegion()
				If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then AttackTHNormal() ;if 'no' use another attack mode.
			Case 1
				AttackTHNormal();Good for Masters
			Case 2
				AttackTHXtreme();Good for Champ
			Case 3
				AttackTHGbarch()
		EndSwitch
		If $zoomedin = True Then
			ZoomOut()
			$zoomedin = False
			$zCount = 0
			$sCount = 0
		EndIf
	EndIf

	;If $OptTrophyMode = 1 And SearchTownHallLoc() Then; Return ;Exit attacking if trophy hunting and not bullymode
	If $iMatchMode = $TS Then; Return ;Exit attacking if trophy hunting and not bullymode
		For $i = 1 To 30
			;_CaptureRegion()
			If _ColorCheck(_GetPixelColor($aWonOneStar[0],$aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then ExitLoop ;exit if not 'no star'
			_Sleep($iDelayalgorithm_AllTroops2)
		Next

		ClickP($aSurrenderButton, 1, 0, "#0030") ;Click Surrender
		If _Sleep($iDelayalgorithm_AllTroops3) Then Return
		ClickP($aConfirmSurrender, 1, 0, "#0031") ;Click Confirm
		Return
	EndIf

	If ($iChkRedArea[$iMatchMode]) Then
		SetLog(getLocaleString("logSmartAttackCalculating"), $COLOR_BLUE)
		Local $hTimer = TimerInit()
		_WinAPI_DeleteObject($hBitmapFirst)
		$hBitmapFirst = _CaptureRegion2()
		_GetRedArea()

		SetLog(getLocaleString("logSmartAttackCalculatedIn") & Round(TimerDiff($hTimer) / 1000, 2) & getLocaleString("logSmartAttackCalculatedInSec"))
		;SetLog("	[" & UBound($PixelTopLeft) & "] pixels TopLeft")
		;SetLog("	[" & UBound($PixelTopRight) & "] pixels TopRight")
		;SetLog("	[" & UBound($PixelBottomLeft) & "] pixels BottomLeft")
		;SetLog("	[" & UBound($PixelBottomRight) & "] pixels BottomRight")


		If ($iChkSmartAttack[$iMatchMode][0] = 1 Or $iChkSmartAttack[$iMatchMode][1] = 1 Or $iChkSmartAttack[$iMatchMode][2] = 1) Then
			SetLog(getLocaleString("logSmartAttackLocatingPumps"), $COLOR_BLUE)
			$hTimer = TimerInit()
			Global $PixelMine[0]
			Global $PixelElixir[0]
			Global $PixelDarkElixir[0]
			Global $PixelNearCollector[0]
			; If drop troop near gold mine
			If ($iChkSmartAttack[$iMatchMode][0] = 1) Then
				$PixelMine = GetLocationMine()
				If (IsArray($PixelMine)) Then
					_ArrayAdd($PixelNearCollector, $PixelMine)
				EndIf
			EndIf
			; If drop troop near elixir collector
			If ($iChkSmartAttack[$iMatchMode][1] = 1) Then
				$PixelElixir = GetLocationElixir()
				If (IsArray($PixelElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelElixir)
				EndIf
			EndIf
			; If drop troop near dark elixir drill
			If ($iChkSmartAttack[$iMatchMode][2] = 1) Then
				$PixelDarkElixir = GetLocationDarkElixir()
				If (IsArray($PixelDarkElixir)) Then
					_ArrayAdd($PixelNearCollector, $PixelDarkElixir)
				EndIf
			EndIf
			SetLog(getLocaleString("logSmartAttackLocatedIn") & Round(TimerDiff($hTimer) / 1000, 2) & getLocaleString("logSmartAttackLocatedInSec"))
			SetLog("[" & UBound($PixelMine) & getLocaleString("logSmartAttackLocatedMines"))
			SetLog("[" & UBound($PixelElixir) & getLocaleString("logSmartAttackLocatedCollectors"))
			SetLog("[" & UBound($PixelDarkElixir) & getLocaleString("logSmartAttackLocatedDrills"))
		EndIf

	EndIf

	;############################################# LSpell Attack ############################################################
	; DropLSpell()
	;########################################################################################################################
	Local $nbSides = 0
	Switch $iChkDeploySettings[$iMatchMode]
		Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog(getLocaleString("logNbSides1"), $COLOR_BLUE)
			$nbSides = 1
		Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog(getLocaleString("logNbSides2"), $COLOR_BLUE)
			$nbSides = 2
		Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog(getLocaleString("logNbSides3"), $COLOR_BLUE)
			$nbSides = 3
		Case 3 ;All sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			SetLog(getLocaleString("logNbSides4"), $COLOR_BLUE)
			$nbSides = 4
	EndSwitch
	If ($nbSides = 0) Then Return
	If _Sleep($iDelayalgorithm_AllTroops2) Then Return

	Local $listInfoDeploy[13][5] = [[$eGiant, $nbSides, 1, 1, 2] _
			, [$eBarb, $nbSides, 1, 2, 0] _
			, [$eWall, $nbSides, 1, 1, 1] _
			, [$eArch, $nbSides, 1, 2, 0] _
			, [$eBarb, $nbSides, 2, 2, 0] _
			, [$eGobl, $nbSides, 1, 2, 0] _
			, ["CC", 1, 1, 1, 1] _
			, [$eHogs, $nbSides, 1, 1, 1] _
			, [$eWiza, $nbSides, 1, 1, 0] _
			, [$eMini, $nbSides, 1, 1, 0] _
			, [$eArch, $nbSides, 2, 2, 0] _
			, [$eGobl, $nbSides, 2, 2, 0] _
			, ["HEROES", 1, 2, 1, 1] _
			]


	LaunchTroop2($listInfoDeploy, $CC, $King, $Queen)

	If _Sleep($iDelayalgorithm_AllTroops4) Then Return
	SetLog(getLocaleString("logDroopingLeft"), $COLOR_BLUE)
	For $x = 0 To 1
		PrepareAttack($iMatchMode, True) ;Check remaining quantities
		For $i = $eBarb To $eLava ; lauch all remaining troops
			;If $i = $eBarb Or $i = $eArch Then
			LauchTroop($i, $nbSides, 0, 1)
			CheckHeroesHealth()
			;Else
			;	 LauchTroop($i, $nbSides, 0, 1, 2)
			;EndIf
			If _Sleep($iDelayalgorithm_AllTroops5) Then Return
		Next
	Next

	;Activate KQ's power
	If ($checkKPower Or $checkQPower) And $iActivateKQCondition = "Manual" Then
		SetLog(getLocaleString("logCheckHeroPowerManual") & $delayActivateKQ / 1000 & getLocaleString("logCheckHeroPowerManual2"), $COLOR_BLUE)
		_Sleep($delayActivateKQ)
		If $checkKPower Then
			SetLog(getLocaleString("logCheckKPower"), $COLOR_BLUE)
			SelectDropTroop($King)
			$checkKPower = False
		EndIf
		If $checkQPower Then
			SetLog(getLocaleString("logCheckQPower"), $COLOR_BLUE)
			SelectDropTroop($Queen)
			$checkQPower = False
		EndIf
	EndIf

	SetLog(getLocaleString("logFinishedAttacking"))
EndFunc   ;==>algorithm_AllTroops

