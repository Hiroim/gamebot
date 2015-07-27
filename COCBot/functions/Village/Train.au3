
; #FUNCTION# ====================================================================================================================
; Name ..........: Train
; Description ...: Train the troops (Fill the barracks), Uses the location of manually set Barracks to train specified troops
; Syntax ........: Train()
; Parameters ....:
; Return values .: None
; Author ........: Hungle
; Modified ......: ProMac (June 2015), Sardo (June/July 2015), KnowJack(July 2105)
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func Train()

	Local $anotherTroops

	If $debugSetlog = 1 Then SetLog("Func Train ", $COLOR_PURPLE)
	If $bTrainEnabled = False Then Return

	If $debugSetlog = 1 Then SetLog("Halt enabled, $TotalTrainedTroops= " & $TotalTrainedTroops & ", Adj TotalCamp= " & $TotalCamp - 8, $COLOR_PURPLE)
	If ($CommandStop = 0) And ($TotalTrainedTroops <> 0) And ($TotalTrainedTroops >= ($TotalCamp - 8)) Then
		CheckOverviewFullArmy(True)
		If $fullarmy = True Then
			If $debugSetlog = 1 Then SetLog("FullArmy & TotalTrained = skip training", $COLOR_PURPLE)
			Return
		EndIf
	EndIf

	; Reset variables
	If $fullArmy Or $iMatchMode = $TS Then
		For $i = 0 To UBound($TroopName) - 1
			If $debugSetlog = 1 Then SetLog("RESET AT 0 " & "Cur" & $TroopName[$i], $COLOR_PURPLE)
			Assign("Cur" & $TroopName[$i], 0)
			Assign(("tooMany" & $TroopName[$i]), 0)
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 Then SetLog("RESET AT 0 " & "Cur" & $TroopDarkName[$i], $COLOR_PURPLE)
			Assign("Cur" & $TroopDarkName[$i], 0)
			Assign(("tooMany" & $TroopDarkName[$i]), 0)
		Next
	EndIf

	If $FirstStart And $OptTrophyMode = 1 And _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 9 Then
		$ArmyComp = $CurCamp
	EndIf

	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
		checkArmyCamp()
	EndIf

	SetLog(getLocaleString("logTrainingTroops"), $COLOR_BLUE)
	If _Sleep(100) Then Return
	ClickP($aTopLeftClient, 1, 0, "#0268") ;Click Away

	;OPEN ARMY OVERVIEW WITH NEW BUTTON
	If _Sleep(100) Then Return
	Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#0293") ; Button Army Overview

	;EXAMINE STATUS
	;BarracksStatus(false)

	;check Full army
	If Not $fullArmy Then CheckFullArmy() ;if armycamp not full, check full by barrack
	Local $NextPos = _PixelSearch(749, 311, 787, 322, Hex(0xF08C40, 6), 5)
	Local $PrevPos = _PixelSearch(70, 311, 110, 322, Hex(0xF08C40, 6), 5)

	;CHECK IF NEED TO MAKE NORMAL TROOPS
	If $isNormalBuild = "" Then
		For $i = 0 To UBound($TroopName) - 1
			If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
				$isNormalBuild = True
			EndIf
		Next
	EndIf
	If $isNormalBuild = "" Then
		$isNormalBuild = False
	EndIf
	If $debugSetlog = 1 Then SetLog("Train: need to make normal troops: " & $isNormalBuild, $COLOR_PURPLE)

	;CHECK IF NEED TO MAKE DARK TROOPS
	If $isDarkBuild = "" Then
		For $i = 0 To UBound($TroopDarkName) - 1
			If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
				$isDarkBuild = True
			EndIf
		Next
	EndIf
	If $isDarkBuild = "" Then
		$isDarkBuild = False
	EndIf
	If $debugSetlog = 1 Then SetLog("Train: need to make dark troops: " & $isDarkBuild, $COLOR_PURPLE)

	;GO TO LAST NORMAL BARRACK
	; find last barrack $i
	Local $lastbarrack = 0, $i = 4
	While $lastbarrack = 0 And $i > 1
		If $Trainviable[$i] = 1 Then $lastbarrack = $i
		$i -= 1
	WEnd


	If $lastbarrack = 0 Then
		Setlog(getLocaleString("logNoBarrackAvailable"))
		Return ;exit from train
	Else
		If $debugSetlog = 1 Then Setlog("LAST BARRACK = " & $lastbarrack, $COLOR_PURPLE)
		;GO TO LAST BARRACK
		Local $j = 0
		While Not _ColorCheck(_GetPixelColor($btnpos[0][0], $btnpos[0][1], True), Hex(0xE8E8E0, 6), 20)
			If $debugSetlog = 1 Then Setlog("OverView TabColor=" & _GetPixelColor($btnpos[0][0], $btnpos[0][1], True), $COLOR_PURPLE)
			If _Sleep(100) Then Return ; wait for Train Window to be ready.
			$j += 1
			If $j > 15 Then ExitLoop
		WEnd
		If $j > 15 Then
			SetLog(getLocaleString("logTrainingOverviewWindow"), $COLOR_RED)
			Return
		EndIf
		Click($btnpos[$lastbarrack][0], $btnpos[$lastbarrack][1], 1, 250, "#0336") ; Click on tab and go to last barrack
		Local $j = 0
		While Not _ColorCheck(_GetPixelColor($btnpos[$lastbarrack][0], $btnpos[$lastbarrack][1], True), Hex(0xE8E8E0, 6), 20)
			If $debugSetlog = 1 Then Setlog("Last Barrack TabColor=" & _GetPixelColor($btnpos[$lastbarrack][0], $btnpos[$lastbarrack][1], True), $COLOR_PURPLE)
			If _Sleep(100) Then Return
			$j += 1
			If $j > 15 Then ExitLoop
		WEnd
		If $j > 15 Then
			SetLog(getLocaleString("logCannotOpenBarrack"), $COLOR_RED)
		EndIf
	EndIf

	;PREPARE TROOPS IF FULL ARMY
	If $fullArmy Then
		$BarrackStatus[0] = False
		$BarrackStatus[1] = False
		$BarrackStatus[2] = False
		$BarrackStatus[3] = False
		$BarrackDarkStatus[0] = False
		$BarrackDarkStatus[1] = False
		SetLog(getLocaleString("logArmyCampsFull"), $COLOR_RED)
		If $pEnabled = 1 And $ichkAlertPBCampFull = 1 Then PushMsg("CampFull")
	Else
	EndIf

	;compute troops to make...
	If $debugSetlog = 1 Then SetLog("---------COMPUTE TROOPS TO MAKE------------------------", $COLOR_PURPLE)
	If $fullArmy Then
		$ArmyComp = 0
		$anotherTroops = 0
		$TotalTrainedTroops = 0
		If $debugSetlog = 1 Then SetLog("-- Compute AnotherTroops to train", $COLOR_PURPLE)
		For $i = 0 To UBound($TroopName) - 1
			If $TroopName[$i] <> "Barb" And $TroopName[$i] <> "Arch" And $TroopName[$i] <> "Gobl" Then
				If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) <> 0 Then SetLog("Need to train ASSIGN.... Cur" & $TroopName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopName[$i])), $COLOR_PURPLE)
				If $OptTrophyMode = 1 And _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 9 And Eval("Cur" & $TroopName[$i]) * -1 > GUICtrlRead(Eval("txtNum" & $TroopName[$i])) * 1.20 Then ; 20% too many
					SetLog("Too many " & $TroopName[$i] & ", train last.")
					Assign(("Cur" & $TroopName[$i]), 0)
					Assign(("tooMany" & $TroopName[$i]), 1)
				Else
					Assign(("Cur" & $TroopName[$i]), GUICtrlRead(Eval("txtNum" & $TroopName[$i])))
				EndIf
				If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) > 0 Then SetLog("-- AnotherTroops to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopName[$i])) & "*" & $TroopHeight[$i], $COLOR_PURPLE)
				$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopName[$i])) * $TroopHeight[$i]
			EndIf
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) <> 0 Then SetLog("Need to train ASSIGN.... Cur" & $TroopDarkName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])), $COLOR_PURPLE)
			If $OptTrophyMode = 1 And _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 9 And Eval("Cur" & $TroopDarkName[$i]) * -1 > GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) * 1.20 Then ; 20% too many
				SetLog("Too many " & $TroopDarkName[$i] & ", train last.")
				Assign(("Cur" & $TroopDarkName[$i]), 0)
				Assign(("tooMany" & $TroopDarkName[$i]), 1)
			Else
				Assign(("Cur" & $TroopDarkName[$i]), GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
			EndIf
			If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) <> 0 Then SetLog("-- AnotherTroops dark to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) & "*" & $TroopDarkHeight[$i], $COLOR_PURPLE)
			$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
		Next
		If $debugSetlog = 1 And Number($anotherTroops) <> 0 Then SetLog("--------------AnotherTroops TOTAL to train:" & $anotherTroops, $COLOR_PURPLE)
		If $OptTrophyMode = 1 And _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 9 Then
			$CurGobl += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumGobl) / 100
			$CurGobl = Round($CurGobl)
			$CurBarb += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumBarb) / 100
			$CurBarb = Round($CurBarb)
			$CurArch += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumArch) / 100
			$CurArch = Round($CurArch)
			For $i = 0 To UBound($TroopName) - 1
				If $TroopName[$i] = "Barb" Or $TroopName[$i] = "Arch" Or $TroopName[$i] = "Gobl" Then
					If Eval("Cur" & $TroopName[$i]) * -1 > ($TotalCamp - $anotherTroops) * GUICtrlRead(Eval("txtNum" & $TroopName[$i])) / 100 * .20 Then ;20% too many troops
						SetLog("Too many " & $TroopName[$i] & ", train last.")
						Assign("Cur" & $TroopName[$i], 0)
						Assign(("tooMany" & $TroopName[$i]), 1)
					Else
						Assign("Cur" & $TroopName[$i], Round(($TotalCamp - $anotherTroops) * GUICtrlRead(Eval("txtNum" & $TroopName[$i])) / 100))
					EndIf
				EndIf
			Next
		Else
			$CurGobl = ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumGobl) / 100
			$CurGobl = Round($CurGobl)
			$CurBarb = ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumBarb) / 100
			$CurBarb = Round($CurBarb)
			$CurArch = ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumArch) / 100
			$CurArch = Round($CurArch)
		EndIf
		If $debugSetlog = 1 Then SetLog("Need to train (height) GOBL:" & $CurGobl & "% BARB: " & $CurBarb & "% ARCH: " & $CurArch & "% AND " & $anotherTroops & " other troops space", $COLOR_PURPLE)
	ElseIf $ArmyComp = 0 Or $FirstStart Then
		$anotherTroops = 0
		For $i = 0 To UBound($TroopName) - 1
			If $TroopName[$i] <> "Barb" And $TroopName[$i] <> "Arch" And $TroopName[$i] <> "Gobl" Then
				Assign(("Cur" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]) + GUICtrlRead(Eval("txtNum" & $TroopName[$i])))
				If $debugSetlog = 1 And Number($anotherTroops + GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) <> 0 Then SetLog("-- AnotherTroops to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopName[$i])) & "*" & $TroopHeight[$i], $COLOR_PURPLE)
				$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopName[$i])) * $TroopHeight[$i]
				If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopName[$i]))) <> 0 Then SetLog("Need to train " & $TroopName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopName[$i])), $COLOR_PURPLE)
			EndIf
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			Assign(("Cur" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]) + GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
			If $debugSetlog = 1 And Number($anotherTroops + GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) <> 0 Then SetLog("-- AnotherTroops dark to train:" & $anotherTroops & " + " & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) & "*" & $TroopDarkHeight[$i], $COLOR_PURPLE)
			$anotherTroops += GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
			If $debugSetlog = 1 And Number(GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i]))) <> 0 Then SetLog("Need to train " & $TroopDarkName[$i] & ":" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])), $COLOR_PURPLE)
		Next
		If $debugSetlog = 1 Then SetLog("--------------AnotherTroops TOTAL to train:" & $anotherTroops, $COLOR_PURPLE)
		$CurGobl += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumGobl) / 100
		$CurGobl = Round($CurGobl)
		$CurBarb += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumBarb) / 100
		$CurBarb = Round($CurBarb)
		$CurArch += ($TotalCamp - $anotherTroops) * GUICtrlRead($txtNumArch) / 100
		$CurArch = Round($CurArch)
		If $debugSetlog = 1 Then SetLog("Need to train (height) GOBL:" & $CurGobl & "% BARB: " & $CurBarb & "% ARCH: " & $CurArch & "% AND " & $anotherTroops & " other troops space", $COLOR_PURPLE)
	EndIf

	$TotalTrainedTroops += $anotherTroops + $CurGobl + $CurBarb + $CurArch  ; Count of all troops required for training
	If $debugSetlog = 1 Then SetLog("Total Troops to be Trained= " & $TotalTrainedTroops, $COLOR_PURPLE)

	;Local $GiantEBarrack ,$WallEBarrack ,$ArchEBarrack ,$BarbEBarrack ,$GoblinEBarrack,$HogEBarrack,$MinionEBarrack, $WizardEBarrack
	If $debugSetlog = 1 Then SetLog("BARRACKNUM: " & $numBarracksAvaiables, $COLOR_PURPLE)
	If $numBarracksAvaiables <> 0 Then
		For $i = 0 To UBound($TroopName) - 1
			If $debugSetlog = 1 And Number(Floor(Eval("Cur" & $TroopName[$i]) / $numBarracksAvaiables)) <> 0 Then SetLog($TroopName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopName[$i]) / $numBarracksAvaiables), $COLOR_PURPLE)
			Assign(($TroopName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopName[$i]) / $numBarracksAvaiables))
		Next
	Else
		For $i = 0 To UBound($TroopName) - 1
			If $debugSetlog = 1 And Floor(Eval("Cur" & $TroopName[$i]) / 4) <> 0 Then SetLog($TroopName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopName[$i]) / 4), $COLOR_PURPLE)
			Assign(($TroopName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopName[$i]) / 4))
		Next
	EndIf
	If $debugSetlog = 1 Then SetLog("DARKBARRACKNUM: " & $numDarkBarracksAvaiables, $COLOR_PURPLE)
	If $numDarkBarracksAvaiables <> 0 Then
		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 And Number(Floor(Eval("Cur" & $TroopDarkName[$i]) / $numBarracksAvaiables)) <> 0 Then SetLog($TroopDarkName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopDarkName[$i]) / $numBarracksAvaiables), $COLOR_PURPLE)
			Assign(($TroopDarkName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopDarkName[$i]) / $numDarkBarracksAvaiables))
		Next
	Else
		For $i = 0 To UBound($TroopDarkName) - 1
			If $debugSetlog = 1 And Number(Floor(Eval("Cur" & $TroopDarkName[$i]) / 2)) <> 0 Then SetLog($TroopDarkName[$i] & "EBarrack" & ": " & Floor(Eval("Cur" & $TroopDarkName[$i]) / 2), $COLOR_PURPLE)
			Assign(($TroopDarkName[$i] & "EBarrack"), Floor(Eval("Cur" & $TroopDarkName[$i]) / 2))
		Next
	EndIf

	;RESET TROOPFIRST AND TROOPSECOND
	For $i = 0 To UBound($TroopName) - 1
		;If $debugSetlog = 1 Then SetLog("troopFirst" & $TroopName[$i] & ": 0", $COLOR_PURPLE)
		Assign(("troopFirst" & $TroopName[$i]), 0)
		;If $debugSetlog = 1 Then SetLog("troopSecond" & $TroopName[$i] & ": 0", $COLOR_PURPLE)
		Assign(("troopSecond" & $TroopName[$i]), 0)
	Next
	For $i = 0 To UBound($TroopDarkName) - 1
		;If $debugSetlog = 1 Then SetLog("troopFirst" & $TroopDarkName[$i] & ": 0", $COLOR_PURPLE)
		Assign(("troopFirst" & $TroopDarkName[$i]), 0)
		;If $debugSetlog = 1 Then SetLog("troopSecond" & $TroopDarkName[$i] & ": 0", $COLOR_PURPLE)
		Assign(("troopSecond" & $TroopDarkName[$i]), 0)
	Next

	If $debugSetlog = 1 Then SetLog("---------END COMPUTE TROOPS TO MAKE--------------------", $COLOR_PURPLE)


	$brrNum = 0
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then
		If $debugSetlog = 1 Then
			Setlog("", $COLOR_PURPLE)
			SetLog("---------TRAIN BARRACK MODE------------------------", $COLOR_PURPLE)
		EndIf

		;USE BARRACK
		While isBarrack()
			_CaptureRegion()
			If $FirstStart Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(565, 205, True), Hex(0xE8E8DE, 6), 20) ; while not disappears  green arrow
					Click(496, 197, 10, 0, "#0273")
					$icount += 1
					If $icount = 20 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 20 Then SetLog("Train warning 6")
			EndIf
			If _Sleep(500) Then ExitLoop
			$brrNum += 1
			Switch $barrackTroop[$brrNum - 1]
				Case 0
					TrainClick(220, 320, 50, 10, $FullBarb, $GemBarb, "#0274") ;Barbarian
				Case 1
					TrainClick(331, 320, 50, 10, $FullArch, $GemArch, "#0275") ;Archer
				Case 2
					TrainClick(432, 320, 50, 10, $FullGiant, $GemGiant, "#0276") ;Giant
				Case 3
					TrainClick(546, 320, 50, 10, $FullGobl, $GemGobl, "#0277") ;Goblin
				Case 4
					TrainClick(647, 320, 37, 10, $FullWall, $GemWall, "#0278") ;Wall Breaker
				Case 5
					TrainClick(220, 425, 15, 10, $FullBall, $GemBall, "#0279") ;Balloon
				Case 6
					TrainClick(331, 425, 18, 10, $FullWiza, $GemWiza, "#0280") ;Wizard
				Case 7
					TrainClick(432, 425, 5, 10, $FullHeal, $GemHeal, "#0281") ;Healer
				Case 8
					TrainClick(546, 425, 3, 10, $FullDrag, $GemDrag, "#0282") ;;Dragon
				Case 9
					TrainClick(647, 425, 3, 10, $FullPekk, $GemPekk, "#0283") ; Pekka
			EndSwitch
			If $OutOfElixir = 1 Then
				Setlog(getLocaleString("logTrainOutOfElixir"), $COLOR_RED)
				Setlog(getLocaleString("logTrainOutOfElixirHalt"), $COLOR_RED)
				$ichkBotStop = 1 ; set halt attack variable
				$icmbBotCond = 16 ; set stay online
				If CheckFullArmy() = False Then $Restart = True ;If the army camp is full, use it to refill storages
				Return ; We are out of Elixir stop training.
			EndIf
			If _Sleep(500) Then ExitLoop
			_TrainMoveBtn(-1) ;click prev button
			If $brrNum >= 4 Then ExitLoop ; make sure no more infiniti loop
			If _Sleep(1000) Then ExitLoop
			;endif
		WEnd
	Else
		If $debugSetlog = 1 Then SetLog("---------TRAIN NEW BARRACK MODE------------------------")

		While isBarrack() And $isNormalBuild
			$brrNum += 1
			If $fullArmy Or $FirstStart Then
				;CLICK REMOVE TROOPS
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(488, 191, True), Hex(0xD1D0C2, 6), 20)
					Click(496, 197, 10, 0, "#0284") ; remove troops
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 7", $COLOR_PURPLE)
			EndIf
			If _Sleep(100) Then ExitLoop
			For $i = 0 To UBound($TroopName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopNamePosition[$i]
					If $TroopNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst." & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
					Assign(("troopFirst" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopFirst" & $TroopName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst." & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopFirst" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" And Eval("Cur" & $TroopName[$i]) > 0 Then
					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If Eval("Cur" & $TroopName[$i]) > 0 Then
						If Eval($TroopName[$i] & "EBarrack") = 0 Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopName[$i]), 1)
							$BarrackStatus[$brrNum - 1] = True
						ElseIf Eval($TroopName[$i] & "EBarrack") >= Eval("Cur" & $TroopName[$i]) Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]))
							$BarrackStatus[$brrNum - 1] = True
						Else
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopName[$i]), Eval($TroopName[$i] & "EBarrack"))
							$BarrackStatus[$brrNum - 1] = True
						EndIf
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopName) - 1 ; put troops at end of queue if there are too many
				If Eval("tooMany" & $TroopName[$i]) = 1 Then
					TrainIt(Eval("e" & $TroopName[$i]), GUICtrlRead(Eval("txtNum" & $TroopName[$i])) / $numBarracksAvaiables)
					$BarrackStatus[$brrNum - 1] = True
				EndIf
			Next
			If _Sleep(100) Then ExitLoop
			For $i = 0 To UBound($TroopName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopNamePosition[$i]
					If $TroopNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog(("troopSecond" & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop))), $COLOR_PURPLE)
					Assign(("troopSecond" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopSecond" & $TroopName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN troopSecond" & $TroopName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopSecond" & $TroopName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			$troopNameCooking = ""
			For $i = 0 To UBound($TroopName) - 1
				If Eval("troopSecond" & $TroopName[$i]) > Eval("troopFirst" & $TroopName[$i]) And GUICtrlRead(Eval("txtNum" & $TroopName[$i])) <> "0" Then
					$ArmyComp += (Eval("troopSecond" & $TroopName[$i]) - Eval("troopFirst" & $TroopName[$i])) * $TroopHeight[$i]
					If $debugSetlog = 1 Then SetLog(("###Cur" & $TroopName[$i]) & " = " & Eval("Cur" & $TroopName[$i]) & " - (" & Eval("troopSecond" & $TroopName[$i]) & " - " & Eval("troopFirst" & $TroopName[$i]) & ")", $COLOR_PURPLE)
					Assign(("Cur" & $TroopName[$i]), Eval("Cur" & $TroopName[$i]) - (Eval("troopSecond" & $TroopName[$i]) - Eval("troopFirst" & $TroopName[$i])))
				EndIf
				If Eval("troopSecond" & $TroopName[$i]) > 0 Then
					$troopNameCooking = $troopNameCooking & $i & ";"
				EndIf
			Next

			If _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20) Or $troopNameCooking = "" Then
				$BarrackStatus[$brrNum - 1] = False
			Else
				$BarrackStatus[$brrNum - 1] = True
			EndIf
			If $debugSetlog = 1 Then SetLog("BARRACK " & $brrNum - 1 & " STATUS: " & $BarrackStatus[$brrNum - 1], $COLOR_PURPLE)

			;if armycamp not full, train 20 arch
			If _ColorCheck(_GetPixelColor(392, 155, True), Hex(0xE84D50, 6), 20) Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(560, 202, True), Hex(0xE8E8E0, 6), 20)
					Click(496, 197, 5, 0, "#0285")
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 8", $COLOR_PURPLE)
				If _Sleep(100) Then ExitLoop
				If $debugSetlog = 1 Then SetLog("Call Func TrainIt Arch", $COLOR_PURPLE)
				TrainIt($eArch, 20)
			EndIf
			If $BarrackStatus[0] = False And $BarrackStatus[1] = False And $BarrackStatus[2] = False And $BarrackStatus[3] = False And Not $FirstStart Then
				If Not $isDarkBuild Or ($BarrackDarkStatus[0] = False And $BarrackDarkStatus[1] = False) Then
					If $debugSetlog = 1 Then SetLog("Call Func TrainIt for Arch", $COLOR_PURPLE)
					TrainIt($eArch, 20)
				EndIf
			EndIf
			_TrainMoveBtn(-1) ;click prev button
			If _Sleep(500) Then ExitLoop
			$icount = 0
			While Not isBarrack()
				If _Sleep(200) Then ExitLoop
				$icount = $icount + 1
				If $icount = 5 Then ExitLoop
			WEnd
			If $debugSetlog = 1 And $icount = 10 Then SetLog("Train warning 9", $COLOR_PURPLE)
			If $brrNum >= $numBarracksAvaiables Then ExitLoop ; make sure no more infiniti loop
		WEnd
	EndIf

	;dark here
	If $isDarkBuild Then
		$iBarrHere = 0
		$brrDarkNum = 0
		While 1
			If IsArray($PrevPos) Then _TrainMoveBtn(-1) ;click prev button
			$iBarrHere += 1
			If _Sleep(1000) Then ExitLoop
			If (isDarkBarrack() Or $iBarrHere = 5) Then ExitLoop
		WEnd
		While isDarkBarrack()
			$brrDarkNum += 1
			If $debugSetlog = 1 Then SetLog("====== Check Dark Barrack: " & $brrDarkNum & " ======", $COLOR_PURPLE)
			If StringInStr($sBotDll, "CGBPlugin.dll") < 1 Then
				ExitLoop
			EndIf
			If $fullArmy Or $FirstStart Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(488, 191, True), Hex(0xD1D0C2, 6), 20)
					Click(496, 197, 10, 0, "#0287")
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 9", $COLOR_PURPLE)
			EndIf
			If _Sleep(100) Then ExitLoop
			For $i = 0 To UBound($TroopDarkName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopDarkNamePosition[$i]
					If $TroopDarkNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					EndIf

					;read troops in windows troopsfirst
					If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst.." & $TroopDarkName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
					Assign(("troopFirst" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopFirst" & $TroopDarkName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 And Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)) <> 0 Then SetLog("ASSIGN TroopFirst..." & $TroopDarkName[$i] & ": " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopFirst" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				If $debugSetlog = 1 Then SetLog("** " & $TroopDarkName[$i] & " : " & "txtNum" & $TroopDarkName[$i] & " = " & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) & "  Cur" & $TroopDarkName[$i] & " = " & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				If $debugSetlog = 1 Then SetLog("*** " & "txtNum" & $TroopDarkName[$i] & "=" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])), $COLOR_PURPLE)
				If $debugSetlog = 1 Then SetLog("*** " & "Cur" & $TroopDarkName[$i] & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				If $debugSetlog = 1 Then SetLog("*** " & $TroopDarkName[$i] & "EBarrack" & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" And Eval("Cur" & $TroopDarkName[$i]) > 0 Then

					;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
					If Eval("Cur" & $TroopDarkName[$i]) > 0 Then
						If Eval($TroopDarkName[$i] & "EBarrack") = 0 Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopDarkName[$i]), 1)
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						ElseIf Eval($TroopDarkName[$i] & "EBarrack") >= Eval("Cur" & $TroopDarkName[$i]) Then
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]))
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						Else
							If $debugSetlog = 1 Then SetLog("Call Func TrainIt for " & $TroopDarkName[$i], $COLOR_PURPLE)
							TrainIt(Eval("e" & $TroopDarkName[$i]), Eval($TroopDarkName[$i] & "EBarrack"))
							$BarrackDarkStatus[$brrDarkNum - 1] = True
						EndIf
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopDarkName) - 1 ; put troops at end of queue if there are too man
				If Eval("tooMany" & $TroopDarkName[$i]) = 1 Then
					TrainIt(Eval("e" & $TroopDarkName[$i]), GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])))
					$BarrackDarkStatus[$brrDarkNum - 1] = True
				EndIf
			Next
			If _Sleep(100) Then ExitLoop
			For $i = 0 To UBound($TroopDarkName) - 1
				If GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$heightTroop = 296
					$positionTroop = $TroopDarkNamePosition[$i]
					If $TroopDarkNamePosition[$i] > 4 Then
						$heightTroop = 404
						$positionTroop = $TroopDarkNamePosition[$i] - 5
					EndIf
					If $debugSetlog = 1 Then SetLog(">>>troopSecond" & $TroopDarkName[$i] & " = " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
					Assign(("troopSecond" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					If Eval("troopSecond" & $TroopDarkName[$i]) = 0 Then
						If _Sleep(100) Then ExitLoop
						If $debugSetlog = 1 Then SetLog(">>>troopSecond" & $TroopDarkName[$i] & " = " & Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)), $COLOR_PURPLE)
						Assign(("troopSecond" & $TroopDarkName[$i]), Number(getBarracksTroopQuantity(175 + 107 * $positionTroop, $heightTroop)))
					EndIf
				EndIf
			Next
			For $i = 0 To UBound($TroopDarkName) - 1
				If Eval("troopSecond" & $TroopDarkName[$i]) > Eval("troopFirst" & $TroopDarkName[$i]) And GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])) <> "0" Then
					$ArmyComp += (Eval("troopSecond" & $TroopDarkName[$i]) - Eval("troopFirst" & $TroopDarkName[$i])) * $TroopDarkHeight[$i]
					If $debugSetlog = 1 Then SetLog("#Cur" & $TroopDarkName[$i] & " = " & Eval("Cur" & $TroopDarkName[$i]) & " - (" & Eval("troopSecond" & $TroopDarkName[$i]) & " - " & Eval("troopFirst" & $TroopDarkName[$i]) & ")", $COLOR_PURPLE)
					Assign(("Cur" & $TroopDarkName[$i]), Eval("Cur" & $TroopDarkName[$i]) - (Eval("troopSecond" & $TroopDarkName[$i]) - Eval("troopFirst" & $TroopDarkName[$i])))
					If $debugSetlog = 1 Then SetLog("**** " & "txtNum" & $TroopDarkName[$i] & "=" & GUICtrlRead(Eval("txtNum" & $TroopDarkName[$i])), $COLOR_PURPLE)
					If $debugSetlog = 1 Then SetLog("**** " & "Cur" & $TroopDarkName[$i] & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
					If $debugSetlog = 1 Then SetLog("**** " & $TroopDarkName[$i] & "EBarrack" & "=" & Eval("Cur" & $TroopDarkName[$i]), $COLOR_PURPLE)
				EndIf
			Next
			If _ColorCheck(_GetPixelColor(496, 197, True), Hex(0xE0E4D0, 6), 20) Then
				$BarrackDarkStatus[$brrDarkNum - 1] = False
			Else
				$BarrackDarkStatus[$brrDarkNum - 1] = True
			EndIf

			; if carmycamp not full, train 10 minions
			If _ColorCheck(_GetPixelColor(392, 155, True), Hex(0xE84D50, 6), 20) Then
				$icount = 0
				While Not _ColorCheck(_GetPixelColor(560, 202, True), Hex(0xE8E8E0, 6), 20)
					Click(496, 197, 5, 0, "#0288")
					$icount += 1
					If $icount = 100 Then ExitLoop
				WEnd
				If $debugSetlog = 1 And $icount = 100 Then SetLog("Train warning 10", $COLOR_PURPLE)
				If _Sleep(100) Then ExitLoop
				If $debugSetlog = 1 Then SetLog("Call Func TrainIt for Mini", $COLOR_PURPLE)
				TrainIt($eMini, 10)
			EndIf
			If $BarrackDarkStatus[0] = False And $BarrackDarkStatus[1] = False And (Not $isNormalBuild) And (Not $FirstStart) Then
				If $debugSetlog = 1 Then SetLog("Call Func TrainIt for Mini", $COLOR_PURPLE)
				TrainIt($eMini, 6)
			EndIf
			If IsArray($PrevPos) Then _TrainMoveBtn(-1) ;click prev button
			If _Sleep(500) Then ExitLoop
			$icount = 0
			While Not isDarkBarrack()
				If _Sleep(200) Then ExitLoop
				$icount = $icount + 1
				If $icount = 5 Then ExitLoop
			WEnd
			If $brrDarkNum >= $numDarkBarracksAvaiables Then ExitLoop ; make sure no more infiniti loop
		WEnd
		;end dark
	EndIf
	If $debugSetlog = 1 Then SetLog("---=====================END TRAIN =======================================---", $COLOR_PURPLE)
	If $icmbTroopComp <> 8 And $isNormalBuild And $BarrackStatus[0] = False And $BarrackStatus[1] = False And $BarrackStatus[2] = False And $BarrackStatus[3] = False And Not $FirstStart Then
		If Not $isDarkBuild Or ($BarrackDarkStatus[0] = False And $BarrackDarkStatus[1] = False) Then
			Train()
			Return
		EndIf
	EndIf
	If $iChkLightSpell = 1 Then
		$iBarrHere = 0
		While Not (isSpellFactory())
			If IsArray($PrevPos) Then _TrainMoveBtn(-1) ;click prev button
			$iBarrHere += 1
			If _Sleep(1000) Then ExitLoop
			If $iBarrHere = 7 Then ExitLoop
		WEnd
		If isSpellFactory() Then
			Local $x = 0
			While 1
				_CaptureRegion()
				If _sleep(500) Then Return
				If _ColorCheck(_GetPixelColor(237, 354, True), Hex(0xFFFFFF, 6), 20) = False Then
					setlog("Not enough Elixir to create Spell", $COLOR_RED)
					ExitLoop
				ElseIf _ColorCheck(_GetPixelColor(200, 346, True), Hex(0x1A1A1A, 6), 20) Then
					setlog("Spell Factory Full", $COLOR_RED)
					ExitLoop
				Else
					GemClick(252, 354, 1, 20, "#0290")
					$x = $x + 1
				EndIf
				If $x = 5 Then
					ExitLoop
				EndIf
			WEnd
			If $x = 0 Then
			Else
				SetLog("Created " & $x & " Lightning Spell(s)", $COLOR_BLUE)
			EndIf
		Else
			SetLog("Spell Factory not found...", $COLOR_BLUE)
		EndIf
	Else
	EndIf ; End Spell Factory
	If _Sleep(200) Then Return
	ClickP($aTopLeftClient, 2, 250, "#0291"); Click away twice with 250ms delay
	$FirstStart = False
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
	EndIf
EndFunc   ;==>Train

