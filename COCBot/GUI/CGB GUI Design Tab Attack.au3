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
; Attack Basics Tab
;~ -------------------------------------------------------------

$tabAttack = GUICtrlCreateTabItem(getLocaleString("tabAttack"))
	Local $x = 30, $y = 150
	$grpDeadBaseDeploy = GUICtrlCreateGroup(getLocaleString("grpDeadBaseDeploy"), $x - 20, $y - 20, 225, 295);95)
		$lblDBDeploy = GUICtrlCreateLabel(getLocaleString("lbDeploy"), $x, $y + 5, -1, -1)
		$cmbDBDeploy = GUICtrlCreateCombo("", $x + 55, $y, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1,getLocaleString("tipCmbDeploy", 1),getLocaleString("tipCmbDeployTitle") )
			GUICtrlSetData(-1, getLocaleString("cmbDBDeploy"), getLocaleString("cmbDBDeployDefault"))
		$y += 25
		$lblDBSelectTroop=GUICtrlCreateLabel(getLocaleString("lbSelectTroop"),$x, $y + 5, -1 , -1)
		$cmbDBSelectTroop=GUICtrlCreateCombo("", $x + 55, $y, 120, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, getLocaleString("cmbDBSelectTroop"), getLocaleString("cmbDBSelectTroopAll"))
		$y += 25
		$lblDBUnitDelay = GUICtrlCreateLabel(getLocaleString("lbUnitDelay"), $x, $y + 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
		$cmbDBUnitDelay = GUICtrlCreateCombo("", $x + 55, $y, 36, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$lblDBWaveDelay = GUICtrlCreateLabel(getLocaleString("lbWaveDelay"), $x + 105, $y + 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
		$cmbDBWaveDelay = GUICtrlCreateCombo("", $x + 140, $y, 36, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$y += 22
		$chkDBRandomSpeedAtk = GUICtrlCreateCheckbox(getLocaleString("chkRandomSpeedAtk"), $x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
			GUICtrlSetOnEvent(-1, "chkDBRandomSpeedAtk")
	$y = 250
		$chkDBSmartAttackRedArea = GUICtrlCreateCheckbox(getLocaleString("chkSmartAttackRedArea"), $x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkSmartAttackRedArea"))
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkDBSmartAttackRedArea")
		$y += 22
		$lblDBSmartDeploy = GUICtrlCreateLabel(getLocaleString("lbSmartDeploy"), $x, $y + 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipSmartDeploy",1), getLocaleString("tipSmartDeployTitle"))
		$cmbDBSmartDeploy = GUICtrlCreateCombo("", $x + 55, $y, 120, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, getLocaleString("cmbDBSmartDeploy"), getLocaleString("cmbDBSmartDeployDefault"))
			GUICtrlSetTip(-1, getLocaleString("tipSmartDeploy",1), getLocaleString("tipSmartDeployTitle"))
		$y += 26
		$chkDbAttackNearGoldMine = GUICtrlCreateCheckbox(getLocaleString("chkAttackNearGoldMine"), $x + 20, $y, 17, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearGoldMine"))
		$picDBAttackNearGoldMine = GUICtrlCreateIcon($pIconLib, $eIcnMine, $x + 40 , $y - 3 , 24, 24)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearGoldMine"))
		$x += 75
		$chkDBAttackNearElixirCollector = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearElixirCollector"))
		$picDBAttackNearElixirCollector = GUICtrlCreateIcon($pIconLib, $eIcnCollector, $x + 20 , $y - 3 , 24, 24)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearElixirCollector"))
 		$x += 55
  		$chkDBAttackNearDarkElixirDrill = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
 			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearDarkElixirDrill"))
		$picDBAttackNearDarkElixirDrill = GUICtrlCreateIcon($pIconLib, $eIcnDrill, $x + 20 , $y - 3, 24, 24)
 			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearDarkElixirDrill"))
	Local $x = 30, $y = 335
		GUICtrlCreateIcon($pIconLib, $eIcnKing, $x , $y, 24, 24)
		$chkDBKingAttack = GUICtrlCreateCheckbox(getLocaleString("chkKingAttack"), $x + 35, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkKingAttack"))
		$y += 27
		GUICtrlCreateIcon($pIconLib, $eIcnQueen, $x, $y, 24, 24)
		$chkDBQueenAttack = GUICtrlCreateCheckbox(getLocaleString("chkQueenAttack"), $x + 35, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkQueenAttack"))
		$y += 27
		GUICtrlCreateIcon($pIconLib, $eIcnCC, $x, $y, 24, 24)
		$chkDBDropCC = GUICtrlCreateCheckbox(getLocaleString("chkDropCC"), $x + 35, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkDropCC"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 260, $y = 150
	$grpLiveBaseDeploy = GUICtrlCreateGroup(getLocaleString("grpLiveBaseDeploy"), $x - 20, $y - 20, 220, 295);95)
		$lblABDeploy = GUICtrlCreateLabel(getLocaleString("lbDeploy"), $x, $y + 5, -1, -1)
		$cmbABDeploy = GUICtrlCreateCombo("", $x + 55, $y, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbDeploy", 1), getLocaleString("tipCmbDeployTitle"))
			GUICtrlSetData(-1, getLocaleString("cmbLBDeploy"), getLocaleString("cmbLBDeployDefault"))
		$y += 25
		$lblABSelectTroop=GUICtrlCreateLabel(getLocaleString("lbSelectTroop"),$x, $y + 5, -1 , -1)
		$cmbABSelectTroop=GUICtrlCreateCombo("", $x + 55, $y, 120, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, getLocaleString("cmbLBSelectTroop"), getLocaleString("cmbLBSelectTroopAll"))
		$y += 25
		$lblABUnitDelay = GUICtrlCreateLabel(getLocaleString("lbUnitDelay"), $x, $y + 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
		$cmbABUnitDelay = GUICtrlCreateCombo("", $x + 55, $y, 36, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$lblABWaveDelay = GUICtrlCreateLabel(getLocaleString("lbWaveDelay"), $x + 105, $y + 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
		$cmbABWaveDelay = GUICtrlCreateCombo("", $x + 140, $y, 36, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$y += 22
		$chkABRandomSpeedAtk = GUICtrlCreateCheckbox(getLocaleString("chkRandomSpeedAtk"), $x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbUnitDelay", 1))
			GUICtrlSetOnEvent(-1, "chkABRandomSpeedAtk")
	$y = 250
		$chkABSmartAttackRedArea = GUICtrlCreateCheckbox(getLocaleString("chkSmartAttackRedArea"), $x, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkSmartAttackRedArea"))
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkABSmartAttackRedArea")
		$y += 22
		$lblABSmartDeploy = GUICtrlCreateLabel(getLocaleString("lbSmartDeploy"), $x, $y + 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipSmartDeploy",1), getLocaleString("tipSmartDeployTitle"))
		$cmbABSmartDeploy = GUICtrlCreateCombo("", $x + 55, $y, 120, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, getLocaleString("cmbLBSmartDeploy"), getLocaleString("cmbLBSmartDeployDefault"))
			GUICtrlSetTip(-1, getLocaleString("tipSmartDeploy",1), getLocaleString("tipSmartDeployTitle"))
		$y += 26
		$chkABAttackNearGoldMine = GUICtrlCreateCheckbox("", $x + 20, $y, 17, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearGoldMine"))
		$picABAttackNearGoldMine = GUICtrlCreateIcon($pIconLib, $eIcnMine, $x + 40 , $y - 3 , 24, 24)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearGoldMine"))
		$x += 75
		$chkABAttackNearElixirCollector = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearElixirCollector"))
		$picABAttackNearElixirCollector = GUICtrlCreateIcon($pIconLib, $eIcnCollector, $x + 20 , $y - 3 , 24, 24)
			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearElixirCollector"))
 		$x += 55
  		$chkABAttackNearDarkElixirDrill = GUICtrlCreateCheckbox("", $x, $y, 17, 17)
 			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearDarkElixirDrill"))
		$picABAttackNearDarkElixirDrill = GUICtrlCreateIcon($pIconLib, $eIcnDrill, $x + 20 , $y - 3, 24, 24)
 			GUICtrlSetTip(-1, getLocaleString("tipChkAttackNearDarkElixirDrill"))
	$x -= 70
	$y = 335
		GUICtrlCreateIcon($pIconLib, $eIcnKing, $x, $y, 24, 24)
		$chkABKingAttack = GUICtrlCreateCheckbox(getLocaleString("chkKingAttack"), $x + 35, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkKingAttack"))
		$y += 27
		GUICtrlCreateIcon($pIconLib, $eIcnQueen, $x, $y, 24, 24)
		$chkABQueenAttack = GUICtrlCreateCheckbox(getLocaleString("chkQueenAttack"), $x + 35, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkQueenAttack"))
		$y += 27
		GUICtrlCreateIcon($pIconLib, $eIcnCC, $x, $y, 24, 24)
		$chkABDropCC = GUICtrlCreateCheckbox(getLocaleString("chkDropCC"), $x + 35, $y, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipChkDropCC"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 200, $y = 345
	$grpClanCastleBal = GUICtrlCreateGroup(getLocaleString("grpClanCastleBal"), $x - 20, $y - 20, 110, 100)
		GUICtrlCreateLabel("", $x - 18, $y - 7, 106, 85) ; fake label to hide group border from DB and LB setting groups
		GUICtrlSetBkColor (-1, $COLOR_WHITE)
		GUICtrlSetState (-1, $GUI_DISABLE)
		GUICtrlCreateIcon($pIconLib, $eIcnCC, $x + 25, $y - 5, 24, 24)
		$y += 21
		$chkUseCCBalanced = GUICtrlCreateCheckbox(getLocaleString("chkUseCCBalanced"), $x - 5, $y, -1, -1)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetTip(-1, getLocaleString("tipChkUseCCBalanced"))
			GUICtrlSetOnEvent(-1, "chkBalanceDR")
		$y += 25
		$cmbCCDonated = GUICtrlCreateCombo("",  $x - 5, $y, 30, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbCCDonated"))
			GUICtrlSetData(-1, "1|2|3|4|5", "1")
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "cmbBalanceDR")
		$lblDRRatio = GUICtrlCreateLabel("/", $x + 31, $y + 5, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipLbDRRatio",1))
		$cmbCCReceived = GUICtrlCreateCombo("", $x + 44, $y, 30, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, getLocaleString("tipCmbCCReceived"))
			GUICtrlSetData(-1, "1|2|3|4|5", "1")
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "cmbBalanceDR")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 450
	$grpRoyalAbilities = GUICtrlCreateGroup(getLocaleString("grpRoyalAbilities"), $x - 20, $y - 20, 450, 75)
		GUICtrlCreatePic (@ScriptDir & "\Icons\KingAbility.jpg", $x, $y - 3, 30, 47)
		GUICtrlCreatePic (@ScriptDir & "\Icons\QueenAbility.jpg", $x + 30, $y - 3, 30, 47)
		$x += 75
		$radManAbilities = GUICtrlCreateRadio(getLocaleString("radManAbilities"), $x, $y + 3, -1, -1)
			GUICtrlSetTip(-1, getLocaleString("tipRadManAbilities",1))
			GUICtrlSetState(-1, $GUI_CHECKED)
		$radAutoAbilities = GUICtrlCreateRadio(getLocaleString("radAutoAbilities"), $x, $y + 25, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipRadAutoAbilities",1))
		$txtManAbilities = GUICtrlCreateInput("9", $x + 200, $y + 2, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipManAbilities"))
			GUICtrlSetLimit(-1, 2)
		$lblRoyalAbilitiesSec = GUICtrlCreateLabel(getLocaleString("lbLoyalAbilitiesSec"), $x + 235, $y + 7, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
