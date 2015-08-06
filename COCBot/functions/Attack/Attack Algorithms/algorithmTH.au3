; #FUNCTION# ====================================================================================================================
; Name ..........: algorithmTH
; Description ...: This file contens the attack algorithm TH and Lspell
; Syntax ........: algorithmTH() , AttackTHGrid() , AttackTHNormal() , AttackTHXtreme() , LLDropheroes() , SpellTHGrid() , CastSpell()
; Parameters ....: None
; Return values .: None
; Author ........: AtoZ (2015)
; Modified ......: Barracoda (July 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func algorithmTH() ;Attack Algorithm TH
	If $iMatchMode = $TS Or $chkATH = 1 Then ; $iMatchMode = $TS
		$LeftTHx = 40
		$RightTHx = 30
		$BottomTHy = 30
		$TopTHy = 30
		$GetTHLoc = 0
		If $THLocation = 0 Then
			SetLog(getLocaleString("logCantGetTHLoc"), $COLOR_RED)
		ElseIf $THx > 227 And $THx < 627 And $THy > 151 And $THy < 419 And ($iMatchMode = $TS Or $chkATH = 1) Then ;if found outside
			SetLog(getLocaleString("logTHLoc") & $THx & ", " & $THy & ")")
			SetLog(getLocaleString("logTHLocCenter"), $COLOR_RED)
			$THLocation = 0
		Else
			SetLog(getLocaleString("logTHLoc") & $THx & ", " & $THy & ")")
		EndIf
		If _Sleep(100) Then Return
		While 1
			Local $i = 0
			If $Barb <> -1 And $THLocation <> 0 Then
				$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
				Local $numBarbPerSpot = Ceiling($atkTroops[$Barb][1] / 3)
				If $atkTroops[$Barb][1] <> 0 Then
					Click(GetXPosOfArmySlot($Barb, 68), 595, 1, 0, "#0001") ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					If $iMatchMode = $TS Or $chkATH = 1 Then
						If $GetTHLoc = 0 Then
							If $THx < 287 And $THx > 584 And $THy < 465 Then ; Leftmost, Rightmost, Topmost. If found Outside
								$i = 0
								$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
								While $atkTroops[$Barb][1] <> 0
									Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), 1, 1, "#0002") ; BottomLeft
									$AtkTroopTH = Number(ReadTroopQuantity($Barb))
									SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
									$LeftTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
								$i = 0
								$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
								While $atkTroops[$Barb][1] <> 0
									Click(($THx + $RightTHx), ($THy + $RightTHx - 10), 1, 1, "#0003") ; BottomRight
									$AtkTroopTH = Number(ReadTroopQuantity($Barb))
									SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
									$RightTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
							EndIf
							$i = 0
							$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
							While $atkTroops[$Barb][1] <> 0
								Click(($THx + $TopTHy - 10), ($THy - $TopTHy), 1, 1, "#0004") ; TopRight
								$AtkTroopTH = Number(ReadTroopQuantity($Barb))
								SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
								$TopTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
							$i = 0
							$atkTroops[$Barb][1] = Number(ReadTroopQuantity($Barb))
							While $atkTroops[$Barb][1] <> 0
								Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), 1, 1, "#0005") ; TopLeft
								$AtkTroopTH = Number(ReadTroopQuantity($Barb))
								SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
								$BottomTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Barb][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
						EndIf
						SetLog(getLocaleString("logTHAtkFirstWaweBarbs"), $COLOR_BLUE)
						For $i = 2 To 4
							If $GetTHLoc = $i Then $numBarbPerSpot = Ceiling($numBarbPerSpot / $i)
						Next
						If $THx < 287 And $THx > 584 And $THy < 465 Then ;Leftmost, rightmost, topmost. If found outside
							Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), $numBarbPerSpot, 200, "#0006") ; BottomLeft
							Click(($THx + $RightTHx), ($THy + $RightTHx - 10), $numBarbPerSpot, 200, "#0007") ; BottomRight
						EndIf
						Click(($THx + $TopTHy - 10), ($THy - $TopTHy), $numBarbPerSpot, 200, "#0008") ; TopRight
						Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), $numBarbPerSpot, 200, "#0009") ; TopLeft
					EndIf
				EndIf
				If _Sleep(1000) Then ExitLoop
			EndIf
			If $Arch <> -1 And $THLocation <> 0 Then
				$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
				Local $numArchPerSpot = Ceiling($atkTroops[$Arch][1] / 3)
				If $atkTroops[$Arch][1] <> 0 Then
					Click(GetXPosOfArmySlot($Arch, 68), 595, 1, 0, "#0010") ;Select Troop
					If _Sleep(100) Then ExitLoop (2)
					If $iMatchMode = $TS Or $chkATH = 1 Then
						If $GetTHLoc = 0 Then
							If $THx < 287 And $THx > 584 And $THy < 465 Then ; Leftmost, Rightmost and Topmost. If found outside
								$i = 0
								$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
								While $atkTroops[$Arch][1] <> 0
									Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), 1, 1, "#0011") ; BottomLeft
									$AtkTroopTH = Number(ReadTroopQuantity($Arch))
									SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
									$LeftTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
								$i = 0
								$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
								While $atkTroops[$Arch][1] <> 0
									Click(($THx + $RightTHx), ($THy + $RightTHx - 10), 1, 1, "#0012") ; BottomRight
									$AtkTroopTH = Number(ReadTroopQuantity($Arch))
									SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
									$RightTHx += 10
									$i += 1
									If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
										$GetTHLoc += 1
										ExitLoop
									EndIf
								WEnd
							EndIf
							$i = 0
							$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
							While $atkTroops[$Arch][1] <> 0
								Click(($THx + $TopTHy - 10), ($THy - $TopTHy), 1, 1, "#0013") ; TopRight
								$AtkTroopTH = Number(ReadTroopQuantity($Arch))
								SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
								$TopTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
							$i = 0
							$atkTroops[$Arch][1] = Number(ReadTroopQuantity($Arch))
							While $atkTroops[$Arch][1] <> 0
								Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), 1, 1, "#0014") ; TopLeft
								$AtkTroopTH = Number(ReadTroopQuantity($Arch))
								SetLog(getLocaleString("logGetTHLoc"), $COLOR_BLUE)
								$BottomTHy += 10
								$i += 1
								If $AtkTroopTH <> $atkTroops[$Arch][1] Or $i >= 10 Then
									$GetTHLoc += 1
									ExitLoop
								EndIf
							WEnd
						EndIf
						SetLog(getLocaleString("logTHAtkFirstWaweArch"), $COLOR_BLUE)
						$LeftTHx += 10
						$RightTHx += 10
						$BottomTHy += 10
						$TopTHy += 10
						For $i = 2 To 4
							If $GetTHLoc = $i Then $numArchPerSpot = Ceiling($numArchPerSpot / $i)
						Next
						If $THx < 287 And $THx > 584 And $THy < 465 Then ;Left most and Right most and tOp most. if found outside
							Click(($THx - $LeftTHx), ($THy + $LeftTHx - 30), $numArchPerSpot, 200, "#0015") ; BottomLeft
							Click(($THx + $RightTHx), ($THy + $RightTHx - 10), $numArchPerSpot, 200, "#0016") ; BottomRight
						EndIf
						Click(($THx + $TopTHy - 10), ($THy - $TopTHy), $numArchPerSpot, 200, "#0017") ; TopRight
						Click(($THx - ($BottomTHy + 10)), ($THy - $BottomTHy), $numArchPerSpot, 200, "#0018") ; TopLeft
					EndIf
				EndIf
			EndIf
			ExitLoop
		WEnd
		If $THLocation <> 0 Then
			PrepareAttack($iMatchMode, True) ;Check remaining quantities
		EndIf
	EndIf
EndFunc   ;==>algorithmTH

Func AttackTHGrid($troopKind, $spots, $numperspot, $Sleep, $waveNb, $maxWaveNb, $BoolDropHeroes)
	Local $aThx, $aThy, $num
	Local $TroopCountBeg
	If $iMatchMode = $TS Or $chkATH = 1 And SearchTownHallLoc() Then

		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) Then Return ;exit if 1 star

		If $BoolDropHeroes = True Then ALLDropheroes($aThx, $aThy)

		Local $THtroop = -1
		Local $troopNb = 0
		Local $name = ""
		For $i = 0 To UBound($atkTroops) - 1
			If $atkTroops[$i][0] = $troopKind Then
				$THtroop = $i
				$troopNb = $spots * $numperspot
				Local $plural = 0
				If $troopNb > 1 Then $plural = 1
				$name = NameOfTroop($troopKind, $plural)
			EndIf
		Next

		;_CaptureRegion()
		$TroopCountBeg = Number(ReadTroopQuantity($THtroop))

		If ($THtroop = -1) Or ($TroopCountBeg = 0) Then SetLog(getLocaleString("logTHAtkTroopQty") & $name & getLocaleString("logTHAtkTroopQty2"))
		If ($THtroop = -1) Or ($TroopCountBeg = 0) Then Return False

		Local $waveName = getLocaleString("txtWaveName1")
		If $waveNb = 2 Then $waveName = getLocaleString("txtWaveName2")
		If $waveNb = 3 Then $waveName = getLocaleString("txtWaveName3")
		If $maxWaveNb = 1 Then $waveName = getLocaleString("txtWaveNameOnly")
		If $waveNb = 0 Then $waveName = getLocaleString("txtWaveNameLast")
		SetLog(getLocaleString("logDropWave") & $waveName & getLocaleString("logDropWave2") & $troopNb & " " & $name & getLocaleString("logDropWave3"), $COLOR_GREEN)

		;			SetLog("Attacking TH with "&NameOfTroop($atkTroops[$THtroop][0]))
		SelectDropTroop($THtroop) ;Select Troop
		If _Sleep(500) Then Return

		If $THi <= 15 Or $THside = 0 Or $THside = 2 Then
			Switch $THside
				Case 0 ;UL
					For $num = 0 To $numperspot - 1
						For $ii = $THi - 1 To $THi - 1 + ($spots - 1)
							$aThx = 25 + $ii * 19
							$aThy = 314 - $ii * 14
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0019")
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
					Next
				Case 1 ;LL
					For $num = 0 To $numperspot - 1
						For $ii = $THi To $THi + ($spots - 1)
							$aThx = 25 + $ii * 19
							$aThy = 314 + $ii * 14
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0020")
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
					Next
				Case 2 ;UR
					For $num = 0 To $numperspot - 1
						For $ii = $THi To $THi + ($spots - 1)
							$aThx = 830 - $ii * 19
							$aThy = 314 - $ii * 14
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0021")
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
					Next
				Case 3 ;LR
					For $num = 0 To $numperspot - 1
						For $ii = $THi + 1 To $THi + 1 + ($spots - 1)
							$aThx = 830 - $ii * 19
							$aThy = 314 + $ii * 14
							Click(Random($aThx - 5, $aThx + 5, 1), Random($aThy - 5, $aThy + 5, 1), 1, 0, "#0022")
							If _Sleep(Random(30, 60)) Then Return
						Next
						If _Sleep(Random(40, 100)) Then Return
					Next
			EndSwitch
		EndIf

		If $THi > 15 Then
			If ($THside = 1 Or $THside = 3) And $zoomedin = False Then
				;Zoom in all the way
				SetLog(getLocaleString("logAtkTHZoomIn"))
				While $zCount < 6
					If _Sleep(300) Then Return
					ControlSend($Title, "", "", "{UP}")
					If _Sleep(100) Then Return
					$zCount += 1
				WEnd
				SetLog(getLocaleString("logAtkTHZoomDone"))
				If _Sleep(500) Then Return

				;Scroll to bottom
				SetLog(getLocaleString("logAtkTHScrollBottom"))
				While $sCount < 7
					If _Sleep(300) Then Return
					ControlSend($Title, "", "", "{CTRLDOWN}{UP}{CTRLUP}")
					If _Sleep(100) Then Return
					$sCount += 1
				WEnd
				$zoomedin = True
			EndIf
			If $THside = 1 Then
				;						Setlog("LL Bottom deployment $THi="&$THi)
				For $num = 0 To $numperspot - 1
					For $ii = $THi + 1 To $THi + 1 + ($spots - 1)
						$aThx = 830 - $ii * 19
						$aThy = 314 + $ii * 14
						Click(730, 450)
						If _Sleep(Random(30, 60)) Then Return
					Next
					If _Sleep(Random(40, 100)) Then Return
				Next
			EndIf

			If $THside = 3 Then
				;						Setlog("LR Bottom deployment $THi="&$THi)
				For $num = 0 To $numperspot - 1
					For $ii = $THi + 1 To $THi + 1 + ($spots - 1)
						$aThx = 830 - $ii * 19
						$aThy = 314 + $ii * 14
						;Click($aThx,$aThy)
						Click(730, 450)
						If _Sleep(Random(30, 60)) Then Return
					Next
					If _Sleep(Random(40, 100)) Then Return
				Next
			EndIf
		EndIf

		If _Sleep(500) Then Return
		;_CaptureRegion()
		;			Setlog($TroopCountBeg&" = "&Number(ReadTroopQuantity($THtroop))))
		If $TroopCountBeg <> Number(ReadTroopQuantity($THtroop)) Then
			SetLog(getLocaleString("logAtkTHDeployment") & $name & getLocaleString("logAtkTHDeploymentSuccess"))
			If _Sleep($Sleep) Then Return
		Else
			SetLog(getLocaleString("logAtkTHDeployment") & $name & getLocaleString("logAtkTHDeploymentNOTSuccess"))
		EndIf


	EndIf

EndFunc   ;==>AttackTHGrid

Func AttackTHNormal()
	Setlog(getLocaleString("logAtkTHNormal1"))

	;---1st wave
	AttackTHGrid($eBarb, 3, 2, 1800, 1, 5, 0) ; deploys 6 barbarians
	AttackTHGrid($eArch, 3, 2, 1200, 1, 4, 0) ; deploys 6 archers
	AttackTHGrid($eMini, 3, 2, 1000, 1, 4, 0) ; deploys 6 minions
	$count = 0
	While $count < 30
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---2nd wave
	AttackTHGrid($eBarb, 3, 2, 1500, 2, 5, 0) ; deploys 6 barbarians
	AttackTHGrid($eArch, 3, 2, 1400, 2, 4, 0) ; deploys 6 archers
	AttackTHGrid($eMini, 3, 2, 1300, 2, 4, 0) ; deploys 6 minions
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---3rd wave 10 secs
	AttackTHGrid($eBarb, 3, 2, 1400, 3, 5, 0) ; deploys 6 barbarians
	AttackTHGrid($eMini, 3, 2, 1300, 3, 4, 0) ; deploys 6 minions
	AttackTHGrid($eArch, 3, 2, 1200, 3, 4, 0) ; deploys 6 archers
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	Setlog(getLocaleString("logAtkTHNormal2"))
	AttackTHGrid($eGiant, 3, 1, 1000, 1, 2, 0) ;releases 3 giants
	AttackTHGrid($eWall, 2, 2, 1100, 1, 1, 0) ; deploys 4 wallbreakers
	AttackTHGrid($eArch, 5, 5, 1200, 4, 4, 0) ;releases 25 archers
	AttackTHGrid($eBarb, 5, 5, 1150, 4, 5, 0) ;releases 25 barbs
	AttackTHGrid($eMini, 5, 2, 1000, 4, 4, 1) ;releases 10 minions and Heroes
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;Final Wave
	AttackTHGrid($eGiant, 5, 1, 1100, 2, 2, 0) ;releases 5 giants
	AttackTHGrid($eHogs, 5, 1, 1300, 2, 4, 0) ;releases 5 Hogs
	AttackTHGrid($eArch, 5, 5, 1000, 4, 4, 0) ;releases 25 archers
	AttackTHGrid($eBarb, 5, 5, 1100, 4, 5, 0) ;releases 25 barbs
	AttackTHGrid($eMini, 5, 2, 1050, 4, 4, 0) ;releases 10 minions
	AttackTHGrid($eWiza, 3, 2, 1000, 1, 1, 1) ;releases 6 wizards and releases hero
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	SetLog(getLocaleString("logAtkTHFinished"), $COLOR_GREEN)

EndFunc   ;==>AttackTHNormal

Func AttackTHXtreme()
	Setlog(getLocaleString("logAtkTHExtreme1"))

	;---1st wave 15 secs
	;		SetLog("Attacking TH with 1st wave of BAM COMBO")
	AttackTHGrid($eBarb, 5, 1, 1000, 1, 5, 0) ; deploys 5 barbarians
	AttackTHGrid($eArch, 5, 1, 1000, 1, 4, 0) ; deploys 5 archers
	AttackTHGrid($eMini, 5, 1, 1000, 1, 4, 0) ; deploys 5 minions
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---2nd wave 20 secs
	;		 SetLog("Attacking TH with 2nd wave of BAM COMBO")
	AttackTHGrid($eBarb, 5, 1, 1000, 2, 5, 0) ; deploys 5 barbarians
	AttackTHGrid($eMini, 5, 1, 1000, 2, 4, 0) ; deploys 5 minions
	AttackTHGrid($eArch, 5, 1, 1000, 2, 4, 0) ; deploys 5 archers
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---3nd wave 10 secs
	;		 SetLog("Attacking TH with 3rd wave of BAM COMBO")
	AttackTHGrid($eBarb, 5, 1, 1000, 3, 5, 0) ; deploys 5 barbarians
	AttackTHGrid($eMini, 5, 1, 1000, 3, 4, 0) ; deploys 5 minions
	AttackTHGrid($eArch, 5, 1, 1200, 3, 4, 0) ; deploys 5 archers
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	;---4th wave
	Setlog(getLocaleString("logAtkTHExtreme2"))
	AttackTHGrid($eGiant, 3, 1, 1000, 1, 4, 0) ;releases 3 giants
	AttackTHGrid($eWall, 2, 2, 100, 1, 1, 0) ; deploys 4 wallbreakers
	AttackTHGrid($eArch, 5, 5, 1200, 4, 4, 0) ;releases 25 archers
	AttackTHGrid($eBarb, 5, 5, 1200, 4, 5, 0) ;releases 25 barbs
	AttackTHGrid($eMini, 5, 2, 1200, 4, 4, 0) ; deploys 5 minions
	AttackTHGrid($eGiant, 5, 1, 1000, 2, 4, 0) ;releases 5 giants
	AttackTHGrid($eHogs, 5, 1, 1000, 2, 4, 0) ;releases 5 Hogs
	AttackTHGrid($eBarb, 5, 5, 1200, 5, 5, 0) ;releases 25 barbs
	AttackTHGrid($eWiza, 3, 2, 1000, 1, 1, 1) ;releases 6 wizards and releases hero
	$count = 0
	While $count < 20
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	SetLog(getLocaleString("logAtkTHFinished"), $COLOR_GREEN)

EndFunc   ;==>AttackTHXtreme

Func AttackTHGbarch()
	Setlog(getLocaleString("logAtkTHGBarch1"))
	AttackTHGrid($eArch, 4, 1, 2000, 1, 4, 0) ; deploys 4 archers - take out possible bombs
	AttackTHGrid($eArch, 3, Random(5, 6, 1), 1000, 1, 4, 0) ; deploys 15-18 archers
	$count = 0
	While $count < 30
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	Setlog(getLocaleString("logAtkTHGBarch2"))
	AttackTHGrid($eArch, 4, Random(4, 5, 1), 1000, 2, 4, 0) ;deploys 16-20 archers
	$count = 0
	While $count < 30
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	Setlog(getLocaleString("logAtkTHGBarch3"))
	AttackTHGrid($eGiant, 2, 1, 1240, 1, 2, 0) ;deploys 2 giants in case of spring traps
	AttackTHGrid($eGiant, 2, Random(3, 4, 1), 1500, 2, 2, 0) ;deploys 6-8 giants to take heat
	AttackTHGrid($eBarb, 3, Random(4, 5, 1), 1000, 1, 5, 0) ; deploys up to 12-15 barbarians
	AttackTHGrid($eBarb, 4, Random(4, 5, 1), 1500, 1, 5, 0) ; deploys up to 16-20 barbarians
	AttackTHGrid($eArch, 3, 8, 1200, 3, 4, 0) ; deploys 24 archers
	AttackTHGrid($eArch, 4, 7, 1000, 3, 4, 0) ; deploys 28 archers
	$count = 0
	While $count < 25
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd

	Setlog(getLocaleString("logAtkTHGBarch4"))
	AttackTHGrid($eGiant, 2, 9, 1500, 3, 2, 1) ;deploys CC/Heroes & up to 18 giants (in case numbers are off)
	AttackTHGrid($eBarb, 4, 8, 1200, 2, 5, 0) ; deploys up to 32 barbarians
	AttackTHGrid($eArch, 3, 13, 1210, 4, 4, 0) ;deploys up to 39 archers
	AttackTHGrid($eBarb, 3, 11, 1190, 2, 5, 0) ; deploys up to 33 barbarians
	AttackTHGrid($eArch, 2, 20, 1200, 4, 4, 0) ;deploys up to 40 archers
	AttackTHGrid($eBarb, 4, 9, 1500, 2, 5, 0) ; deploys up to 36 barbarians
	AttackTHGrid($eArch, 2, 20, 1000, 4, 4, 0) ;deploys up to 40 archers
	$count = 0
	While $count < 25
		If _Sleep(1000) Then Return
		;_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aWonOneStar[0], $aWonOneStar[1], True), Hex($aWonOneStar[2], 6), $aWonOneStar[3]) = True Then
			SetLog(getLocaleString("logTHDestroyed"))
			Return ;exit if you get a star
		EndIf
		$count += 1
	WEnd
	SetLog(getLocaleString("logAtkTHGBarchLast1"), $COLOR_GREEN)
	SetLog(getLocaleString("logAtkTHGBarchLast2"), $COLOR_GREEN)

EndFunc   ;==>AttackTHGbarch

Func ALLDropheroes($x, $y)
	dropHeroes($x, $y, $King, $Queen)
	If _Sleep(1000) Then Return

	dropCC($x, $y, $CC)

	If _Sleep(100) Then Return

	;Activate KQ's power
	If $checkKPower Or $checkQPower Then
		SetLog(getLocaleString("logCheckHeroPowerManual") & $delayActivateKQ / 1000 & getLocaleString("logCheckHeroPowerManual2"), $COLOR_ORANGE)
		If _Sleep($delayActivateKQ) Then Return
		If $checkKPower Then
			SetLog(getLocaleString("logCheckKPower"), $COLOR_BLUE)
			SelectDropTroop($King)
		EndIf
		If $checkQPower Then
			SetLog(getLocaleString("logCheckQPower"), $COLOR_BLUE)
			SelectDropTroop($Queen)
		EndIf
	EndIf
EndFunc   ;==>ALLDropheroes

Func SpellTHGrid($S)
	If $THi <= 15 Or $THside = 0 Or $THside = 2 Then
		Switch $THside
			Case 0
				CastSpell($S, 114 + $THi * 19 + Ceiling(-2 * 19), 359 - $THi * 14 + Ceiling(-2 * 14))
			Case 1
				CastSpell($S, 117 + $THi * 19 + Ceiling(-2 * 19), 268 + $THi * 14 - Floor(-2 * 14))
			Case 2
				CastSpell($S, 743 - $THi * 19 - Floor(-2 * 19), 358 - $THi * 14 + Ceiling(-2 * 14))
			Case 3
				CastSpell($S, 742 - $THi * 19 - Floor(-2 * 19), 268 + $THi * 14 - Floor(-2 * 14))
		EndSwitch
	EndIf

EndFunc   ;==>SpellTHGrid

Func CastSpell($THSpell, $x, $y)
	Local $Spell = -1
	Local $name = ""
	For $i = 0 To UBound($atkTroops) - 1
		If $atkTroops[$i][0] = $THSpell Then
			$Spell = $i
			$name = NameOfTroop($THSpell, 0)
		EndIf
	Next

	If ($Spell = -1) Then Return False
	If $Spell > -1 Then
		SetLog(getLocaleString("logAtkTHDropSpell") & $name & getLocaleString("logAtkTHDropSpell2"))
		SelectDropTroop($Spell)
		If _Sleep(10) Then Return
		Click($x, $y, 1, 0, "#0029")
	Else
		SetLog(getLocaleString("logTHAtkTroopQty") & $name & getLocaleString("logTHAtkTroopQty2"))
	EndIf

EndFunc   ;==>CastSpell