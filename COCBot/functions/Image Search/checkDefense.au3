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

Global $trapTH[5][20]

Global $trapTHtxt[5][20]=[
        ["L3Ma Inferno","L3Mb Inferno","L3s Inferno","L2Ma Inferno","L2Mb Inferno","L2s Inferno","L1Ma Inferno","L1Mb Inferno","L1s Inferno","","","","","","","","","","",""],
        ["L8 Wiz Tower","L7 Wiz Tower","L6 Wiz Tower","L5 Wiz Tower","L4 Wiz Tower","","","","","","","","","","","","","","",""],
        ["L8 Mortar","L7 Mortar","L6 Mortar","L5 Mortar","","","","","","","","","","","","","","","",""],
        ["L8a Tesla","L8b Tesla","L7a Tesla","L7b Tesla","L7c Tesla","L6a Tesla","L6b Tesla","L6c Tesla","","","","","","","","","","","",""],
        ["","","","","","","","","","","","","","","","","","","",""]
    ]

;Inferno Towers
$trapTH[0][0] = @ScriptDir & "\images\Defense\infe3ma.png"
$trapTH[0][1] = @ScriptDir & "\images\Defense\infe3mb.png"
$trapTH[0][2] = @ScriptDir & "\images\Defense\infe3s.png"
$trapTH[0][3] = @ScriptDir & "\images\Defense\infe2ma.png"
$trapTH[0][4] = @ScriptDir & "\images\Defense\infe2mb.png"
$trapTH[0][5] = @ScriptDir & "\images\Defense\infe2s.png"
$trapTH[0][6] = @ScriptDir & "\images\Defense\infe1ma.png"
$trapTH[0][7] = @ScriptDir & "\images\Defense\infe1mb.png"
$trapTH[0][8] = @ScriptDir & "\images\Defense\infe1s.png"

;Wizard Towers
$trapTH[1][0] = @ScriptDir & "\images\Defense\wiz8.png"
$trapTH[1][1] = @ScriptDir & "\images\Defense\wiz7.png"
$trapTH[1][2] = @ScriptDir & "\images\Defense\wiz6.png"
$trapTH[1][3] = @ScriptDir & "\images\Defense\wiz5.png"
$trapTH[1][4] = @ScriptDir & "\images\Defense\wiz4.png"

;Mortars
$trapTH[2][0] = @ScriptDir & "\images\Defense\mort8.png"
$trapTH[2][1] = @ScriptDir & "\images\Defense\mort7.png"
$trapTH[2][2] = @ScriptDir & "\images\Defense\mort6.png"
$trapTH[2][3] = @ScriptDir & "\images\Defense\mort5.png"

;Hidden Teslas
$trapTH[3][0] = @ScriptDir & "\images\Defense\tesl8a.png"
$trapTH[3][1] = @ScriptDir & "\images\Defense\tesl8b.png"
$trapTH[3][2] = @ScriptDir & "\images\Defense\tesl7a.png"
$trapTH[3][3] = @ScriptDir & "\images\Defense\tesl7b.png"
$trapTH[3][4] = @ScriptDir & "\images\Defense\tesl7c.png"
$trapTH[3][5] = @ScriptDir & "\images\Defense\tesl6a.png"
$trapTH[3][6] = @ScriptDir & "\images\Defense\tesl6b.png"
$trapTH[3][7] = @ScriptDir & "\images\Defense\tesl6c.png"
;$trapTH[3][8] = @ScriptDir & "\images\Defense\tesl5.png"
;$trapTH[3][9] = @ScriptDir & "\images\Defense\tesl4.png"
;$trapTH[3][5] = @ScriptDir & "\images\Defense\tesl3.png"
;$trapTH[3][6] = @ScriptDir & "\images\Defense\tesla2.png"
;$trapTH[3][7] = @ScriptDir & "\images\Defense\tesla1.png"

;Air Defense
;$trapTH[4][0] = @ScriptDir & "\images\Defense\aird2_mt1.png"



;Global $defTolerance[5][50]=[ [15,15,15,15,40,10,8,8,8,1,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [40,40,40,12,12,12,10,10,10,5,5,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [15,40,40,40,40,10,12,10,12,5,5,5,12,12,12,12,10,10,8,20,10,20,20,10,10,15,15,8,30,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [15,15,15,15,15,15,10,10,10,10,5,5,5,15,20,15,20,5,20,15,5,20,20,10,10,30,30,30,30,30,30,40,40,30,40,40,40,40,40,40,40,40,30,30,40,40,40,30,40,40], [20,20,20,40,40,40,40,40,40,40,40,40,40,40,40,40,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] ]

Func checkDefense()


	Local $defSimilarity[5][20]=[
	        [0.92,0.92,0.91,0.92,0.92,0.91,0.92,0.92,0.92,0,0,0,0,0,0,0,0,0,0,0],
	        [0.94,0.94,0.95,0.94,0.94,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	        [0.91,0.905,0.935,0.92,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	        [0.94,.92,0.90,0.90,0.90,0.91,0.91,0.96,0,0,0,0,0,0,0,0,0,0,0,0],
	        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        ]

	$allTroops = False
	$skipBase = False
	$numDefFound = 0;

	SetLog(getLocaleString("logCheckTrappedTH"), $COLOR_BLUE)

	_CaptureTH()
	For $t = 0 to 4
		For $i = 0 To 9
			If FileExists($trapTH[$t][$i]) Then

				$DefLocation = _ImageSearch($trapTH[$t][$i], 1, $Defx, $Defy, $defTolerance[$t][$i]) ; Getting Defense Location
				Setlog("Trying with " &$DefText[$t]& " image "&$i)

				$sendHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
				$res = DllCall($LibDir & "\ImageSearch.dll", "str", "searchTile", "handle", $sendHBitmap, "str", $trapTH[$t][$i], "float", $defSimilarity[$t][$i])
				_WinAPI_DeleteObject($sendHBitmap)

				If IsArray($res) Then
				;SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
					If $res[0] = "0" Then
						$res = ""
					ElseIf $res[0] = "-1" Then
						;SetLog("DLL Error", $COLOR_RED)
						return "DLL Error"
					Else

						$expRet = StringSplit($res[0], "|", 2)

						$Defx = Int($expRet[1])
						$Defy = Int($expRet[1 + 1])

						$numDefFound += 1
						Setlog($DefText[$t] & getLocaleString("defFound"))
						Setlog($trapTHtxt[$t][$i] & getLocaleString("defFound"))

                    If $skipInferno = 1 AND $DefText[$t] = getLocaleString("defTxtInferno") Then
                        If ($Defx > 40 AND $Defx < 210) AND ($Defy > 30 AND $Defy < 150) Then
                            $skipBase = True
                            Return getLocaleString("logInfernoFound")
                        Else
                            $skipBase = False
                        EndIf
                    ElseIf $skipWiz = 1 AND $DefText[$t] = getLocaleString("defTxtWizTower") Then
                        If ($Defx > 53 AND $Defx < 197) AND ($Defy > 42 AND $Defy < 138) Then
                            $skipBase = True
                            Return getLocaleString("logWizTowerFound")
                        Else
                            $skipBase = False
                        EndIf
                    ElseIf $skipMortar = 1 AND $DefText[$t] = getLocaleString("defTxtMortar") Then
                        If ($Defx > 5 AND $Defx < 245) AND ($Defy > 10 AND $Defy < 170) Then
                            $skipBase = True
                            Return getLocaleString("logMortarFound")
                        Else
                            $skipBase = False
                        EndIf
                    ElseIf $skipTesla = 1 AND $DefText[$t] = getLocaleString("defTxtTesla") Then
                        If ($Defx > 58 AND $Defx < 192) AND ($Defy > 45 AND $Defy < 135) Then
                            $skipBase = True
                            Return getLocaleString("logTeslaFound")
                        Else
                            $skipBase = False
                        EndIf
                    ElseIf $skipAir = 1 AND $DefText[$t] = getLocaleString("defTxtAirDef") Then
                        If ($Defx > 15 AND $Defx < 235) AND ($Defy > 20 AND $Defy < 160) Then
                            $skipBase = True
                            Return getLocaleString("logAirDefFound")
                        Else
                            $skipBase = False
                        EndIf
                    Else
                        If ($DefText[$t] = getLocaleString("defTxtAirDef") AND $airTroops = 0) or ($DefText[$t] = getLocaleString("defTxtMortar") AND $grdTroops = 0) Then
                            $skipBase = False
                        ElseIf ($Defx > 5 AND $Defx < 245) AND ($Defy > 10 AND $Defy < 170) Then
                            $skipBase = False
                            $allTroops = True
                            Return $DefText[$t] & getLocaleString("defFound1") & $DefX & "," & $DefY & getLocaleString("defFound2")
                        EndIf
                    EndIf
                EndIf
            EndIf
        EndIf
		Next
	Next
	If $numDefFound > 0 Then
		Return getLocaleString("logDefFaundFalse")
	Else
		Return getLocaleString("logNoMajorTrapsFound")
	EndIf
EndFunc