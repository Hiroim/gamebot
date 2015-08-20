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

$tabUpgrades = GUICtrlCreateTabItem(getLocaleString("tabBuildings"))

	Local $x = 30, $y = 150
	$grpUpgrade = GUICtrlCreateGroup(getLocaleString("grpUpgrade"), $x - 20, $y - 20, 450, 360)

		$btnLocateUpgrade = GUICtrlCreateButton(getLocaleString("btnLocateUpgrade"), $x+330, $y-1, 95, 40, BitOR($BS_MULTILINE, $BS_VCENTER))
			GUICtrlSetTip(-1, getLocaleString("tipLocateUpgrade"))
			GUICtrlSetOnEvent(-1, "btnLocateUpgrades")
		$btnResetUpgrade = GUICtrlCreateButton(getLocaleString("btnResetUpgrade"), $x+330, $y+45, 95, 40, BitOR($BS_MULTILINE, $BS_VCENTER))
			GUICtrlSetTip(-1, getLocaleString("tipResetUpgrade"))
			GUICtrlSetOnEvent(-1, "btnResetUpgrade")
		$picUpgradeStatus[0]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight, $x - 15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		 $chkbxUpgrade[0] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#1"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#1"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		 $lblUpgrade0PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			$txtUpgradeX[0] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade0PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			$txtUpgradeY[0] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[0]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[0] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[1]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight, $x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[1] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#2"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#2"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade1PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			$txtUpgradeX[1] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade1PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			$txtUpgradeY[1] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[1]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[1] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[2]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight, $x - 15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[2] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#3"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#3"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade2PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			$txtUpgradeX[2] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade2PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			$txtUpgradeY[2] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[2]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[2] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[3]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight,$x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[3] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#4"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#4"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade3PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			 $txtUpgradeX[3] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade3PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			 $txtUpgradeY[3] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[3]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[3] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[4]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight,$x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[4] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#5"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#5"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade4PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			 $txtUpgradeX[4] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade4PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			 $txtUpgradeY[4] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[4]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[4] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[5]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight,$x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[5] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#6"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#6"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade5PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			 $txtUpgradeX[5] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade5PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			 $txtUpgradeY[5] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[5]= GUICtrlCreateIcon($pIconLib, $eIcnBlank, $x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[5] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[6]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight, $x - 15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		 $chkbxUpgrade[6] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#7"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#7"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		 $lblUpgrade0PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			$txtUpgradeX[6] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade0PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			$txtUpgradeY[6] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[6]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[6] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		
		$y+=22
		$picUpgradeStatus[7]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight, $x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[7] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#8"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#8"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade1PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			$txtUpgradeX[7] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade1PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			$txtUpgradeY[7] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[7]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[7] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[8]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight, $x - 15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[8] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#9"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#9"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade2PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			$txtUpgradeX[8] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade2PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			$txtUpgradeY[8] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[8]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[8] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[9]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight,$x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[9] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#10"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#10"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade3PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			 $txtUpgradeX[9] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade3PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			 $txtUpgradeY[9] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[9]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[9] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[10]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight,$x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[10] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#11"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#11"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade4PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			 $txtUpgradeX[10] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade4PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			 $txtUpgradeY[10] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[10]= GUICtrlCreateIcon($pIconLib, $eIcnBlank,$x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[10] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))

		$y+=22
		$picUpgradeStatus[11]= GUICtrlCreateIcon($pIconLib, $eIcnRedLight,$x-15, $y + 1, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeStatus"))
		$chkbxUpgrade[11] = GUICtrlCreateCheckbox(getLocaleString("chkUpgrade#12"), $x + 5, $y + 1, 85, 17)
			GUICtrlSetTip(-1, getLocaleString("tipChkUpgrade#12"))
			GUICtrlSetOnEvent(-1, "btnchkbxUpgrade")
		$lblUpgrade5PosX = GUICtrlCreateLabel(getLocaleString("lblPosX"), $x+98, $y+3, 38, 18)
			 $txtUpgradeX[11] = GUICtrlCreateInput("", $x+128, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$lblUpgrade5PosY = GUICtrlCreateLabel(getLocaleString("lblPosY"), $x+195, $y+3, 38, 18)
			 $txtUpgradeY[11] = GUICtrlCreateInput("", $x+161, $y-1, 31, 20, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		$picUpgradeType[11]= GUICtrlCreateIcon($pIconLib, $eIcnBlank, $x+233, $y, 16, 16)
			GUICtrlSetTip(-1, getLocaleString("tipUpgradeType"))
		$txtUpgradeValue[11] = GUICtrlCreateInput("", $x+251, $y-1, 65, 18, BitOR($ES_CENTER, $GUI_SS_DEFAULT_INPUT, $ES_READONLY, $ES_NUMBER))
		
		

		$y+=27
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x - 15, $y, 16, 16)
		$UpgrMinGold = GUICtrlCreateLabel(getLocaleString("UpgrMinGold"), $x + 5, $y + 3, -1, -1)
		$txtUpgrMinGold = GUICtrlCreateInput("250000", $x + 60, $y - 2, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipUpgrMinGold",1))
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 140, $y, 16, 16)
		$UpgrMinElixir = GUICtrlCreateLabel(getLocaleString("UpgrMinElixir"), $x + 160, $y + 3, -1, -1)
		$txtUpgrMinElixir = GUICtrlCreateInput("250000", $x + 210, $y - 2, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipUpgrMinElixir",1))
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 285, $y, 16, 16)
		$UpgrMinDark = GUICtrlCreateLabel(getLocaleString("UpgrMinDark"), $x + 305, $y + 3, -1, -1)
		$txtUpgrMinDark= GUICtrlCreateInput("3000", $x + 360, $y - 2, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, getLocaleString("tipUpgrMinDark",1))
			GUICtrlSetLimit(-1, 6)
			
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateTabItem("")
