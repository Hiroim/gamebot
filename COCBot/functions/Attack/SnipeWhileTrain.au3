; #FUNCTION# ====================================================================================================================
; Name ..........: SnipeWhileTrain
; Description ...: During the idle loop, if $chkSnipeWhileTrain is checked, the bot will to for pure TH snipe
;                  and return after 20 searches to profit from idle time.
;                  VillageSearch() was modified to break search after 20 loops.
;                  2 variables are used for this function.
;                  Global $chkSnipeWhileTrain, $isSnipeWhileTrain
;                  Local $tempSnipeWHileTrain[12]
; Syntax ........:
; Parameters ....: None
; Return values .: False if not enough troops (30%) True if 20 searches was successfully done.
; Author ........: ChiefM3
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func SnipeWhileTrain()

	If $iChkSnipeWhileTrain = 1 Then

		; Attempt only when 40% army full to prevent failure of TH snipe
		If ($CurCamp <= ($TotalCamp * 40 / 100)) Then
			Return False
		EndIf

		If $fullArmy = False And Not($CurCamp >= StringLeft(($TotalCamp * $fulltroop * 90/100),3)) Then
			; Swap variables to pure TH snipe mode
			$tempSnipeWhileTrain[0] = $iChkMeetTrophy[$DB]
			$tempSnipeWhileTrain[1] = $iChkMeetTrophy[$LB]
			$tempSnipeWhileTrain[2] = $iMinTrophy[$DB]
			$tempSnipeWhileTrain[3] = $iMinTrophy[$LB]
			$tempSnipeWhileTrain[4] = $iChkMeetOne[$LB]
			$tempSnipeWhileTrain[5] = $iChkMeetOne[$DB]
			$tempSnipeWhileTrain[6] = $OptTrophyMode
			$tempSnipeWhileTrain[7] = $THaddtiles
            $tempSnipeWhileTrain[8] = $iMinGold[$DB]
            $tempSnipeWhileTrain[9] = $iMinGold[$LB]
            $tempSnipeWhileTrain[10] = $iCmbMeetGE[$DB]
            $tempSnipeWhileTrain[11] = $iCmbMeetGE[$LB]
			;change valuse to snipe while train
			$iChkMeetTrophy[$DB] = 1
			$iChkMeetTrophy[$LB] = 1
			$iMinTrophy[$DB] = 99
			$iMinTrophy[$LB] = 99
			$iChkMeetOne[$LB] = 0
			$iChkMeetOne[$DB] = 0
			$OptTrophyMode = 1
			$THaddtiles = 0
            $iMinGold[$DB] = "999999"
            $iMinGold[$LB] = "999999"
            $iCmbMeetGE[$DB] = "0"
            $iCmbMeetGE[$LB] = "0"

			;used to revert values
			$DidntRevert = 1

			; go to search for 10 times
			SetLog(getLocaleString("logTryTHSnipeWhileTraining"), $COLOR_RED)
			$isSnipeWhileTrain = True
			$Is_ClientSyncError = False
			AttackMain()
			$Restart = False ; Sets $Restart as True to end search after 10 attempts
			$Is_ClientSyncError = False
			$isSnipeWhileTrain = False
			SetLog(getLocaleString("logEndTHSnipeWhileTraining"), $COLOR_RED)

			SWHTrainRevertNormal()

			Return True
		EndIf
	EndIf
EndFunc   ;==>SnipeWhileTrain

Func SWHTrainRevertNormal()
	If $DidntRevert = 1 Then
		; revert settings back to normal
        $iChkMeetTrophy[$DB] = $tempSnipeWhileTrain[0]
        $iChkMeetTrophy[$LB] = $tempSnipeWhileTrain[1]
        $iMinTrophy[$DB]     = $tempSnipeWhileTrain[2]
        $iMinTrophy[$LB]     = $tempSnipeWhileTrain[3]
        $iChkMeetOne[$LB]    = $tempSnipeWhileTrain[4]
        $iChkMeetOne[$DB]    = $tempSnipeWhileTrain[5]
        $OptTrophyMode       = $tempSnipeWhileTrain[6]
        $THaddtiles          = $tempSnipeWhileTrain[7]
        $iMinGold[$DB]       = $tempSnipeWhileTrain[8]
        $iMinGold[$LB]       = $tempSnipeWhileTrain[9]
        $iCmbMeetGE[$DB]     = $tempSnipeWhileTrain[10]
        $iCmbMeetGE[$LB]     = $tempSnipeWhileTrain[11]
        $Is_ClientSyncError = False
	EndIf
	$DidntRevert = 0
    $isSnipeWhileTrain = False
EndFunc   ;==>SWHTrainRevertNormal
