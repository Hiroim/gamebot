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
;~ End Battle
;~ -------------------------------------------------------------
$tabEndBattle = GUICtrlCreateTabItem(getLocaleString("tabEndBattle"))
   Local $x = 30, $y = 150
	$grpBattleOptions = GUICtrlCreateGroup(getLocaleString("grpBattleOptions"), $x - 20, $y - 20, 450, 170)
		$chkTimeStopAtk = GUICtrlCreateCheckbox(getLocaleString("chkTimeStopAtk"),$x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkTimeStopAtk",1))
			GUICtrlSetOnEvent(-1, "chkTimeStopAtk")
			GUICtrlSetState(-1, $GUI_CHECKED)
		$txtTimeStopAtk = GUICtrlCreateInput("20", $x + 180, $y + 1, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			;GUICtrlSetData(-1, 10) ; default value
			GUICtrlSetTip(-1, getLocaleString("tipChkTimeStopAtk",1))
			GUICtrlSetLimit(-1, 2)
		$lblTimeStopAtk = GUICtrlCreateLabel(getLocaleString("lbTimeStopAtk"), $x + 215, $y + 3, -1, -1)
   $y += 25
		$chkTimeStopAtk2 = GUICtrlCreateCheckbox(getLocaleString("chkTimeStopAtk"),$x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkTimeStopAtk",1))
			GUICtrlSetOnEvent(-1, "chkTimeStopAtk2")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
		$txtTimeStopAtk2 = GUICtrlCreateInput("5", $x + 180, $y + 1, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipChkTimeStopAtk",1))
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblTimeStopAtk2 = GUICtrlCreateLabel(getLocaleString("lbTimeStopAtk"), $x + 215, $y + 3, -1, -1)
	$y += 21
		$lblMinRerourcesAtk2 = GUICtrlCreateLabel(getLocaleString("lbMinResourcesAtk"), $x + 20 , $y + 2, -1, -1)
		$lblMinGoldStopAtk2 = GUICtrlCreateLabel("<", $x + 150 , $y + 2, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbMinGoldAtk"))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtMinGoldStopAtk2 = GUICtrlCreateInput("2000", $x + 160, $y , 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipLbMinGoldAtk"))
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picMinGoldStopAtk2 = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 212, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipLbMinGoldAtk"))

		$lblMinElixirStopAtk2 = GUICtrlCreateLabel(", <", $x + 230, $y + 2, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbMinElixirAtk"))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtMinElixirStopAtk2 = GUICtrlCreateInput("2000", $x + 245, $y , 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipLbMinElixirAtk"))
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picMinElixirStopAtk2 = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 297, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipLbMinElixirAtk"))

		$lblMinDarkElixirStopAtk2 = GUICtrlCreateLabel(getLocaleString("txtAnd"), $x + 320 , $y +2, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbMinDarkAtk"))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtMinDarkElixirStopAtk2 = GUICtrlCreateInput("50", $x + 350, $y , 40, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipLbMinDarkAtk"))
			GUICtrlSetLimit(-1, 5)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picMinDarkElixirStopAtk2 = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 392, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipLbMinDarkAtk"))
	$y += 20
		$chkEndNoResources = GUICtrlCreateCheckbox(getLocaleString("chkEndNoResources"), $x , $y , -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkEndNoResources"))
			GUICtrlSetState(-1, $GUI_ENABLE)
	$y += 30
		$chkEndOneStar = GUICtrlCreateCheckbox(getLocaleString("chkEndOneStar"), $x, $y , -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkEndOneStar"))
			GUICtrlSetState(-1, $GUI_ENABLE)
		$picEndOneStar = GUICtrlCreateIcon($pIconLib, $eIcnSilverStar, $x + 145, $y + 2, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipChkEndOneStar"))
	$y += 20
		$chkEndTwoStars = GUICtrlCreateCheckbox(getLocaleString("chkEndTwoStar"), $x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkEndTwoStar"))
			GUICtrlSetState(-1, $GUI_ENABLE)
		$picEndTwoStar = GUICtrlCreateIcon($pIconLib, $eIcnSilverStar, $x + 145, $y + 2, 16, 16)
		$picEndTwoStar2 = GUICtrlCreateIcon($pIconLib, $eIcnSilverStar, $x + 162, $y + 2, 16, 16)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 325
	$grpLootSnapshot = GUICtrlCreateGroup(getLocaleString("grpLootSnapshot"), $x - 20, $y - 20, 450, 50)
		$chkTakeLootSS = GUICtrlCreateCheckbox(getLocaleString("chkTakeLootSS"), $x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkTakeLootSS"))
			GUICtrlSetState(-1, $GUI_CHECKED)
		$chkScreenshotLootInfo = GUICtrlCreateCheckbox(getLocaleString("chkScreenshotLootInfo"), $x + 200 , $y , -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkScreenshotLootInfo"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = 30, $y = 380
	$grpResources = GUICtrlCreateGroup(getLocaleString("grpResources"), $x - 20, $y - 20, 450, 145)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$chkShareAttack = GUICtrlCreateCheckbox(getLocaleString("chkShareAttack"), $x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkShareAttack"))
			GUICtrlSetOnEvent(-1, "chkShareAttack")
		$y += 30
		$lblShareMinGold = GUICtrlCreateLabel(getLocaleString("lbShareMinGold"), $x + 20 , $y, -1, -1)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtShareMinGold = GUICtrlCreateInput("300000", $x + 120, $y - 2, 61, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipLbShareMinGold"))
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picShareLootGold = GUICtrlCreateIcon($pIconLib, $eIcnGold, $x + 182, $y, 16, 16)
		$y += 22
		$lblShareMinElixir = GUICtrlCreateLabel(">", $x + 112, $y, -1, -1)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtShareMinElixir = GUICtrlCreateInput("300000", $x + 120, $y - 2, 61, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipShareMinElixir"))
			GUICtrlSetLimit(-1, 6)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picShareLootElixir = GUICtrlCreateIcon($pIconLib, $eIcnElixir, $x + 182, $y, 16, 16)
		$y += 22
		$lblShareMinDark = GUICtrlCreateLabel(">", $x + 112, $y, -1, -1)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtShareMinDark = GUICtrlCreateInput("0", $x + 120, $y - 2, 61, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipShareMinDark"))
			GUICtrlSetLimit(-1, 5)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$picShareLootDarkElixir = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 182, $y, 16, 16)
	Local $x = 240, $y = 380
		$lblShareMessage = GUICtrlCreateLabel(getLocaleString("lbShareMessage"), $x , $y -2 , -1, -1)
			GUICtrlSetState(-1, $GUI_DISABLE)
	    $y += 27
		$txtShareMessage = GUICtrlCreateEdit("", $x, $y - 10 , 205, 80, BitOR($ES_WANTRETURN, $ES_CENTER, $ES_AUTOVSCROLL))
			GUICtrlSetData(-1, getLocaleString("ShareMessage",1))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetTip(-1, getLocaleString("tipShareMessage"))
	    $y += 73
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
