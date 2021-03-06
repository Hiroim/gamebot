;Drops Clan Castle troops, given the slot and x, y coordinates.

; #FUNCTION# ====================================================================================================================
; Name ..........: dropCC
; Description ...: Drops Clan Castle troops, given the slot and x, y coordinates.
; Syntax ........: dropCC($x, $y, $slot)
; Parameters ....: $x                   - X location.
;                  $y                   - Y location.
;                  $slot                - CC location in troop menu
; Return values .: None
; Author ........:
; Modified ......: KnowJack (June2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func dropCC($x, $y, $slot) ;Drop clan castle
	If $slot <> -1 And (($iMatchMode <> $DB And $iMatchMode <> $LB) Or $iDropCC[$iMatchMode] = 1) Then

		If $iPlannedDropCCHoursEnable = 1 Then
			Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)
			If $iPlannedDropCCHours[$hour[0]] = 0 Then
				SetLog(getLocaleString("logCCNotPlanned"), $COLOR_GREEN)
				Return ; exit func if no planned donate checkmarks
			EndIf
		EndIf

		If $iChkUseCCBalanced = 1 Then
			If Number($TroopsReceived) <> 0 Then
				If Number(Number($TroopsDonated) / Number($TroopsReceived)) >= (Number($iCmbCCDonated) / Number($iCmbCCReceived)) Then
					SetLog(getLocaleString("logCCBalanceDrop") & $TroopsDonated & getLocaleString("logCCBalanceReceived") & $TroopsReceived & ") >= " & $iCmbCCDonated & "/" & $iCmbCCReceived, $COLOR_BLUE)
					Click(GetXPosOfArmySlot($slot, 68), 595, 1, $iDelaydropCC2,"#0086")
					If _Sleep($iDelaydropCC1) Then Return
					Click($x, $y,1,0,"#0087")
				Else
					SetLog(getLocaleString("logCCBalanceNoDrop") & $TroopsDonated & getLocaleString("logCCBalanceReceived") & $TroopsReceived & ") < " & $iCmbCCDonated & "/" & $iCmbCCReceived, $COLOR_BLUE)
				EndIf
			Else
				If Number(Number($TroopsDonated) / 1) >= (Number($iCmbCCDonated) / Number($iCmbCCReceived)) Then
				    SetLog(getLocaleString("logCCBalanceDrop") & $TroopsDonated & getLocaleString("logCCBalanceReceived") & $TroopsReceived & ") >= " & $iCmbCCDonated & "/" & $iCmbCCReceived, $COLOR_BLUE)
					Click(GetXPosOfArmySlot($slot, 68), 595, 1, $iDelaydropCC2,"#0088")
					If _Sleep($iDelaydropCC1) Then Return
					Click($x, $y,1,0,"#0089")
				Else
					SetLog(getLocaleString("logCCBalanceNoDrop") & $TroopsDonated & getLocaleString("logCCBalanceReceived") & $TroopsReceived & ") < " & $iCmbCCDonated & "/" & $iCmbCCReceived, $COLOR_BLUE)
				EndIf
			EndIf
		Else
			SetLog(getLocaleString("logDropCC"), $COLOR_BLUE)
			Click(GetXPosOfArmySlot($slot, 68), 595, 1, $iDelaydropCC2,"#0090")
			If _Sleep($iDelaydropCC1) Then Return
			Click($x, $y,1,0,"#0091")
		EndIf
	EndIf
EndFunc   ;==>dropCC
