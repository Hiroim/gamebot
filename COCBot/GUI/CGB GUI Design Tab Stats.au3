; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GKevinOD (2014)
; Modified ......: DkEd, Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

;~ -------------------------------------------------------------
;~ This dummy is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;~ -------------------------------------------------------------
Global $LastControlToHide = GUICtrlCreateDummy()
Global $iPrevState[$LastControlToHide + 1]
;~ -------------------------------------------------------------

;~ -------------------------------------------------------------
;~ Stats Tab
;~ -------------------------------------------------------------
$tabStats = GUICtrlCreateTabItem(getLocaleString("tabStats"))
Local $x = 30, $y = 150
	$grpResourceOnStart = GUICtrlCreateGroup(getLocaleString("grpResourceOnStart"), $x - 20, $y - 20, 108, 133)
		$lblResultStatsTemp = GUICtrlCreateLabel(getLocaleString("lblResultStatsTemp",1), $x - 5, $y + 5, 100, 65, BitOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
		$lblResultGoldStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipResultGoldStart"))
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblResultElixirStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipResultElixirStart"))
		$y += 30
		$picResultDEStart = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65, $y, 16, 16)
		$lblResultDEStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipResultDEStart"))
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblResultTrophyStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipResultTrophyStart"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 113
	$y = 150
	$grpLastAttack = GUICtrlCreateGroup(getLocaleString("grpLastAttack"), $x - 20, $y - 20, 108, 133)
		$lblLastAttackTemp = GUICtrlCreateLabel(getLocaleString("lblLastAttackTemp",1), $x - 5, $y + 5, 100, 65, BitOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
		$lblGoldLastAttack = GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
        $lblLootBonusGold = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
        $lblLootBonusGold1 = GUICtrlCreateLabel("", $x + 60, $y + 11, 10, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipGoldLastAttack"))
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblElixirLastAttack = GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
        $lblLootBonusElixir = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
        $lblLootBonusElixir1 = GUICtrlCreateLabel("", $x + 60, $y + 11, 10, 17, $SS_LEFT)
			GUICtrlSetTip(-1, getLocaleString("tipElixirLastAttack"))
		$y += 30
		$picDarkLastAttack = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65, $y, 16, 16)
		$lblDarkLastAttack = GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
        $lblLootBonusDarkElixir = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
        $lblLootBonusDarkElixir1 = GUICtrlCreateLabel("", $x + 60, $y + 11, 10, 17, $SS_LEFT)
			GUICtrlSetTip(-1, getLocaleString("tipDELastAttack"))
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblTrophyLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipTrophyLastAttack"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 114
	$y = 150
    $grpTotalLoot = GUICtrlCreateGroup(getLocaleString("grpTotalLoot"), $x - 20, $y - 20, 108, 133)
		$lblTotalLootTemp = GUICtrlCreateLabel(getLocaleString("lblTotalLootTemp",1), $x - 5, $y + 5, 100, 65, BitOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
		$lblGoldTotal =  GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipGoldLoot"))
		$lblTotalBonusGold = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
        $lblTotalBonusGold1 = GUICtrlCreateLabel("", $x + 60, $y + 11, 10, 17, $SS_LEFT)
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblElixirTotal =  GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipElixirLoot"))
		$lblTotalBonusElixir = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
        $lblTotalBonusElixir1 = GUICtrlCreateLabel("", $x + 60, $y + 11, 10, 17, $SS_LEFT)
		$y += 30
		$picDarkLoot = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 66, $y, 16, 16)
        $lblDarkTotal = GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipDELoot"))
        $lblTotalBonusDark = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
        $lblTotalBonusDark1 = GUICtrlCreateLabel("", $x + 60, $y + 11, 10, 17, $SS_LEFT)
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblTrophyLoot = GUICtrlCreateLabel("", $x - 3, $y + 2, 55, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipTrophyLoot"))
    GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 114
	$y = 150
	$grpHourlyStats = GUICtrlCreateGroup(getLocaleString("grpHourlyStats"), $x - 20, $y - 20, 108, 133)
		$lblHourlyStatsTemp = GUICtrlCreateLabel(getLocaleString("lblHourlyStatsTemp",1), $x - 5, $y + 5, 100, 65, BitOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
        $lblGoldGain = GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipGoldGain"))
		$lblHourlyStatsGold  = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipHourlyStatsGold"))
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblElixirGain = GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipElixirGain"))
		$lblHourlyStatsElixir = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipHourlyStatsElixir"))
		$y += 30
		$picHourlyStatsDark = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65, $y, 16, 16)
		$lblDarkGain = GUICtrlCreateLabel("", $x - 3, $y - 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipDarkGain"))
		$lblHourlyStatsDark = GUICtrlCreateLabel("", $x - 3, $y + 11, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipHourlyStatsDark"))
		$y += 30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblHourlyStatsTrophy = GUICtrlCreateLabel("", $x - 10, $y + 2, 65, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipHourlyStatsTrophy"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)
#cs
	$x = 400
	$y = 305
	$btnMoreStats = GUICtrlCreateButton (getLocaleString("btnMoreStats"), $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=25
	$btnExportCSV = GUICtrlCreateButton (getLocaleString("btnExportCSV"), $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
    $y +=25
    $btnLoots = GUICtrlCreateButton (getLocaleString("btnLoots"), $x, $y, 60,21)
        GUICtrlSetOnEvent(-1, "btnLoots")
    $y +=25
    $btnLogs = GUICtrlCreateButton (getLocaleString("btnLogs"), $x, $y, 60,21)
        GUICtrlSetOnEvent(-1, "btnLogs")
#ce

	$x = 30
	$y = 290
	$grpStatsMisc = GUICtrlCreateGroup(getLocaleString("grpStatsMisc"), $x - 20, $y - 20, 450, 60)
		$y -= 2
		GUICtrlCreateIcon ($pIconLib, $eIcnTH1, $x - 10, $y + 7, 24, 24)
		GUICtrlCreateIcon ($pIconLib, $eIcnTH10, $x + 16, $y + 7, 24, 24)
        $lblvillagesattacked = GUICtrlCreateLabel(getLocaleString("lblvillagesattacked"), $x + 45, $y + 2, -1, 17)
        $lblresultvillagesattacked = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("lblresultvillagesattacked"))
		$y += 17
        $lblvillagesskipped = GUICtrlCreateLabel(getLocaleString("lblvillagesskipped"), $x + 45, $y + 2, -1, 17)
        $lblresultvillagesskipped = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipresultvillagesskipped"))
		$x = 185
		$y = 290
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x, $y, 16, 16)
        $lbltrophiesdropped = GUICtrlCreateLabel(getLocaleString("lbltrophiesdropped"), $x + 20, $y + 2, -1, 17)
        $lblresulttrophiesdropped = GUICtrlCreateLabel("0", $x + 80, $y + 2, 30, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipresulttrophiesdropped"))
        $y += 17
        GUICtrlCreateIcon ($pIconLib, $eIcnHourGlass, $x, $y, 16, 16)
        $lblruntime = GUICtrlCreateLabel(getLocaleString("lblruntime"), $x + 20, $y + 2, -1, 17)
        $lblresultruntime = GUICtrlCreateLabel("00:00:00", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipresultruntime"))
		$x = 330
		$y = 290
		GUICtrlCreateIcon ($pIconLib, $eIcnWall, $x - 7, $y + 7, 24, 24)
        $lblwallbygold = GUICtrlCreateLabel(getLocaleString("lblwallbygold"), $x + 20, $y + 2, -1, 17)
		$lblWallgoldmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipWallgoldmake"))
		$y += 17
		$lblwallbyelixir = GUICtrlCreateLabel(getLocaleString("lblwallbyelixir"), $x + 20, $y + 2, -1, 17)
		$lblWallelixirmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipWallelixirmake"))
        ;$lbloutofsync = GUICtrlCreateLabel("Out Of Sync :", 260, 263, 100, 17) ; another stats next post
        ;$lblresultoutofsync = GUICtrlCreateLabel("0", 380, 263, 60, 17, $SS_RIGHT) ; another stats next post
	GUICtrlCreateGroup("", -99, -99, 1, 1)
