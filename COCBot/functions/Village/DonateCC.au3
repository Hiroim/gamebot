; #FUNCTION# ====================================================================================================================
; Name ..........: DonateCC
; Description ...: This file includes functions to Donate troops
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Zax (2015)
; Modified ......: Safar46 (2015), Hervidero (2015-04), HungLe (2015-04), Sardo 2015-08
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func DonateCC($Check = False)
	Local $DonateTroop = BitOR($iChkDonateBarbarians, $iChkDonateArchers, $iChkDonateGiants, $iChkDonateGoblins, _
			$iChkDonateWallBreakers, $iChkDonateBalloons, $iChkDonateWizards, $iChkDonateHealers, _
			$iChkDonateDragons, $iChkDonatePekkas, $iChkDonateMinions, $iChkDonateHogRiders, _
			$iChkDonateValkyries, $iChkDonateGolems, $iChkDonateWitches, $iChkDonateLavaHounds, $iChkDonateCustom)
	Local $DonateAllTroop = BitOR($iChkDonateAllBarbarians, $iChkDonateAllArchers, $iChkDonateAllGiants, $iChkDonateAllGoblins, _
			$iChkDonateAllWallBreakers, $iChkDonateAllBalloons, $iChkDonateAllWizards, $iChkDonateAllHealers, _
			$iChkDonateAllDragons, $iChkDonateAllPekkas, $iChkDonateAllMinions, $iChkDonateAllHogRiders, _
			$iChkDonateAllValkyries, $iChkDonateAllGolems, $iChkDonateAllWitches, $iChkDonateAllLavaHounds, $iChkDonateAllCustom)

	Global $Donate = BitOR($DonateTroop, $DonateAllTroop)

	If $Donate = False Or $bDonationEnabled = False Then Return ; exit func if no donate checkmarks

	If $iPlannedDonateHoursEnable = 1 Then
		Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)
		If $iPlannedDonateHours[$hour[0]] = 0 Then
			SetLog(getLocaleString("logDonationNotPlanned"), $COLOR_GREEN)
			Return ; exit func if no planned donate checkmarks
		EndIf
	EndIf

	Local $y = 119
	;check for new chats first
	If $Check = True Then
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(34, 321), Hex(0xE00300, 6), 20) = False And $CommandStop <> 3 Then
			Return ;exit if no new chats
		EndIf
	EndIf

	ClickP($aAway, 1, 0, "#0167") ;Click Away
	;_CaptureRegion()
	If _CheckPixel($aChatTab, $bCapturePixel) = False Then ClickP($aOpenChat, 1, 0, "#0168") ; Clicks chat tab
	If _Sleep($iDelayDonateCC1) Then Return
	ClickP($aClanTab, 1, 0, "#0169") ; clicking clan tab

	Local $Scroll, $offColors[3][3] = [[0x000000, 0, -2], [0x272926, 0, 1], [0xcfea75, 0, 17]] ; $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
	Global $DonatePixel

	While $Donate
		If _Sleep($iDelayDonateCC2) Then ExitLoop
		$DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		If IsArray($DonatePixel) Then
			$Donate = False
			If $DonateTroop Or $DonateAllTroop Then
				Local $ClanString = ""
				$ClanString = getChatString(30, $DonatePixel[1] - 44, "coc-latinA")
				If $ClanString = "" Then
					$ClanString = getChatString(30, $DonatePixel[1] - 31, "coc-latinA")
				Else
					$ClanString &= " " & getChatString(30, $DonatePixel[1] - 31, "coc-latinA")
				EndIf
				If $ClanString = "" Or $ClanString = " " Then
					$ClanString = getChatString(30, $DonatePixel[1] - 19, "coc-latinA")
				Else
					$ClanString &= " " & getChatString(30, $DonatePixel[1] - 19, "coc-latinA")
				EndIf
				If _Sleep($iDelayDonateCC2) Then ExitLoop



				If $ClanString = "" Or $ClanString = " " Then
					SetLog(getLocaleString("logRequestError"), $COLOR_RED)
					$Donate = True
					$y = $DonatePixel[1] + 10
					ContinueLoop
				Else
					SetLog(getLocaleString("logChatRequest") & $ClanString)
				EndIf

				;;; Custom Combination Donate by ChiefM3
				If $iChkDonateCustom = 1 Then
					If CheckDonateTroop($eLava + 1, $aDonCustom, $aBlkCustom, $aBlackList, $ClanString) Then
						For $i = 0 To 2
							If $varDonateCustom[$i][0] < $eBarb Then
								$varDonateCustom[$i][0] = $eArch ; Change strange small numbers to archer
							ElseIf $varDonateCustom[$i][0] > $eLava Then
								ContinueLoop ; If "Nothing" is selected then continue
							EndIf
							If $varDonateCustom[$i][1] < 1 Then
								ContinueLoop ; If donate number is smaller than 1 then continue
							ElseIf $varDonateCustom[$i][1] > 8 Then
								$varDonateCustom[$i][1] = 8 ; Number larger than 8 is unnecessary
							EndIf
							DonateTroopType($varDonateCustom[$i][0], $varDonateCustom[$i][1], True) ;;; Donate Custom Troop using DonateTroopType2
						Next
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateBarbarians = 1 Then
					If CheckDonateTroop($eBarb, $aDonBarbarians, $aBlkBarbarians, $aBlackList, $ClanString) Then
						DonateTroopType($eBarb)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateArchers = 1 Then
					If CheckDonateTroop($eArch, $aDonArchers, $aBlkArchers, $aBlackList, $ClanString) Then
						DonateTroopType($eArch)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateGiants = 1 Then
					If CheckDonateTroop($eGiant, $aDonGiants, $aBlkGiants, $aBlackList, $ClanString) Then
						DonateTroopType($eGiant)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateGoblins = 1 Then
					If CheckDonateTroop($eGobl, $aDonGoblins, $aBlkGoblins, $aBlackList, $ClanString) Then
						DonateTroopType($eGobl)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateWallBreakers = 1 Then
					If CheckDonateTroop($eWall, $aDonWallBreakers, $aBlkWallBreakers, $aBlackList, $ClanString) Then
						DonateTroopType($eWall)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateBalloons = 1 Then
					If CheckDonateTroop($eBall, $aDonBalloons, $aBlkBalloons, $aBlackList, $ClanString) Then
						DonateTroopType($eBall)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateWizards = 1 Then
					If CheckDonateTroop($eWiza, $aDonWizards, $aBlkWizards, $aBlackList, $ClanString) Then
						DonateTroopType($eWiza)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateHealers = 1 Then
					If CheckDonateTroop($eHeal, $aDonHealers, $aBlkHealers, $aBlackList, $ClanString) Then
						DonateTroopType($eHeal)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateDragons = 1 Then
					If CheckDonateTroop($eDrag, $aDonDragons, $aBlkDragons, $aBlackList, $ClanString) Then
						DonateTroopType($eDrag)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonatePekkas = 1 Then
					If CheckDonateTroop($ePekk, $aDonPekkas, $aBlkPekkas, $aBlackList, $ClanString) Then
						DonateTroopType($ePekk)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateMinions = 1 Then
					If CheckDonateTroop($eMini, $aDonMinions, $aBlkMinions, $aBlackList, $ClanString) Then
						DonateTroopType($eMini)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateHogRiders = 1 Then
					If CheckDonateTroop($eHogs, $aDonHogRiders, $aBlkHogRiders, $aBlackList, $ClanString) Then
						DonateTroopType($eHogs)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateValkyries = 1 Then
					If CheckDonateTroop($eValk, $aDonValkyries, $aBlkValkyries, $aBlackList, $ClanString) Then
						DonateTroopType($eValk)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateGolems = 1 Then
					If CheckDonateTroop($eGole, $aDonGolems, $aBlkGolems, $aBlackList, $ClanString) Then
						DonateTroopType($eGole)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateWitches = 1 Then
					If CheckDonateTroop($eWitc, $aDonWitches, $aBlkWitches, $aBlackList, $ClanString) Then
						DonateTroopType($eWitc)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

				If $iChkDonateLavaHounds = 1 Then
					If CheckDonateTroop($eLava, $aDonLavaHounds, $aBlkLavaHounds, $aBlackList, $ClanString) Then
						DonateTroopType($eLava)
					EndIf
					If $Donate Then
						$y = $DonatePixel[1] + 10
						ContinueLoop
					EndIf
				EndIf

			EndIf

			If $DonateAllTroop Then
				Select
					Case $iChkDonateAllCustom = 1
						For $i = 0 To 2
							If $varDonateCustom[$i][0] < $eBarb Then
								$varDonateCustom[$i][0] = $eArch ; Change strange small numbers to archer
							ElseIf $varDonateCustom[$i][0] > $eLava Then
								ContinueLoop ; If "Nothing" is selected then continue
							EndIf
							If $varDonateCustom[$i][1] < 1 Then
								ContinueLoop ; If donate number is smaller than 1 then continue
							ElseIf $varDonateCustom[$i][1] > 8 Then
								$varDonateCustom[$i][1] = 8 ; Number larger than 8 is unnecessary
							EndIf
							DonateTroopType($varDonateCustom[$i][0], $varDonateCustom[$i][1], True) ;;; Donate Custom Troop using DonateTroopType2
						Next
						ClickP($aAway, 1, 0, "#0170")
					Case $iChkDonateAllBarbarians = 1
						If CheckBlacklist($eBarb, $aBlkBarbarians, $aBlacklist, $ClanString) Then
							DonateTroopType($eBarb)
						EndIf
					Case $iChkDonateAllArchers = 1
						If CheckBlacklist($eArch, $aBlkArchers, $aBlackList, $ClanString) Then
							DonateTroopType($eArch)
						EndIf
					Case $iChkDonateAllGiants = 1
						If CheckBlacklist($eGiant, $aBlkGiants, $aBlacklist, $ClanString) Then
							DonateTroopType($eGiant)
						EndIf
					Case $iChkDonateAllGoblins = 1
						If CheckBlacklist($eGobl, $aBlkGoblins, $aBlacklist, $ClanString) Then
							DonateTroopType($eGobl)
						EndIf
					Case $iChkDonateAllWallBreakers = 1
						If CheckBlacklist($eWall, $aBlkWallBreakers, $aBlacklist, $ClanString) Then
							DonateTroopType($eWall)
						EndIf
					Case $iChkDonateAllBalloons = 1
						If CheckBlacklist($eBall, $aBlkBalloons, $aBlacklist, $ClanString) Then
							DonateTroopType($eBall)
						EndIf
					Case $iChkDonateAllWizards = 1
						If CheckBlacklist($eWiza, $aBlkWizards, $aBlacklist, $ClanString) Then
							DonateTroopType($eWiza)
						EndIf
					Case $iChkDonateAllHealers = 1
						If CheckBlacklist($eHeal, $aBlkHealers, $aBlacklist, $ClanString) Then
							DonateTroopType($eHeal)
						EndIf
					Case $iChkDonateAllDragons = 1
						If CheckBlacklist($eDrag, $aBlkDragons, $aBlacklist, $ClanString) Then
							DonateTroopType($eDrag)
						EndIf
					Case $iChkDonateAllPekkas = 1
						If CheckBlacklist($ePekk, $aBlkPekkas, $aBlacklist, $ClanString) Then
							DonateTroopType($ePekk)
						EndIf
					Case $iChkDonateAllMinions = 1
						If CheckBlacklist($eMini, $aBlkMinions, $aBlacklist, $ClanString) Then
							DonateTroopType($eMini)
						EndIf
					Case $iChkDonateAllHogRiders = 1
						If CheckBlacklist($eHogs, $aBlkHogRiders, $aBlacklist, $ClanString) Then
							DonateTroopType($eHogs)
						EndIf
					Case $iChkDonateAllValkyries = 1
						If CheckBlacklist($eValk, $aBlkValkyries, $aBlacklist, $ClanString) Then
							DonateTroopType($eValk)
						EndIf
					Case $iChkDonateAllGolems = 1
						If CheckBlacklist($eGole, $aBlkGolems, $aBlacklist, $ClanString) Then
							DonateTroopType($eGole)
						EndIf
					Case $iChkDonateAllWitches = 1
						If CheckBlacklist($eWitc, $aBlkWitches, $aBlacklist, $ClanString) Then
							DonateTroopType($eWitc)
						EndIf
					Case $iChkDonateAllLavaHounds = 1
						If CheckBlacklist($eLava, $aBlkLavaHounds, $aBlacklist, $ClanString) Then
							DonateTroopType($eLava)
						EndIf
				EndSelect
			EndIf

			$Donate = True
			$y = $DonatePixel[1] + 10
			ClickP($aAway, 1, 0, "#0171")
			If _Sleep($iDelayDonateCC2) Then ExitLoop
		EndIf
		$DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		If IsArray($DonatePixel) Then ContinueLoop

		$Scroll = _PixelSearch(285, 650, 287, 700, Hex(0x97E405, 6), 20)
		$Donate = True
		If IsArray($Scroll) Then
			Click($Scroll[0], $Scroll[1], 1, 0, "#0172")
			$y = 119
			If _Sleep($iDelayDonateCC2) Then ExitLoop
			ContinueLoop
		EndIf
		$Donate = False
	WEnd

	_CaptureRegion()
	If _ColorCheck(_GetPixelColor($aCloseChat[0], $aCloseChat[1]), Hex($aCloseChat[2], 6), $aCloseChat[3]) Then
		Click($aCloseChat[0], $aCloseChat[1], 1, 0, "#0173") ;Clicks chat thing
	EndIf

	If _Sleep($iDelayDonateCC2) Then Return
EndFunc   ;==>DonateCC

Func CheckDonateTroop($Type, $aDonTroop, $aBlkTroop, $aBlackList, $ClanString)

	For $i = 1 To UBound($aBlackList) - 1
		If CheckDonateString($aBlackList[$i], $ClanString) Then
			SetLog(getLocaleString("logGeneralBLkeyword") & $aBlackList[$i], $COLOR_RED)
			Return False
		EndIf
	Next

	For $i = 1 To UBound($aBlkTroop) - 1
		If CheckDonateString($aBlkTroop[$i], $ClanString) Then
			SetLog(NameOfTroop($Type) & getLocaleString("logBLkeyword") & $aBlkTroop[$i], $COLOR_RED)
			Return False
		EndIf
	Next

	For $i = 1 To UBound($aDonTroop) - 1
		If CheckDonateString($aDonTroop[$i], $ClanString) Then
			If $Type > $eLava Then
				Setlog(getLocaleString("logCustomKeyword") & $aDonTroop[$i], $COLOR_GREEN)
			Else
				Setlog(NameOfTroop($Type) & getLocaleString("logKeywordFound") & $aDonTroop[$i], $COLOR_GREEN)
			EndIf
			Return True
		EndIf
	Next

	Return False
EndFunc   ;==>CheckDonateTroop

Func CheckBlacklist($Type, $aBlkTroop, $aBlackList, $ClanString)

	For $i = 1 To UBound($aBlackList) - 1
		If CheckDonateString($aBlackList[$i], $ClanString) Then
			SetLog(getLocaleString("logGeneralBLkeyword") & $aBlackList[$i], $COLOR_RED)
			Return False
		EndIf
	Next

	For $i = 1 To UBound($aBlkTroop) - 1
		If CheckDonateString($aBlkTroop[$i], $ClanString) Then
			SetLog(NameOfTroop($Type) & getLocaleString("logBLkeyword") & $aBlkTroop[$i], $COLOR_RED)
			Return False
		EndIf
	Next

	Return True
EndFunc   ;==>CheckBlacklist

Func CheckDonateString($String, $ClanString) ;Checks if exact
	Local $Contains = StringMid($String, 1, 1) & StringMid($String, StringLen($String), 1)
	If $Contains = "[]" Then
		If $ClanString = StringMid($String, 2, StringLen($String) - 2) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If StringInStr($ClanString, $String, 2) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc   ;==>CheckDonateString

Func DonateTroopType($Type, $quant = 8, $custom = False)

	Local $Slot, $YComp

	Switch $Type
		Case $eBarb To $eWiza
			$Slot = $Type
			$YComp = 0
		Case $eHeal To $eGole
			$Slot = $Type - 7
			$YComp = 99
		Case $eWitc To $eLava
			$Slot = $Type - 14
			$YComp = 99 + 98
	EndSwitch

	Click($DonatePixel[0], $DonatePixel[1] + 11, 1, 0, "#0174")
	If _Sleep($iDelayDonateTroopType1) Then Return
	_CaptureRegion(0, 0, 766, $DonatePixel[1] + 50 + $YComp)
	$icount = 0
	While Not (_ColorCheck(_GetPixelColor(237 + ($Slot * 82), $DonatePixel[1] - 5 + $YComp), Hex(0x507C00, 6), 10) Or _
			_ColorCheck(_GetPixelColor(237 + ($Slot * 82), $DonatePixel[1] - 10 + $YComp), Hex(0x507C00, 6), 10) Or _
			_ColorCheck(_GetPixelColor(237 + ($Slot * 82), $DonatePixel[1] - 16 + $YComp), Hex(0x507C00, 6), 10))
		If _Sleep($iDelayDonateTroopType1) Then Return
		_CaptureRegion(0, 0, 766, $DonatePixel[1] + 50 + $YComp)
		$icount += 1
		If $icount = 10 Then ExitLoop
	WEnd

	If _ColorCheck(_GetPixelColor(237 + ($Slot * 82), $DonatePixel[1] - 5 + $YComp), Hex(0x507C00, 6), 10) Or _
			_ColorCheck(_GetPixelColor(237 + ($Slot * 82), $DonatePixel[1] - 10 + $YComp), Hex(0x507C00, 6), 10) Or _
			_ColorCheck(_GetPixelColor(237 + ($Slot * 82), $DonatePixel[1] - 16 + $YComp), Hex(0x507C00, 6), 10) Then
		If $custom Then
			SetLog(getLocaleString("logDonating") & $quant & " " & NameOfTroop($Type), $COLOR_GREEN)
		Else
			SetLog(getLocaleString("logDonating") & NameOfTroop($Type), $COLOR_GREEN)
		EndIf
		Click(237 + ($Slot * 82), $DonatePixel[1] - 10 + $YComp, $quant, $iDelayDonateCC3, "#0175")
;~		PureClick(237 + ($Slot * 82), $DonatePixel[1] - 10 + $YComp, $quant, $iDelayDonateCC3)
		$Donate = True
		For $i = 0 To UBound($TroopName) - 1
			If Eval("e" & $TroopName[$i]) = $Type Then
				If $TroopHeight[$i] <= 6 Then
					Assign("Cur" & $TroopName[$i], Eval("Cur" & $TroopName[$i]) + 5)
				Else
					Assign("Cur" & $TroopName[$i], Eval("Cur" & $TroopName[$i]) + 1)
				EndIf
			EndIf
		Next
		For $i = 0 To UBound($TroopDarkName) - 1
			If Eval("e" & $TroopDarkName[$i]) = $Type Then
				If $TroopDarkHeight[$i] <= 6 Then
					Assign("Cur" & $TroopDarkName[$i], Eval("Cur" & $TroopDarkName[$i]) + 5)
				Else
					Assign("Cur" & $TroopDarkName[$i], Eval("Cur" & $TroopDarkName[$i]) + 1)
				EndIf
			EndIf
		Next
	ElseIf $DonatePixel[1] - 5 + $YComp > 675 Then
		Setlog(getLocaleString("logUnableDonate") & NameOfTroop($Type) & ". Donate screen not visible, will retry next run.", $COLOR_RED)
	Else
		SetLog(getLocaleString("logTroopNo") & NameOfTroop($Type) & getLocaleString("logTroopAvailable"), $COLOR_RED)
	EndIf

	ClickP($aAway, 1, 0, "#0176")
	If _Sleep($iDelayDonateTroopType1) Then Return
EndFunc   ;==>DonateTroopType
