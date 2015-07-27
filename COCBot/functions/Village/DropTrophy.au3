
; #FUNCTION# ====================================================================================================================
; Name ..........: DropTrophy
; Description ...: Gets trophy count of village and compares to max trophy input. Will drop a troop and return home with no screenshot or gold wait.
; Syntax ........: DropTrophy()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #666
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func DropTrophy()
	Local $TrophyCount = getTrophyMainScreen($aTrophies[0], $aTrophies[1])
	If $DebugSetlog = 1 Then SetLog("Trophy Count : " & $TrophyCount, $COLOR_PURPLE)

	Local $iCount, $RandomEdge, $RandomXY
	Local $itxtMaxTrophyNeedCheck

	$itxtMaxTrophyNeedCheck = $itxtMaxTrophy ; $itxtMaxTrophy = 1800

	If Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck) Then
		If $iChkTrophyAtkDead = 1 Then
			If ($CurCamp >= ($TotalCamp * 70 / 100)) Then

				While Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck)
					$TrophyCount = getTrophyMainScreen($aTrophies[0], $aTrophies[1])
					SetLog(getLocaleString("logTrophyCount") & $TrophyCount, $COLOR_GREEN)
					If Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck) Then
						$itxtMaxTrophyNeedCheck = $itxtdropTrophy ; $itxtMinTrophy = 1650
						SetLog(getLocaleString("logDropTrophiesTo") & $itxtdropTrophy, $COLOR_BLUE)
						If _Sleep(2000) Then ExitLoop

						ZoomOut()
						PrepareSearch()

						If _Sleep(2000) Then ExitLoop
						$iCount = 0
						While getGoldVillageSearch(48, 68) = "" ; Loops until gold is readable
							If _Sleep(1000) Then ExitLoop (2)
							$iCount += 1
							If $iCount >= 35 Then ExitLoop (2) ; or Return
						WEnd
						SetLog(getLocaleString("logIdentifyTroops"), $COLOR_BLUE)
						PrepareAttack($DT) ; ==== Troops :checks for type, slot, and quantity ===
						$iAimGold[$DB] = $iMinGold[$DB]
						$iAimElixir[$DB] = $iMinElixir[$DB]
						$iAimGoldPlusElixir[$DB] = $iMinGoldPlusElixir[$DB]

						$searchGold = getGoldVillageSearch(48, 68)
						$searchElixir = getElixirVillageSearch(48, 68 + 28)
						$searchTrophy = getTrophyVillageSearch(48, 68 + 28 * 2 + 33)

						Local $G = (Number($searchGold) >= Number($iAimGold[$DB]))
						Local $E = (Number($searchElixir) >= Number($iAimElixir[$DB]))
						Local $GPE = ((Number($searchElixir) + Number($searchGold)) >= Number($iAimGoldPlusElixir[$DB]))
						If $G = True And $E = True And $GPE = True Then
							SetLog(getLocaleString("logFoundG") & _NumberFormat($searchGold) & getLocaleString("logFoundE") & _NumberFormat($searchElixir) & getLocaleString("logFoundT") & _NumberFormat($searchTrophy), $COLOR_BLACK, "Lucida Console")
							If checkDeadBase() Then
								; _BlockInputEx(0, "", "", $HWnD) ; block all keyboard keys
								SetLog(_PadStringCenter(getLocaleString("logDeadBaseFound"), 50, "~"), $COLOR_GREEN)
								Attack()
								ReturnHome($TakeLootSnapShot)
								$ReStart = True  ; Set restart flag after dead base attack to ensure troops are trained
								ExitLoop ; or Return, Will end function, no troops left to drop Trophies, will need to Train new Troops first
							EndIf
						EndIf


						If _Sleep(1500) Then Return

						If $iChkTrophyHeroes = 1 Then
							$King = -1
							$Queen = -1
							For $i = 0 To UBound($atkTroops) - 1
								If $atkTroops[$i][0] = $eKing Then
									$King = $i
								ElseIf $atkTroops[$i][0] = $eQueen Then
									$Queen = $i
								EndIf
							Next

							$RandomEdge = $Edges[Round(Random(0, 3))]
							$RandomXY = Round(Random(0, 4))
							If $DebugSetlog = 1 Then Setlog("Hero Loc = " & $RandomXY & ", X:Y= " & $RandomEdge[$RandomXY][0] & "|" & $RandomEdge[$RandomXY][1], $COLOR_PURPLE)
							If $King <> -1 Then
								SetLog(getLocaleString("logDeployKing"), $COLOR_BLUE)
								Click(GetXPosOfArmySlot($King, 68), 595, 1, 0, "#0177") ;Select King
								_Sleep(1000)
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0178") ;Drop King
								If _Sleep(1000) Then ExitLoop
								SetTrophyLoss()
								ReturnHome(False, False) ;Return home no screenshot
								If _Sleep(1000) Then ExitLoop
							EndIf
							If $King = -1 And $Queen <> -1 Then
								SetLog(getLocaleString("logDeployQueen"), $COLOR_BLUE)
								Click(GetXPosOfArmySlot($Queen, 68), 595, 1, 0, "#0179") ;Select Queen
								_Sleep(1000)
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0180") ;Drop Queen
								If _Sleep(1000) Then ExitLoop
								SetTrophyLoss()
								ReturnHome(False, False) ;Return home no screenshot
								If _Sleep(1000) Then ExitLoop
							EndIf
						EndIf
						If ($Queen = -1 And $King = -1) Or $iChkTrophyHeroes = 0 Then
							$RandomEdge = $Edges[Round(Random(0, 3))]
							$RandomXY = Round(Random(0, 4))
							If $DebugSetlog = 1 Then Setlog("Troop Loc = " & $RandomXY & ", X:Y= " & $RandomEdge[$RandomXY][0] & "|" & $RandomEdge[$RandomXY][1], $COLOR_PURPLE)
							Select
								Case $atkTroops[0][0] = $eBarb
									Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0181") ;Drop one troop
									$CurBarb += 1
									$ArmyComp -= 1
									SetLog(getLocaleString("logDeployBarb"), $COLOR_BLUE)
								Case $atkTroops[0][0] = $eArch
									Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0182") ;Drop one troop
									$CurArch += 1
									$ArmyComp -= 1
									SetLog(getLocaleString("logDeployArch"), $COLOR_BLUE)
								Case $atkTroops[0][0] = $eGiant
									Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0183") ;Drop one troop
									$CurGiant += 1
									$ArmyComp -= 5
									SetLog(getLocaleString("logDeployGiant"), $COLOR_BLUE)
								Case $atkTroops[0][0] = $eWall
									Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0184") ;Drop one troop
									$CurWall += 1
									$ArmyComp -= 2
									SetLog(getLocaleString("logDeployWB"), $COLOR_BLUE)
								Case $atkTroops[0][0] = $eGobl
									Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0185") ;Drop one troop
									$CurGobl += 1
									$ArmyComp -= 2
									SetLog(getLocaleString("logDeployGob"), $COLOR_BLUE)
								Case $atkTroops[0][0] = $eMini
									Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0186") ;Drop one troop
									$CurMini += 1
									$ArmyComp -= 2
									SetLog(getLocaleString("logDeployMini"), $COLOR_BLUE)
								Case Else
									$itxtMaxTrophy += 50
									SetLog(getLocaleString("logDontHaveLowTierTroops"), $COLOR_BLUE) ; preventing of deploying Tier 2/3 expensive troops
							EndSelect
							SetTrophyLoss()
							If _Sleep(1000) Then ExitLoop
							ReturnHome(False, False) ;Return home no screenshot
							If _Sleep(1000) Then ExitLoop
						EndIf

					Else
						SetLog(getLocaleString("logDropCompleted"), $COLOR_BLUE)

					EndIf
				WEnd
			Else
				Setlog(getLocaleString("logArmyCap70"))
				Setlog(getLocaleString("logDropAtkDB"))
			EndIf

		Else

			While Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck)
				$TrophyCount = getTrophyMainScreen($aTrophies[0], $aTrophies[1])
				SetLog(getLocaleString("logTrophyCount") & $TrophyCount, $COLOR_GREEN)
				If Number($TrophyCount) > Number($itxtMaxTrophyNeedCheck) Then
					$itxtMaxTrophyNeedCheck = $itxtdropTrophy ; $itxtMinTrophy = 1650
					SetLog(getLocaleString("logDropTrophiesTo") & $itxtdropTrophy, $COLOR_BLUE)
					If _Sleep(2000) Then ExitLoop

					ZoomOut()
					PrepareSearch()

					If _Sleep(2000) Then ExitLoop
					$iCount = 0
					While getGoldVillageSearch(48, 68) = "" ; Loops until gold is readable
						If _Sleep(1000) Then ExitLoop (2)
						$iCount += 1
						If $iCount >= 35 Then ExitLoop (2) ; or Return
					WEnd

					SetLog(getLocaleString("logIdentifyTroops"), $COLOR_BLUE)
					PrepareAttack($DT)

					If $iChkTrophyHeroes = 1 Then
						$King = -1
						$Queen = -1
						For $i = 0 To UBound($atkTroops) - 1
							If $atkTroops[$i][0] = $eKing Then
								$King = $i
							ElseIf $atkTroops[$i][0] = $eQueen Then
								$Queen = $i
							EndIf
						Next

						$RandomEdge = $Edges[Round(Random(0, 3))]
						$RandomXY = Round(Random(0, 4))
						If $DebugSetlog = 1 Then Setlog("Hero Loc = " & $RandomXY & ", X:Y= " & $RandomEdge[$RandomXY][0] & "|" & $RandomEdge[$RandomXY][1], $COLOR_PURPLE)
						If $King <> -1 Then
							SetLog(getLocaleString("logDeployKing"), $COLOR_BLUE)
							Click(GetXPosOfArmySlot($King, 68), 595, 1, 0, "#0187") ;Select King
							_Sleep(1000)
							Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0188") ;Drop King
							If _Sleep(1000) Then ExitLoop
							SetTrophyLoss()
							ReturnHome(False, False) ;Return home no screenshot
							If _Sleep(1000) Then ExitLoop
						EndIf
						If $King = -1 And $Queen <> -1 Then
							SetLog(getLocaleString("logDeployQueen"), $COLOR_BLUE)
							Click(GetXPosOfArmySlot($Queen, 68), 595, 1, 0, "#0189") ;Select Queen
							_Sleep(1000)
							Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0190") ;Drop Queen
							If _Sleep(1000) Then ExitLoop
							SetTrophyLoss()
							ReturnHome(False, False) ;Return home no screenshot
							If _Sleep(1000) Then ExitLoop
						EndIf
					EndIf
					If ($Queen = -1 And $King = -1) Or $iChkTrophyHeroes = 0 Then
						$RandomEdge = $Edges[Round(Random(0, 3))]
						$RandomXY = Round(Random(0, 4))
						If $DebugSetlog = 1 Then Setlog("Troop Loc = " & $RandomXY & ", X:Y= " & $RandomEdge[$RandomXY][0] & "|" & $RandomEdge[$RandomXY][1], $COLOR_PURPLE)
						Select
							Case $atkTroops[0][0] = $eBarb
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0191") ;Drop one troop
								$CurBarb += 1
								$ArmyComp -= 1
								SetLog(getLocaleString("logDeployBarb"), $COLOR_BLUE)
							Case $atkTroops[0][0] = $eArch
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0192") ;Drop one troop
								$CurArch += 1
								$ArmyComp -= 1
								SetLog(getLocaleString("logDeployArch"), $COLOR_BLUE)
							Case $atkTroops[0][0] = $eGiant
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0193") ;Drop one troop
								$CurGiant += 1
								$ArmyComp -= 5
								SetLog(getLocaleString("logDeployGiantoyArch"), $COLOR_BLUE)
							Case $atkTroops[0][0] = $eWall
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0194") ;Drop one troop
								$CurWall += 1
								$ArmyComp -= 2
								SetLog(getLocaleString("logDeployWB"), $COLOR_BLUE)
							Case $atkTroops[0][0] = $eGobl
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0195") ;Drop one troop
								$CurGobl += 1
								$ArmyComp -= 2
								SetLog(getLocaleString("logDeployGob"), $COLOR_BLUE)
							Case $atkTroops[0][0] = $eMini
								Click($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], 1, 0, "#0196") ;Drop one troop
								$CurMini += 1
								$ArmyComp -= 2
								SetLog(getLocaleString("logDeployMini"), $COLOR_BLUE)
							Case Else
								$itxtMaxTrophy += 50
								SetLog("You don´t have Tier 1/2 Troops, exit of dropping Trophies", $COLOR_BLUE) ; preventing of deploying Tier 2/3 expensive troops
						EndSelect
						SetTrophyLoss()
						If _Sleep(1000) Then ExitLoop
						ReturnHome(False, False) ;Return home no screenshot
						If _Sleep(1000) Then ExitLoop
					EndIf

				Else
					SetLog(getLocaleString("logDropCompleted"), $COLOR_BLUE)
				EndIf
			WEnd

		EndIf
	EndIf
EndFunc   ;==>DropTrophy

Func SetTrophyLoss()
	Local $sTrophyLoss
	If _ColorCheck(_GetPixelColor(30, 142, True), Hex(0x07010D, 6), 10) Then ; check if the village have a Dark Elixir Storage
		$sTrophyLoss = getTrophyLossAttackScreen(48, 214)
	Else
		$sTrophyLoss = getTrophyLossAttackScreen(48, 184)
	EndIf
	Setlog(getLocaleString("logTrophyLoss") & $sTrophyLoss, $COLOR_PURPLE) ; record trophy loss
	GUICtrlSetData($lblresulttrophiesdropped, GUICtrlRead($lblresulttrophiesdropped) - (Number($sTrophyLoss)))
EndFunc   ;==>SetTrophyLoss
