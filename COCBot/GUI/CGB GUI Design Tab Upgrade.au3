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
; Upgrades Tab
;~ -------------------------------------------------------------

$tabUpgrades = GUICtrlCreateTabItem(getLocaleString("tabUpgrades"))
Local $x = 30, $y = 150
	$Laboratory = GUICtrlCreateGroup(getLocaleString("lblLaboratory"), $x - 20, $y - 20, 450, 65)
		GUICtrlCreateIcon($pIconLib, $eIcnLaboratory, $x, $y, 32, 32)
		$chkLab = GUICtrlCreateCheckbox(getLocaleString("chkLab"), $x + 40, $y + 8, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkLab"))
			GUICtrlSetOnEvent(-1, "chkLab")
		Local $sNames = getLocaleString("sNames")
		$lblNextUpgrade = GUICtrlCreateLabel(getLocaleString("lblNextUpgrade"), $x + 205, $y + 12, -1, -1)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$cmbLaboratory = GUICtrlCreateCombo("", $x + 250, $y + 8, 125, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, $sNames, $aLabTroops[0][3])
			GUICtrlSetTip(-1, getLocaleString("tipCmbLaboratory",1))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "cmbLab")
		$icnLabUpgrade = GUICtrlCreateIcon($pIconLib, $eIcnLaboratory, $x + 380, $y, 32, 32)
			GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlCreateGroup("", -99, -99, 1, 1)
	Local $x = 260, $y = 150

	Local $x = 30, $y = 220
		$Heroes = GUICtrlCreateGroup(getLocaleString("lblHeroes"), $x - 20, $y - 20, 450, 45)
		$chkUpgradeKing = GUICtrlCreateCheckbox(getLocaleString("lblUpgradeKing"), $x + 40, $y - 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeKing"))
			GUICtrlSetOnEvent(-1, "ichkUpgradeKing")
		$chkUpgradeQueen = GUICtrlCreateCheckbox(getLocaleString("lblUpgradeQueen"), $x + 205, $y - 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeQueen"))
			GUICtrlSetOnEvent(-1, "ichkUpgradeQueen")
		GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 265
		$grpWalls = GUICtrlCreateGroup(getLocaleString("grpWalls"), $x - 20, $y - 20, 450, 120)
		GUICtrlCreateIcon ($pIconLib, $eIcnWall, $x - 12, $y - 6, 24, 24)
		$chkWalls = GUICtrlCreateCheckbox(getLocaleString("chkWalls"), $x + 18, $y-2, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkWalls"))
			GUICtrlSetState(-1, $GUI_ENABLE)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "chkWalls")
			_ArrayConcatenate($G, $B)
		$UseGold = GUICtrlCreateRadio(getLocaleString("UseGold"), $x + 35, $y + 16, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipUseGold",1))
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$UseElixir = GUICtrlCreateRadio(getLocaleString("UseElixir"), $x + 35, $y + 34, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipUseElixir",1))
			GUICtrlSetState(-1, $GUI_DISABLE)
		$UseElixirGold = GUICtrlCreateRadio(getLocaleString("UseElixirGold"), $x + 35, $y + 52, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipUseElixirGold",1))
			GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlCreateIcon ($pIconLib, $eIcnBuilder, $x - 12, $y + 72, 20, 20)
		$chkSaveWallBldr = GUICtrlCreateCheckbox(getLocaleString("chkSaveWallBldr"), $x+18, $y + 72, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkSaveWallBldr",1))
			GUICtrlSetState(-1, $GUI_ENABLE)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "chkSaveWallBldr")
		$x += 220
		$lblWalls = GUICtrlCreateLabel(getLocaleString("lblWalls"), $x, $y+2, -1, -1)
		$cmbWalls = GUICtrlCreateCombo("", $x + 120, $y, 51, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL), $WS_EX_RIGHT)
			GUICtrlSetTip(-1, getLocaleString("tipLblWalls",1))
			GUICtrlSetData(-1, "4   |5   |6   |7   |8   |9   |10   ", "4   ")
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "cmbWalls")
			_ArrayConcatenate($G, $C)
		$lblTxtWallCost = GUICtrlCreateLabel(getLocaleString("lblTxtWallCost"), $x,  $y + 25, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipTxtWallCost",1))
		$lblWallCost = GUICtrlCreateLabel("30 000", $x + 110, $y + 25, 50, -1, $SS_RIGHT)
			GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x, $y + 47, 16, 16)
		$WallMinGold = GUICtrlCreateLabel(getLocaleString("WallMinGold"), $x + 20, $y + 47, -1, -1)
		$txtWallMinGold = GUICtrlCreateInput("250000", $x + 110, $y + 45, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipWallMinGold",1))
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=2
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x, $y + 67, 16, 16)
		$WallMinElixir = GUICtrlCreateLabel(getLocaleString("WallMinElixir"), $x + 20, $y + 70, -1, -1)
		$txtWallMinElixir = GUICtrlCreateInput("250000", $x + 110, $y + 65, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipWallMinElixir",1))
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
