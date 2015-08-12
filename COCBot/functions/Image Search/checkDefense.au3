; #FUNCTION# ====================================================================================================================
; Name ..........: checkDefense
; Description ...: This file Includes the Variables and functions to detect certain defenses near TH, based on checkTownhall.au3
; Syntax ........: checkDefense()
; Parameters ....: None
; Return values .: $Defx, $Defy
; Author ........: barracoda
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

#cs
*******************************************************************
HOW TO USE:
1) If you're using "Normal" TH Snipe algorithm (or one that uses Ground & Air troops), set both $grdTroops & $airTroops to 1.
If you set $grdTroops to 1, it will ignore air defense. If you set $airTroops to 1, it will ignore mortars.
3) Set $skipMortar, $skipWiz, $skipInferno, $skipTesla, $skipAir to 1 if you want to skip bases that have these near the TH. Otherwise set them to 0. By default, only inferno is set to 1.
4) The default algorithms are not recommended, as they use both ground and air troops (B.A.M.).
*******************************************************************
#ce

Global $trapTH[5][50], $defInfo, $defTolerance=15, $DefLocation, $DefText

;Inferno Towers
$trapTH[0][0] = @ScriptDir & "\images\Defense\inferno_lt1.png"
$trapTH[0][1] = @ScriptDir & "\images\Defense\inferno_lt2.png"
$trapTH[0][2] = @ScriptDir & "\images\Defense\inferno_lt3.png"
$trapTH[0][3] = @ScriptDir & "\images\Defense\inferno_lt4.png"
$trapTH[0][4] = @ScriptDir & "\images\Defense\inferno_mt1.png"
$trapTH[0][5] = @ScriptDir & "\images\Defense\inferno1_vlt1.png"
$trapTH[0][6] = @ScriptDir & "\images\Defense\inferno1_vlt2.png"
$trapTH[0][7] = @ScriptDir & "\images\Defense\inferno1_vlt1.png"
$trapTH[0][8] = @ScriptDir & "\images\Defense\inferno1_vlt2.png"
$trapTH[0][9] = @ScriptDir & "\images\Defense\inferno3_0t1.png"
$trapTH[0][10] = @ScriptDir & "\images\Defense\inferno3_mt1.png"


;Wizard Towers
$trapTH[1][0] = @ScriptDir & "\images\Defense\wiz6_ht1.png"
$trapTH[1][1] = @ScriptDir & "\images\Defense\wiz6_ht2.png"
$trapTH[1][2] = @ScriptDir & "\images\Defense\wiz6_ht3.png"
$trapTH[1][3] = @ScriptDir & "\images\Defense\wiz7_lt1.png"
$trapTH[1][4] = @ScriptDir & "\images\Defense\wiz7_lt2.png"
$trapTH[1][5] = @ScriptDir & "\images\Defense\wiz7_lt3.png"
$trapTH[1][6] = @ScriptDir & "\images\Defense\wiz8_lt1.png"
$trapTH[1][7] = @ScriptDir & "\images\Defense\wiz8_lt2.png"
$trapTH[1][8] = @ScriptDir & "\images\Defense\wiz6_vlt1.png"
$trapTH[1][9] = @ScriptDir & "\images\Defense\wiz1_vlt1.png"
$trapTH[1][10] = @ScriptDir & "\images\Defense\wiz1_vlt2.png"
$trapTH[1][11] = @ScriptDir & "\images\Defense\wiz7_ht1.png"



;Mortars
$trapTH[2][0] = @ScriptDir & "\images\Defense\mortar5_mt1.png"
$trapTH[2][1] = @ScriptDir & "\images\Defense\mortar5_ht1.png"
$trapTH[2][2] = @ScriptDir & "\images\Defense\mortar5_ht2.png"
$trapTH[2][3] = @ScriptDir & "\images\Defense\mortar5_ht3.png"
$trapTH[2][4] = @ScriptDir & "\images\Defense\mortar5_ht4.png"
$trapTH[2][5] = @ScriptDir & "\images\Defense\mortar5_vlt1.png"
$trapTH[2][6] = @ScriptDir & "\images\Defense\mortar5_lt1.png"
$trapTH[2][7] = @ScriptDir & "\images\Defense\mortar7_lt1.png"
$trapTH[2][8] = @ScriptDir & "\images\Defense\mortar7_vlt1.png"
$trapTH[2][9] = @ScriptDir & "\images\Defense\mortar7_vlt2.png"
$trapTH[2][10] = @ScriptDir & "\images\Defense\mortar7_vlt3.png"
$trapTH[2][11] = @ScriptDir & "\images\Defense\mortar7_vlt4.png"
$trapTH[2][12] = @ScriptDir & "\images\Defense\mortar8_lt1.png"
$trapTH[2][13] = @ScriptDir & "\images\Defense\mortar8_vlt1.png"
$trapTH[2][14] = @ScriptDir & "\images\Defense\mortar8_vlt2.png"
$trapTH[2][15] = @ScriptDir & "\images\Defense\mortar8_vlt3.png"
$trapTH[2][16] = @ScriptDir & "\images\Defense\mortar6_vlt2.png"
$trapTH[2][17] = @ScriptDir & "\images\Defense\mortar6_vlt3.png"
$trapTH[2][18] = @ScriptDir & "\images\Defense\mortar4_vlt1.png"
$trapTH[2][19] = @ScriptDir & "\images\Defense\mortar3_mt1.png"
$trapTH[2][20] = @ScriptDir & "\images\Defense\mortar3_mt2.png"
$trapTH[2][21] = @ScriptDir & "\images\Defense\mortar3_ht1.png"
$trapTH[2][22] = @ScriptDir & "\images\Defense\mortar4_ht1.png"
$trapTH[2][23] = @ScriptDir & "\images\Defense\mortar4_lt2.png"
$trapTH[2][24] = @ScriptDir & "\images\Defense\mortar7_lt2.png"
$trapTH[2][25] = @ScriptDir & "\images\Defense\mortar7_mt1.png"
$trapTH[2][26] = @ScriptDir & "\images\Defense\mortar4_mt1.png"
$trapTH[2][27] = @ScriptDir & "\images\Defense\mortar5_lt2.png"
$trapTH[2][28] = @ScriptDir & "\images\Defense\mortar5_ht1.png"
$trapTH[2][29] = @ScriptDir & "\images\Defense\mortar8_lt2.png"

;Hidden Teslas
$trapTH[3][0] = @ScriptDir & "\images\Defense\tesla6_vlt1.png"
$trapTH[3][1] = @ScriptDir & "\images\Defense\tesla6_vlt2.png"
$trapTH[3][2] = @ScriptDir & "\images\Defense\tesla7_vlt1.png"
$trapTH[3][3] = @ScriptDir & "\images\Defense\tesla8_vlt1.png"
$trapTH[3][4] = @ScriptDir & "\images\Defense\tesla7_mt1.png"
$trapTH[3][5] = @ScriptDir & "\images\Defense\tesla7_mt2.png"
$trapTH[3][6] = @ScriptDir & "\images\Defense\tesla7_vlt2.png"
$trapTH[3][7] = @ScriptDir & "\images\Defense\tesla7_vlt3.png"
$trapTH[3][8] = @ScriptDir & "\images\Defense\tesla7_vlt4.png"
$trapTH[3][9] = @ScriptDir & "\images\Defense\tesla7_vlt5.png"
$trapTH[3][10] = @ScriptDir & "\images\Defense\tesla1_vlt1.png"
$trapTH[3][11] = @ScriptDir & "\images\Defense\tesla3_vlt1.png"
$trapTH[3][12] = @ScriptDir & "\images\Defense\tesla34_vlt1.png"
$trapTH[3][13] = @ScriptDir & "\images\Defense\tesla3_mt1.png"
$trapTH[3][14] = @ScriptDir & "\images\Defense\tesla1_ht1.png"
$trapTH[3][15] = @ScriptDir & "\images\Defense\tesla1_mt1.png"
$trapTH[3][16] = @ScriptDir & "\images\Defense\tesla1_ht2.png"
$trapTH[3][17] = @ScriptDir & "\images\Defense\tesla1_vlt2.png"
$trapTH[3][18] = @ScriptDir & "\images\Defense\tesla1_ht3.png"
$trapTH[3][19] = @ScriptDir & "\images\Defense\tesla2_mt1.png"
$trapTH[3][20] = @ScriptDir & "\images\Defense\tesla2_0t.png"
$trapTH[3][21] = @ScriptDir & "\images\Defense\tesla2_ht1.png"
$trapTH[3][22] = @ScriptDir & "\images\Defense\tesla2_ht2.png"
$trapTH[3][23] = @ScriptDir & "\images\Defense\tesla3_lt1.png"
$trapTH[3][24] = @ScriptDir & "\images\Defense\tesla3_lt2.png"
$trapTH[3][25] = @ScriptDir & "\images\Defense\tesla3_ht1.png"
$trapTH[3][26] = @ScriptDir & "\images\Defense\tesla3_ht2.png"
$trapTH[3][27] = @ScriptDir & "\images\Defense\tesla3_ht3.png"
$trapTH[3][28] = @ScriptDir & "\images\Defense\tesla3_ht4.png"
$trapTH[3][29] = @ScriptDir & "\images\Defense\tesla4_ht1.png"
$trapTH[3][30] = @ScriptDir & "\images\Defense\tesla4_ht2.png"
$trapTH[3][31] = @ScriptDir & "\images\Defense\tesla4_ht3.png"
$trapTH[3][32] = @ScriptDir & "\images\Defense\tesla4_ht4.png"
$trapTH[3][33] = @ScriptDir & "\images\Defense\tesla5_mt1.png"
$trapTH[3][34] = @ScriptDir & "\images\Defense\tesla5_ht1.png"
$trapTH[3][35] = @ScriptDir & "\images\Defense\tesla5_ht2.png"
$trapTH[3][36] = @ScriptDir & "\images\Defense\tesla5_ht3.png"
$trapTH[3][37] = @ScriptDir & "\images\Defense\tesla5_ht4.png"
$trapTH[3][38] = @ScriptDir & "\images\Defense\tesla6_ht1.png"
$trapTH[3][39] = @ScriptDir & "\images\Defense\tesla6_ht2.png"
$trapTH[3][40] = @ScriptDir & "\images\Defense\tesla6_ht3.png"
$trapTH[3][41] = @ScriptDir & "\images\Defense\tesla6_ht4.png"
$trapTH[3][42] = @ScriptDir & "\images\Defense\tesla8_mt1.png"
$trapTH[3][43] = @ScriptDir & "\images\Defense\tesla8_mt2.png"
$trapTH[3][44] = @ScriptDir & "\images\Defense\tesla8_ht1.png"
$trapTH[3][45] = @ScriptDir & "\images\Defense\tesla8_ht2.png"
$trapTH[3][46] = @ScriptDir & "\images\Defense\tesla8_ht3.png"
$trapTH[3][47] = @ScriptDir & "\images\Defense\tesla8_mt3.png"
$trapTH[3][48] = @ScriptDir & "\images\Defense\tesla8_ht4.png"
$trapTH[3][49] = @ScriptDir & "\images\Defense\tesla8_ht5.png"

;Air Defense
$trapTH[4][0] = @ScriptDir & "\images\Defense\aird2_mt1.png"
$trapTH[4][1] = @ScriptDir & "\images\Defense\aird3_mt1.png"
$trapTH[4][2] = @ScriptDir & "\images\Defense\aird3_mt2.png"
$trapTH[4][3] = @ScriptDir & "\images\Defense\aird4_ht1.png"
$trapTH[4][4] = @ScriptDir & "\images\Defense\aird4_ht2.png"
$trapTH[4][5] = @ScriptDir & "\images\Defense\aird5_ht1.png"
$trapTH[4][6] = @ScriptDir & "\images\Defense\aird5_ht2.png"
$trapTH[4][7] = @ScriptDir & "\images\Defense\aird5_ht3.png"
$trapTH[4][8] = @ScriptDir & "\images\Defense\aird5_ht4.png"
$trapTH[4][9] = @ScriptDir & "\images\Defense\aird5_ht5.png"
$trapTH[4][10] = @ScriptDir & "\images\Defense\aird5_ht6.png"
$trapTH[4][11] = @ScriptDir & "\images\Defense\aird5_ht7.png"
$trapTH[4][12] = @ScriptDir & "\images\Defense\aird6_ht1.png"
$trapTH[4][13] = @ScriptDir & "\images\Defense\aird6_ht2.png"
$trapTH[4][14] = @ScriptDir & "\images\Defense\aird6_ht3.png"
$trapTH[4][15] = @ScriptDir & "\images\Defense\aird6_ht4.png"
$trapTH[4][16] = @ScriptDir & "\images\Defense\aird7_ht1.png"


Global $defTolerance[5][50]=[ [15,15,15,15,40,10,8,8,8,1,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [40,40,40,12,12,12,10,10,10,5,5,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [15,40,40,40,40,10,12,10,12,5,5,5,12,12,12,12,10,10,8,20,10,20,20,10,10,15,15,8,30,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [15,15,15,15,15,15,10,10,10,10,5,5,5,15,20,15,20,5,20,15,5,20,20,10,10,30,30,30,30,30,30,40,40,30,40,40,40,40,40,40,40,40,30,30,40,40,40,30,40,40], [20,20,20,40,40,40,40,40,40,40,40,40,40,40,40,40,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] ]

Func checkDefense()
	;$defInfo = ""
	$allTroops = False
	$skipBase = False
	_CaptureTH()
	For $t=0 to 4
		For $i = 0 To 49
			If FileExists($trapTH[$t][$i]) Then
				$DefLocation = _ImageSearch($trapTH[$t][$i], 1, $Defx, $Defy, $defTolerance[$t][$i]) ; Getting Defense Location
				If $DefLocation = 1 Then
					;$defInfo = "Def: "&$defTolerance[$t][$i]&"-"&$Defx&","&$Defy&" - "
					If $skipInferno = 1 AND $DefText[$t] = getLocaleString("defTxtInferno") Then
						If ($Defx > 40 AND $Defx < 210) AND ($Defy > 30 AND $Defy < 150) Then
							$skipBase = True
							Return getLocaleString("defInfernoFoundTrue")
						Else
							$skipBase = False
							Return getLocaleString("defInfernoFoundFalse")
						EndIf
					ElseIf $skipWiz = 1 AND $DefText[$t] = getLocaleString("defTxtWizTower") Then
						If ($Defx > 53 AND $Defx < 197) AND ($Defy > 42 AND $Defy < 138) Then
							$skipBase = True
							Return getLocaleString("defWizTowerFoundTrue")
						Else
							$skipBase = False
							Return getLocaleString("defWizTowerFoundFalse")
						EndIf
					ElseIf $skipMortar = 1 AND $DefText[$t] = getLocaleString("defTxtMortar") Then
						If ($Defx > 5 AND $Defx < 245) AND ($Defy > 10 AND $Defy < 170) Then
							$skipBase = True
							Return getLocaleString("defMortarFoundTrue")
						Else
							$skipBase = False
							Return getLocaleString("defMortarFoundFalse")
						EndIf
					ElseIf $skipTesla = 1 AND $DefText[$t] = getLocaleString("defTxtTesla") Then
						If ($Defx > 58 AND $Defx < 192) AND ($Defy > 45 AND $Defy < 135) Then
							$skipBase = True
							Return getLocaleString("defTeslaFoundTrue")
						Else
							$skipBase = False
							Return getLocaleString("defTeslaFoundFalse")
						EndIf
					ElseIf $skipAir = 1 AND $DefText[$t] = getLocaleString("defTxtAirDef") Then
						If ($Defx > 15 AND $Defx < 235) AND ($Defy > 20 AND $Defy < 160) Then
							$skipBase = True
							Return getLocaleString("defAirDefFoundTrue")
						Else
							$skipBase = False
							Return getLocaleString("defAirDefFoundFalse")
						EndIf
					Else
						If ($DefText[$t] = getLocaleString("defTxtAirDef") AND $airTroops = 0) or ($DefText[$t] = getLocaleString("defTxtMortar") AND $grdTroops = 0) Then
							$DefLocation = 0
						ElseIf ($Defx > 5 AND $Defx < 245) AND ($Defy > 10 AND $Defy < 170) Then
							$skipBase = False
							$allTroops = True
							Return $DefText[$t] & getLocaleString("defFound1") & $DefX& "," &$DefY & getLocaleString("defFound2") &$defTolerance[$t][$i] & getLocaleString("defFound3")
						Else ;defense found within screen captured area, but not within striking distance
							$skipBase = False
							Return getLocaleString("defFaundFalse")
						EndIf
					EndIf
				EndIf
			EndIf
		Next
	Next
	If $DefLocation = 0 Then Return getLocaleString("defNoMajorTrapsFound")
EndFunc