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
;~ Notify Tab
;~ -------------------------------------------------------------
$tabNotify = GUICtrlCreateTabItem(getLocaleString("tabNotify"))
	Local $x = 30, $y = 150
	$grpPushBullet = GUICtrlCreateGroup(getLocaleString("grpPushBullet"), $x - 20, $y - 20, 450, 375)
	$picPushBullet = GUICtrlCreateIcon ($pIconLib, $eIcnPushBullet, $x, $y, 32, 32)
	$chkPBenabled = GUICtrlCreateCheckbox(getLocaleString("chkPBenabled"), $x + 40, $y)
		GUICtrlSetOnEvent(-1, "chkPBenabled")
		GUICtrlSetTip(-1, getLocaleString("tipChkPBenabled"))
	$y += 22
	$chkPBRemote = GUICtrlCreateCheckbox(getLocaleString("chkPBRemote"), $x + 40, $y)
		GUICtrlSetTip(-1, getLocaleString("tipChkPBRemote"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y = 150
	$chkDeleteAllPushes = GUICtrlCreateCheckbox(getLocaleString("chkDeleteAllPushes"), $x + 160, $y)
		GUICtrlSetTip(-1, getLocaleString("tipChkDeleteAllPushes"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$btnDeletePBmessages = GUICtrlCreateButton(getLocaleString("btnDeletePBmessages"), $x + 300, $y, 100, 20)
		GUICtrlSetTip(-1, getLocaleString("tipBtnDeletePBmessages"))
		GUICtrlSetOnEvent(-1, "btnDeletePBMessages")
		IF $btnColor then GUICtrlSetBkColor(-1, 0x5CAD85)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y += 22
	$chkDeleteOldPushes = GUICtrlCreateCheckbox(getLocaleString("chkDeleteOldPushes"), $x + 160, $y)
		GUICtrlSetTip(-1, getLocaleString("tipChkDeleteOldPushes"))
		GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlSetOnEvent(-1, "chkDeleteOldPushes")
	$cmbHoursPushBullet = GUICtrlCreateCombo("", $x + 300, $y, 100, 35, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, "Set the interval for messages to be deleted.")
		GUICtrlSetData(-1, getLocaleString("cmbHoursPushBullet"), getLocaleString("cmbHoursPushBulletDefault"))
		GUICtrlSetState (-1, $GUI_DISABLE)
	$y += 30
	$lblPushBTokenValue = GUICtrlCreateLabel(getLocaleString("lblPushBTokenValue"), $x, $y, -1, -1, $SS_RIGHT)
	$PushBTokenValue = GUICtrlCreateInput("", $x + 120, $y - 3, 280, 19)
		GUICtrlSetTip(-1, getLocaleString("tipPushBTokenValue"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y += 25
	$lblOrigPush = GUICtrlCreateLabel(getLocaleString("lblOrigPush"), $x, $y, -1, -1, $SS_RIGHT)
		GUICtrlSetTip(-1, getLocaleString("tipOrigPush"))
	$OrigPushB = GUICtrlCreateLabel("", $x + 120, $y - 1, 280, 20, $SS_SUNKEN)
		GUICtrlSetBkColor(-1, 0xF0F0F0)
		GUICtrlSetTip(-1, getLocaleString("tipOrigPush"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y += 25
	$lblNotifyWhen = GUICtrlCreateLabel(getLocaleString("lblNotifyWhen"), $x, $y, -1, -1, $SS_RIGHT)
	$y += 15
	$chkAlertPBVMFound = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBVMFound"), $x + 10, $y)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBVMFound"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$chkAlertPBLastRaid = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBLastRaid"), $x + 100, $y)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBLastRaid"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$chkAlertPBLastRaidTxt = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBLastRaidTxt"), $x + 210, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBLastRaidTxt"))
	$chkAlertPBCampFull = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBCampFull"), $x + 315, $y, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBCampFull"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y += 20
	$chkAlertPBWallUpgrade = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBWallUpgrade"), $x + 10, $y, -1, -1)
		 GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBWallUpgrade"))
		 GUICtrlSetState(-1, $GUI_DISABLE)
	$chkAlertPBOOS = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBOOS"), $x + 100, $y, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBOOS"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$chkAlertPBVBreak = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBVBreak"), $x + 210, $y, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBVBreak"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y += 20
	$chkAlertPBVillage = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBVillage"), $x + 10, $y, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBVillage"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$chkAlertPBLastAttack = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBLastAttack"), $x + 100, $y, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBLastAttack"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$chkAlertPBOtherDevice = GUICtrlCreateCheckbox(getLocaleString("chkAlertPBOtherDevice"), $x + 210, $y, -1, -1)
		GUICtrlSetTip(-1, getLocaleString("tipChkAlertPBOtherDevice"))
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y = 350
	$lblgrppushbullet = GUICtrlCreateGroup(getLocaleString("lblGrpPushBullet"), $x - 10, $y - 20, 430, 170)
		$lblPBdesc = GUICtrlCreateLabel(getLocaleString("lblPBdesc",1), $x, $y, -1, -1, $SS_LEFT)
		GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
