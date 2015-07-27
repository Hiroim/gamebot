
; #FUNCTION# ====================================================================================================================
; Name ..........: waitMainScreen
; Description ...: Waits 5 minutes for the pixel of mainscreen to be located, checks for obstacles every 2 seconds.  After five minutes, will try to restart bluestacks.
; Syntax ........: waitMainScreen()
; Parameters ....:
; Return values .: None
; Author ........:
; Modified ......: KnowJack (July 2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func waitMainScreen() ;Waits for main screen to popup
	Local $iTried, $iCount
	SetLog(getLocaleString("logWaitMainSc"))
	$iCount = 0
	For $i = 0 To 105 ;105*2000 = 3.5 Minutes
		If $debugsetlog = 1 Then Setlog("ChkObst Loop = " & $i & "ExitLoop = " & $iCount, $COLOR_PURPLE) ; Debug stuck loop
		$iCount += 1
		_CaptureRegion()
		If _CheckPixel($aIsMain, $bNoCapturepixel) = False Then ;Checks for Main Screen
			If _Sleep(2000) Then Return
			If checkObstacles() Then $i = 0 ;See if there is anything in the way of mainscreen
		Else
			If $debugsetlog = 1 Then Setlog("Screen cleared, WaitMainScreen exit", $COLOR_PURPLE)
			Return
		EndIf
		If ($i > 105) Or ($iCount > 180) Then ExitLoop  ; If CheckObstacles forces reset, limit total time to 6 minute before restart BS
	Next
	$iCount = 0
	While 1
		SetLog(getLocaleString("logUnableToLoadCoC"), $COLOR_RED)
		If $debugsetlog = 1 Then Setlog("Restart Loop = " & $iCount & "WindowHandle Loop = " & $iTried, $COLOR_PURPLE) ; Debug stuck loop
		$iTimeTroops = 0
		Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
		Run($RestartApp & " Android")
		If _Sleep(10000) Then Return
		$iTried = 0
		Do
			If $iTried > 9  Then
				SetLog(getLocaleString("logUnableToRestartBS"), $COLOR_RED)
				ExitLoop
			EndIf
			If _Sleep(3000) Then Return
			$iTried += 1
		Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
		CheckObstacles()  ; Check for random error windows and close them
		$iCount += 1
		If $iCount > 2 Then
			SetLog(getLocaleString("logStuckBS"), $COLOR_RED)
			Return
		EndIf
	WEnd
EndFunc   ;==>waitMainScreen
