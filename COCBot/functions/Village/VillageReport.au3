; #FUNCTION# ====================================================================================================================
; Name ..........: VillageReport
; Description ...: This function will report the village free and total builders, gold, elixir, dark elixir and gems.
;                  It will also update the statistics to the GUI.
; Syntax ........: VillageReport()
; Parameters ....: None
; Return values .: None
; Author ........: Hervidero (2015-feb-10)
; Modified ......: Safar46 (2015), Hervidero (2015, KnowJack - added statistics bypasss (June-2015) , ProMac (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func VillageReport($bBypass = False)
	PureClickP($aTopLeftClient, 1, 0, "#0319") ;Click Away
	If _Sleep(500) Then Return

	Switch $bBypass
		Case False
			SetLog(getLocaleString("logVillageReport"), $COLOR_BLUE)
		Case True
			SetLog(getLocaleString("logUpdatingValues"), $COLOR_BLUE)
		Case Else
			SetLog(getLocaleString("logVillageReportErr"), $COLOR_RED)
	EndSwitch

	Local $aGetBuilders = StringSplit(getBuilders($aBuildersDigits[0], $aBuildersDigits[1]), "#", $STR_NOCOUNT)
	$FreeBuilder = $aGetBuilders[0]
	$TotalBuilders = $aGetBuilders[1]
	Setlog(getLocaleString("logBuilders") & $FreeBuilder & "/" & $TotalBuilders, $COLOR_GREEN)

	$TrophyCount = getTrophyMainScreen($aTrophies[0], $aTrophies[1])
	Setlog(getLocaleString("logTrophyCount_") & _NumberFormat($TrophyCount), $COLOR_GREEN)

	If _ColorCheck(_GetPixelColor(812, 141, True), Hex(0x000000, 6), 10) Then ; check if the village have a Dark Elixir Storage
		$GoldCount = getResourcesMainScreen(710, 23)
		$ElixirCount = getResourcesMainScreen(710, 74)
		$DarkCount = getResourcesMainScreen(731, 123)
		$GemCount = getResourcesMainScreen(740, 171)
		SetLog(getLocaleString("logGoldCount") & _NumberFormat($GoldCount) & getLocaleString("logElixirCount") & _NumberFormat($ElixirCount) & getLocaleString("logDarkElixirCount") & _NumberFormat($DarkCount) & getLocaleString("logGemCount") & _NumberFormat($GemCount), $COLOR_GREEN)
	Else
		$GoldCount = getResourcesMainScreen(710, 23)
		$ElixirCount = getResourcesMainScreen(710, 74)
		$GemCount = getResourcesMainScreen(719, 123)
		SetLog(getLocaleString("logGoldCount") & _NumberFormat($GoldCount) & getLocaleString("logElixirCount") & _NumberFormat($ElixirCount) & getLocaleString("logGemCount") & _NumberFormat($GemCount), $COLOR_GREEN)
	EndIf
	If $bBypass = False Then ; update stats
		Switch $FirstAttack
			Case 2
				ReportLastTotal()
				ReportCurrent()
			Case 1
				GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)
				GUICtrlSetState($lblTotalLootTemp, $GUI_HIDE)
				GUICtrlSetState($lblHourlyStatsTemp, $GUI_HIDE)
				ReportLastTotal()
				ReportCurrent()
				$FirstAttack = 2
			Case 0
				ReportStart()
				ReportCurrent()
				$FirstAttack = 1
		EndSwitch
	EndIf

	Local $i = 0
	While _ColorCheck(_GetPixelColor(819, 39, True), Hex(0xF8FCFF, 6), 20) = True ; wait for Builder/shop to close
		$i += 1
		If _Sleep(500) Then Return
		If $i >= 20 Then ExitLoop
	WEnd

EndFunc   ;==>VillageReport

Func ReportStart() ; stats at Start

	$GoldStart = $GoldCount
	$ElixirStart = $ElixirCount
	$DarkStart = $DarkCount
	$TrophyStart = $TrophyCount

	GUICtrlSetState($lblResultStatsTemp, $GUI_HIDE)
	GUICtrlSetState($lblVillageReportTemp, $GUI_HIDE)
	GUICtrlSetState($picResultGoldTemp, $GUI_HIDE)
	GUICtrlSetState($picResultElixirTemp, $GUI_HIDE)
	GUICtrlSetState($picResultDETemp, $GUI_HIDE)

	GUICtrlSetState($lblResultGoldNow, $GUI_SHOW)
	GUICtrlSetState($picResultGoldNow, $GUI_SHOW)
	GUICtrlSetData($lblResultGoldStart, _NumberFormat($GoldCount))

	GUICtrlSetState($lblResultElixirNow, $GUI_SHOW)
	GUICtrlSetState($picResultElixirNow, $GUI_SHOW)
	GUICtrlSetData($lblResultElixirStart, _NumberFormat($ElixirCount))

	If $DarkCount <> "" Then
		GUICtrlSetData($lblResultDEStart, _NumberFormat($DarkCount))
		GUICtrlSetState($lblResultDeNow, $GUI_SHOW)
		GUICtrlSetState($picResultDeNow, $GUI_SHOW)
	Else
		GUICtrlSetState($picResultDEStart, $GUI_HIDE)
		GUICtrlSetState($picDarkLoot, $GUI_HIDE)
		GUICtrlSetState($picDarkLastAttack, $GUI_HIDE)
	EndIf

	GUICtrlSetData($lblResultTrophyStart, _NumberFormat($TrophyCount))
	GUICtrlSetState($lblResultTrophyNow, $GUI_SHOW)
	GUICtrlSetState($lblResultBuilderNow, $GUI_SHOW)
	GUICtrlSetState($lblResultGemNow, $GUI_SHOW)

EndFunc   ;==>ReportStart

Func ReportCurrent()

	$GoldVillage = $GoldCount
	$ElixirVillage = $ElixirCount
	$DarkVillage = $DarkCount
	$TrophyVillage = $TrophyCount

	GUICtrlSetData($lblResultGoldNow, _NumberFormat($GoldCount))
	GUICtrlSetData($lblResultElixirNow, _NumberFormat($ElixirCount))

	If $DarkCount <> "" Then
		GUICtrlSetData($lblResultDeNow, _NumberFormat($DarkCount))
	EndIf

	GUICtrlSetData($lblResultTrophyNow, _NumberFormat($TrophyCount))
	GUICtrlSetData($lblResultBuilderNow, $FreeBuilder & "/" & $TotalBuilders)
	GUICtrlSetData($lblResultGemNow, _NumberFormat($GemCount))

EndFunc   ;==>ReportCurrent

Func ReportLastTotal()

	;total stats
	$CostGoldWall = $WallGoldMake * $WallCost
	$CostElixirWall = $WallElixirMake * $WallCost



	;find net gain / loss
	$gainLootG = $GoldCount - $GoldStart
	$gainLootE = $ElixirCount - $ElixirStart
	$gainLootDarkE = $DarkCount - $DarkStart

	; find totals earned
	$totalLootG += $lootGold
	$totalLootE += $lootElixir
	$totalLootD += $lootDarkElixir

	$totalBonusG += $BonusLeagueG
	$totalBonusE += $BonusLeagueE
	$totalBonusD += $BonusLeagueD

	$totalLootT += $lootTrophies

	; LAST ATTACK GROUP
	;

	GUICtrlSetData($lblGoldLastAttack, _NumberFormat($lootGold))
	;bonus $BonusLeagueG
	If $BonusLeagueG <> "" Then
		GUICtrlSetData($lblLootBonusGold, _NumberFormat($BonusLeagueG))
		GUICtrlSetData($lblLootBonusGold1, "B.")
	Else
		GUICtrlSetData($lblLootBonusGold, _NumberFormat($BonusLeagueG))
		GUICtrlSetData($lblLootBonusGold1, "")
	EndIf

	GUICtrlSetData($lblElixirLastAttack, _NumberFormat($lootElixir))
	;bonus $BonusLeagueE
	If $BonusLeagueE <> "" Then
		GUICtrlSetData($lblLootBonusElixir, _NumberFormat($BonusLeagueE))
		GUICtrlSetData($lblLootBonusElixir1, "B.")
	Else
		GUICtrlSetData($lblLootBonusElixir, _NumberFormat($BonusLeagueE))
		GUICtrlSetData($lblLootBonusElixir1, "")
	EndIf

	If $lootDarkElixir <> "" Then
		GUICtrlSetState($picDarkLastAttack, $GUI_SHOW)
		GUICtrlSetData($lblDarkLastAttack, _NumberFormat($lootDarkElixir))
		;bonus LootBonusDarkElixir
		If $BonusLeagueD <> "" Then
			GUICtrlSetData($lblLootBonusDarkElixir, _NumberFormat($BonusLeagueD))
			GUICtrlSetData($lblLootBonusDarkElixir1, "B.")
		Else
			GUICtrlSetData($lblLootBonusDarkElixir, _NumberFormat($BonusLeagueD))
			GUICtrlSetData($lblLootBonusDarkElixir1, "")
		EndIf
	Else
		GUICtrlSetState($picDarkLastAttack, $GUI_HIDE)
		GUICtrlSetData($lblDarkLastAttack, _NumberFormat($lootDarkElixir))
	EndIf

	GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($lootTrophies))
	;
	; TOTAL STATS GROUP
	;
	GUICtrlSetData($lblGoldTotal, _NumberFormat($totalLootG))
	;bonus LootBonusGold
	If $totalBonusG <> "" Then
		GUICtrlSetData($lblTotalBonusGold, _NumberFormat($totalBonusG))
		GUICtrlSetData($lblTotalBonusGold1, "B.")
	Else
		GUICtrlSetData($lblTotalBonusGold1, "")
	EndIf

	GUICtrlSetData($lblElixirTotal, _NumberFormat($totalLootE))
	;bonus LootBonusElixir
	If $totalBonusE <> "" Then
		GUICtrlSetData($lblTotalBonusElixir, _NumberFormat($totalBonusE))
		GUICtrlSetData($lblTotalBonusElixir1, "B.")
	Else
		GUICtrlSetData($lblTotalBonusElixir1, "")
	EndIf

	If $totalLootD <> "" Then
		GUICtrlSetState($picDarkLoot, $GUI_SHOW)
		GUICtrlSetData($lblDarkTotal, _NumberFormat($totalLootD))
		;bonus LootBonusDarkElixir
		If $totalBonusD <> "" Then
			GUICtrlSetData($lblTotalBonusDark, _NumberFormat($totalBonusD))
			GUICtrlSetData($lblTotalBonusDark1, "B.")
		Else
			GUICtrlSetData($lblTotalBonusDark1, "")
		EndIf
	Else
		GUICtrlSetState($picDarkLoot, $GUI_HIDE)
	EndIf
	GUICtrlSetData($lblTrophyLoot, _NumberFormat($totalLootT))

	;
	; GAIN STATS GROUP
	;

	; Gain  / HOUR stats
	GUICtrlSetData($lblGoldGain, _NumberFormat($gainLootG))
	GUICtrlSetData($lblHourlyStatsGold, StringFormat("%.1f", $gainLootG / Int(TimerDiff($sTimer)) * 3600) & getLocaleString("txtKPerH"))

	GUICtrlSetData($lblElixirGain, _NumberFormat($gainLootE))
	GUICtrlSetData($lblHourlyStatsElixir, StringFormat("%.1f", $gainLootE / Int(TimerDiff($sTimer)) * 3600) & getLocaleString("txtKPerH"))

	If $DarkStart <> "" Then
		GUICtrlSetState($picHourlyStatsDark, $GUI_SHOW)
		GUICtrlSetData($lblDarkGain, _NumberFormat($gainLootD))
		GUICtrlSetData($lblHourlyStatsDark, StringFormat("%d", $gainLootD / Int(TimerDiff($sTimer)) * 3600 * 1000) & getLocaleString("txtPerH"))
	EndIf

	GUICtrlSetData($lblHourlyStatsTrophy, StringFormat("%.2f", $totalLootT / Int(TimerDiff($sTimer)) * 3600 * 1000) & getLocaleString("txtKPerH"))

	;prevent leaking
	$lootGold = 0
	$lootElixir = 0
	$lootDarkElixir = 0

	$BonusLeagueG = 0
	$BonusLeagueE = 0
	$BonusLeagueD = 0

	$lootTrophies = 0

EndFunc   ;==>ReportLastTotal
