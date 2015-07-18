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
;~ Troops Tab
;~ -------------------------------------------------------------
$tabTroops = GUICtrlCreateTabItem(getLocaleString("tabTroops"))
	Local $x = 30, $y = 150
	$grpTroopComp = GUICtrlCreateGroup(getLocaleString("grpTroopComp"), $x - 20, $y - 20, 222, 55)
		$cmbTroopComp = GUICtrlCreateCombo("", $x - 5, $y, 190, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbTroopComp",1))
			GUICtrlSetOnEvent(-1, "cmbTroopComp")
			GUICtrlSetData(-1, getLocaleString("cmbTroopComp"), getLocaleString("cmbTroopCompDefault"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 227
	$grpBarrackMode = GUICtrlCreateGroup(getLocaleString("grpBarrackMode"), $x - 20, $y -20, 223, 75)
		$lblBarrack1 = GUICtrlCreateLabel("1:", $x - 5, $y + 5, -1, -1)
		$cmbBarrack1 = GUICtrlCreateCombo("", $x + 10, $y, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbBarrack1"))
			GUICtrlSetData(-1, getLocaleString("cmbBarrack"), getLocaleString("cmbBarrackDefault1"))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y += 2
		$lblBarrack2 = GUICtrlCreateLabel("2:", $x - 5, $y + 26, -1, -1)
		$cmbBarrack2 = GUICtrlCreateCombo("", $x + 10, $y + 21, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbBarrack2"))
			GUICtrlSetData(-1, getLocaleString("cmbBarrack"), getLocaleString("cmbBarrackDefault2"))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y -= 2
		$lblBarrack3 = GUICtrlCreateLabel("3:", $x + 100, $y + 5, -1, -1)
		$cmbBarrack3 = GUICtrlCreateCombo("", $x + 115, $y, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbBarrack3"))
			GUICtrlSetData(-1, getLocaleString("cmbBarrack"), getLocaleString("cmbBarrackDefault2"))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y += 2
		$lblBarrack4 = GUICtrlCreateLabel("4:", $x + 100, $y + 26, -1, -1)
		$cmbBarrack4 = GUICtrlCreateCombo("", $x + 115, $y + 21, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbBarrack4"))
			GUICtrlSetData(-1, getLocaleString("cmbBarrack"), getLocaleString("cmbBarrackDefault2"))
			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y = 230
	$grpBoosterOptions = GUICtrlCreateGroup(getLocaleString("grpBoosterOptions"), $x - 20, $y - 20, 223, 95)
	$y -= 5
		GUICtrlCreateIcon ($pIconLib, $eIcnTroops, $x, $y + 2, 16, 16)
	$lblFullTroop = GUICtrlCreateLabel(getLocaleString("lblFullTroop"),$x + 25, $y + 5, -1, 17)
	$txtFullTroop = GUICtrlCreateInput("100",  $x + 150, $y, 35, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		GUICtrlSetTip(-1, getLocaleString("tipFullTroop"))
		GUICtrlSetLimit(-1, 3)
	$lblFullTroop = GUICtrlCreateLabel("%",$x + 188, $y + 5, -1, 17)
	$y += 25
		GUICtrlCreateIcon ($pIconLib, $eIcnBarrackBoost, $x, $y + 2, 16, 16)
	$lblBoostBarracks = GUICtrlCreateLabel(getLocaleString("lblBoostBarracks"), $x + 25, $y + 5, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipBoostBarracks"))
	$cmbBoostBarracks = GUICtrlCreateCombo("", $x + 150, $y, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0|1|2|3|4|5", "0")
		GUICtrlSetTip(-1, getLocaleString("tipBoostBarracks"))
	$y += 25
	GUICtrlCreateIcon ($pIconLib, $eIcnSpellFactoryBoost, $x, $y + 2, 16, 16)
	$lblBoostSpellFactory = GUICtrlCreateLabel(getLocaleString("lblBoostSpellFactory"), $x + 25, $y + 5, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipBoostSpellFactory"))
	$cmbBoostSpellFactory = GUICtrlCreateCombo("", $x + 150, $y, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0|1|2|3|4|5", "0")
		GUICtrlSetTip(-1, getLocaleString("tipBoostSpellFactory"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 210
	$grpTroops = GUICtrlCreateGroup(getLocaleString("grpTroops"), $x - 20, $y - 20, 222, 115)
		$y +=5
		GUICtrlCreateIcon ($pIconLib, $eIcnBarbarian, $x - 5, $y - 5, 24, 24)
		$lblBarbarians = GUICtrlCreateLabel(getLocaleString("lblNumBarbarians"), $x + 25, $y, -1, -1)
		$txtNumBarb = GUICtrlCreateInput("50", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipNumBarbarians"))
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentBarbarians = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 25
		GUICtrlCreateIcon ($pIconLib, $eIcnArcher, $x - 5, $y - 5, 24, 24)
		$lblArchers = GUICtrlCreateLabel(getLocaleString("lblNumArchers"), $x + 25, $y, -1, -1)
		$txtNumArch = GUICtrlCreateInput("50", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipNumArchers"))
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentArchers = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 25
		GUICtrlCreateIcon ($pIconLib, $eIcnGoblin, $x - 5, $y - 5, 24, 24)
		$lblGoblins = GUICtrlCreateLabel(getLocaleString("lblNumGoblins"), $x + 25, $y, -1, -1)
		$txtNumGobl = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipNumGoblins"))
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentGoblins = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 25
		$lblTotal = GUICtrlCreateLabel(getLocaleString("lblTotal"), $x + 95, $y - 5, -1, -1, $SS_RIGHT)
		$lblTotalCount = GUICtrlCreateLabel("100", $x + 130, $y - 5, 55, 15, $SS_CENTER)
			GUICtrlSetBkColor (-1, $COLOR_MONEYGREEN) ;lime, moneygreen
		$lblPercentTotal = GUICtrlCreateLabel("%", $x + 188, $y - 5, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 330
	$grpOtherTroops = GUICtrlCreateGroup(getLocaleString("grpOtherTroops"), $x - 20, $y - 20, 222, 195)
		GUICtrlCreateIcon ($pIconLib, $eIcnGiant, $x - 5, $y - 5, 24, 24)
		$lblGiants = GUICtrlCreateLabel(getLocaleString("lblNumGiants"), $x + 25, $y, -1, -1)
		$txtNumGiant = GUICtrlCreateInput("8", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumGiants"))
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnWallBreaker, $x - 5, $y - 5, 24, 24)
		$lblWallBreakers = GUICtrlCreateLabel(getLocaleString("lblNumWallBreakers"), $x + 25, $y, -1, -1)
		$txtNumWall = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumWallBreakers"))
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnBalloon, $x - 5, $y - 5, 24, 24)
		$lblBalloons = GUICtrlCreateLabel(getLocaleString("lblNumBalloons"), $x + 25, $y, -1, -1)
		$txtNumBall = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumBalloons"))
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnWizard, $x - 5, $y - 5, 24, 24)
		$lblWizards = GUICtrlCreateLabel(getLocaleString("lblNumWizards"), $x + 25, $y, -1, -1)
		$txtNumWiza = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumWizards"))
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnHealer, $x - 5, $y - 5, 24, 24)
		$lblHealers = GUICtrlCreateLabel(getLocaleString("lblNumHealers"), $x + 25, $y, -1, -1)
		$txtNumHeal = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumHealers"))
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnDragon, $x - 5, $y - 5, 24, 24)
		$lblDragons = GUICtrlCreateLabel(getLocaleString("lblNumDragons"), $x + 25, $y, -1, -1)
		$txtNumDrag = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumDragons"))
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnPekka, $x - 5, $y - 5, 24, 24)
		$lblPekka = GUICtrlCreateLabel(getLocaleString("lblNumPekka"), $x + 25, $y, -1, -1)
		$txtNumPekk = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumPekka"))
			GUICtrlSetLimit(-1, 3)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x +=  227
	$y = 330
	$grpDarkTroops = GUICtrlCreateGroup(getLocaleString("grpDarkTroops"), $x - 20, $y - 20, 223, 195)
		GUICtrlCreateIcon ($pIconLib, $eIcnMinion, $x - 5, $y - 5, 24, 24)
		$lblMinion = GUICtrlCreateLabel(getLocaleString("lblNumMinion"), $x + 25, $y, -1, -1)
		$txtNumMini = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumMinions"))
			GUICtrlSetLimit(-1, 3)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnHogRider, $x - 5, $y - 5, 24, 24)
		$lblHogRiders = GUICtrlCreateLabel(getLocaleString("lblNumHogRiders"), $x + 25, $y, -1, -1)
		$txtNumHogs = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumHogRiders"))
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnValkyrie, $x - 5, $y - 5, 24, 24)
		$lblValkyries = GUICtrlCreateLabel(getLocaleString("lblNumValkyries"), $x + 25, $y, -1, -1)
		$txtNumValk = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumValkyries"))
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnGolem, $x - 5, $y - 5, 24, 24)
		$lblGolems = GUICtrlCreateLabel(getLocaleString("lblNumGolems"), $x + 25, $y, -1, -1)
		$txtNumGole = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumGolems"))
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnWitch, $x - 5, $y - 5, 24, 24)
		$lblWitches = GUICtrlCreateLabel(getLocaleString("lblNumWitches"), $x + 25, $y, -1, -1)
		$txtNumWitc = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumWitches"))
			GUICtrlSetLimit(-1, 2)
		$y +=25
		GUICtrlCreateIcon ($pIconLib, $eIcnLavaHound, $x - 5, $y - 5, 24, 24)
		$lblLavaHounds = GUICtrlCreateLabel(getLocaleString("lblNumLavaHounds"), $x + 25, $y, -1, -1)
		$txtNumLava = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, getLocaleString("tipNumLavaHounds"))
			GUICtrlSetLimit(-1, 2)

	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
