; #FUNCTION# ====================================================================================================================
; Name ..........: CGB Bot
; Description ...: This file contens the Sequence that runs all CGB Bot
; Author ........:  (2014)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

#RequireAdmin
#AutoIt3Wrapper_UseX64=n
#include <WindowsConstants.au3>
#include <WinAPI.au3>

#pragma compile(Icon, "Icons\cocbot.ico")
#pragma compile(FileDescription, Clash of Clans Bot - A Free Clash of Clans bot - https://gamebot.org)
#pragma compile(ProductName, Clash Game Bot)

#pragma compile(ProductVersion, 4.1)
#pragma compile(FileVersion, 4.1)
#pragma compile(LegalCopyright, © http://gamebot.org)

$sBotVersion = "v4.1"
$sBotTitle = "Clash Game Bot " & $sBotVersion
Global $sBotDll = @ScriptDir & "\CGBPlugin.dll"
Global $StartupLanguage = IniRead(@ScriptDir & "\COCBot\GUI\localization\lang.ini", "config", "language", "English")

If _Singleton($sBotTitle, 1) = 0 Then
	MsgBox(0, getLocaleString("msgboxWarningTitle"), getLocaleString("msgboxRun"))
	Exit
 EndIf

If @AutoItX64 = 1 Then
	MsgBox(0, getLocaleString("msgboxWarningTitle"), getLocaleString("msgbox_x64"))
	Exit
EndIf

If Not FileExists(@ScriptDir & "\License.txt") Then
	$license = InetGet("http://www.gnu.org/licenses/gpl-3.0.txt", @ScriptDir & "\License.txt")
	InetClose($license)
EndIf

#include "COCBot\CGB Global Variables.au3"
#include "COCBot\CGB GUI Design.au3"
#include "COCBot\CGB GUI Control.au3"
#include "COCBot\CGB Functions.au3"

CheckPrerequisites() ; check for VC2010 and .NET software

DirCreate($sTemplates)
DirCreate($sProfilePath & "\" & $sCurrProfile)
DirCreate($dirLogs)
DirCreate($dirLoots)
DirCreate($dirTemp)
FileMove(@ScriptDir & "\*.ini", $sProfilePath & "\" & $sCurrProfile, $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Logs", $sProfilePath & "\" & $sCurrProfile & "\Logs", $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Loots", $sProfilePath & "\" & $sCurrProfile & "\Loots", $FC_OVERWRITE + $FC_CREATEPATH)
DirCopy(@ScriptDir & "\Temp", $sProfilePath & "\" & $sCurrProfile & "\Temp", $FC_OVERWRITE + $FC_CREATEPATH)
DirRemove(@ScriptDir & "\Logs", 1)
DirRemove(@ScriptDir & "\Loots", 1)
DirRemove(@ScriptDir & "\Temp", 1)

if $ichkDeleteLogs  = 1 then DeleteFiles($dirLogs ,"*.*",$iDeleteLogsDays ,0)
if $ichkDeleteLoots = 1 then DeleteFiles($dirLoots,"*.*",$iDeleteLootsDays,0)
if $ichkDeleteTemp  = 1 then DeleteFiles($dirTemp ,"*.*",$iDeleteTempDays ,0)
FileChangeDir ( $LibDir )

;CGBfunctions.dll debugger
debugCGBFunctions($debugSearchArea, $debugRedArea, $debugOcr) ; set debug levels

AdlibRegister("PushBulletRemoteControl", $PBRemoteControlInterval)
AdlibRegister("PushBulletDeleteOldPushes", $PBDeleteOldPushesInterval)

CheckVersion() ; check latest version on gamebot.org site

;AutoStart Bot if request
AutoStart()

While 1
	Switch TrayGetMsg()
        Case $tiAbout
			MsgBox(64 + $MB_APPLMODAL + $MB_TOPMOST, $sBotTitle, "Clash of Clans Bot" & @CRLF & @CRLF & _
				getLocaleString("msgboxVersion") & $sBotVersion & @CRLF & _
				getLocaleString("msgboxLicense"), 0, $frmBot)
		Case $tiExit
			ExitLoop
	EndSwitch
WEnd

Func runBot() ;Bot that runs everything in order
	$TotalTrainedTroops = 0
	While 1
		$Restart = False
		$fullArmy = False
		$CommandStop = -1
		If _Sleep(1000) Then Return
		checkMainScreen()
		If $Is_ClientSyncError = False Then
			If BotCommand() Then btnStop()
			If _Sleep(800) Then Return
			checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			If $iChkUseCCBalanced = 1 then
			    ProfileReport()
			    If _Sleep(800) Then Return
			    checkMainScreen(False)
			    If $Restart = True Then ContinueLoop
			EndIf
			if $RequestScreenshot = 1 then PushMsg("RequestScreenshot")
				If _Sleep(200) Then Return
			Collect()
				If _Sleep(1000) Then Return
				If $Restart = True Then ContinueLoop
			CheckTombs()
				If _Sleep(200) Then Return
				If $Restart = True Then ContinueLoop
			ReArm()
				If _Sleep(200) Then Return
				If $Restart = True Then ContinueLoop
			ReplayShare($iShareAttackNow)
				If _Sleep(200) Then Return
				If $Restart = True Then ContinueLoop
			VillageReport()
				If $OutOfGold = 1  And ($GoldCount >= $itxtRestartGold) Then  ; check if enough gold to begin searching again
					$OutOfGold = 0  ; reset out of gold flag
					Setlog(getLocaleString("logOutOfGold"), $COLOR_RED)
					$ichkBotStop = 0  ; reset halt attack variable
					ContinueLoop ; Restart bot loop to reset $CommandStop
				EndIf
				If $OutOfElixir = 1  And ($ElixirCount >= $itxtRestartElixir) And ($DarkCount >= $itxtRestartDark) Then  ; check if enough elixir to begin searching again
					$OutOfElixir = 0  ; reset out of gold flag
					Setlog(getLocaleString("logOutOfElixir"), $COLOR_RED)
					$ichkBotStop = 0  ; reset halt attack variable
					ContinueLoop ; Restart bot loop to reset $CommandStop
				EndIf
				If _Sleep(500) Then Return
				checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			ReportPushBullet()
				If _Sleep(200) Then Return
				If $Restart = True Then ContinueLoop
			DonateCC()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)  ; required here due to many possible exits
				If $Restart = True Then ContinueLoop
			Train()
				If _Sleep(1000) Then Return
			    checkMainScreen(False)
				If $Restart = True Then ContinueLoop
			BoostBarracks()
				If $Restart = True Then ContinueLoop
			BoostSpellFactory()
				If $Restart = True Then ContinueLoop
			RequestCC()
				If _Sleep(1000) Then Return
				checkMainScreen(False) ; required here due to many possible exits
				If $Restart = True Then ContinueLoop
			If $iUnbreakableMode >= 1 Then
				If Unbreakable() = True Then ContinueLoop
			Endif
			Laboratory()
				If _Sleep(200) Then Return
				checkMainScreen(False)  ; required here due to many possible exits
				If $Restart = True Then ContinueLoop
			UpgradeBuilding()
				If _Sleep(200) Then Return
				If $Restart = True Then ContinueLoop
			UpgradeWall()
				If _Sleep(2100) Then Return
				If $Restart = True Then ContinueLoop
			Idle()
				If _Sleep(200) Then Return
				If $Restart = True Then ContinueLoop
			If $CommandStop <> 0 And $CommandStop <> 3 Then
				AttackMain()
				If $OutOfGold = 1  Then
					Setlog(getLocaleString("logSwitchHaltAttack"), $COLOR_RED)
					$ichkBotStop = 1  ; set halt attack variable
					$icmbBotCond = 16  ; set stay online/collect only mode
					$FirstStart = True  ; reset First time flag to ensure army balancing when returns to training
					ContinueLoop
				Endif
				If _Sleep(1000) Then Return
				If $Restart = True Then ContinueLoop
			EndIf
				;
		Else ;When error occours directly goes to attack
			SetLog(getLocaleString("logOOS"), $COLOR_RED)
			PushMsg("OutOfSync")
			checkMainScreen(False)
			AttackMain()
			If $OutOfGold = 1  Then
				Setlog(getLocaleString("logReturnHaltAttack"), $COLOR_RED)
				$ichkBotStop = 1  ; set halt attack variable
				$icmbBotCond = 16  ; set stay online/collect only mode
				$FirstStart = True  ; reset First time flag to ensure army balancing when returns to training
				$Is_ClientSyncError = False  ; reset fast restart flag to stop OOS mode and start collecting resources
				ContinueLoop
			Endif
			If _Sleep(500) Then Return
			If $Restart = True Then ContinueLoop
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds
	If $debugSetlog = 1 Then SetLog("Func Idle ", $COLOR_PURPLE)
	While $fullArmy = False
		if $RequestScreenshot = 1 then PushMsg("RequestScreenshot")
		If _Sleep(200) Then Return
		If $CommandStop = -1 Then SetLog(getLocaleString("logArmyWait"), $COLOR_GREEN)
		Local $hTimer = TimerInit()
		Local $iReHere = 0
		While $iReHere < 7
			$iReHere += 1
			DonateCC(True)
			If _Sleep(1500) Then ExitLoop
			If $Restart = True Then ExitLoop
		WEnd
		If _Sleep(200) Then ExitLoop
		checkMainScreen(False) ; required here due to many possible exits
		If ($CommandStop = 3 Or $CommandStop = 0) Then
			CheckOverviewFullArmy(True)
			If Not($FullArmy) And $bTrainEnabled = True Then
				SetLog(getLocaleString("logArmyNotFull"), $COLOR_ORANGE)
				$CommandStop = 0
			EndIf
		EndIf
		ReplayShare($iShareAttackNow)
		If _Sleep(200) Then Return
		If $Restart = True Then ExitLoop
		If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
			Collect()
			If $Restart = True Then ExitLoop
			If _Sleep(200) Or $RunState = False Then ExitLoop
			$iCollectCounter = 0
		EndIf
		$iCollectCounter = $iCollectCounter + 1
		if $CommandStop <> 0 Or $CommandStop <> 3 Then
			Train()
			If $Restart = True Then ExitLoop
			If _Sleep(200) Then ExitLoop
			checkMainScreen(False)
		endif
		If _Sleep(200) Then Return
		If $CommandStop = 0 And $bTrainEnabled = True Then
			If Not($fullarmy) Then
				Train()
				If $Restart = True Then ExitLoop
				If _Sleep(200) Then ExitLoop
				checkMainScreen(False)
				If $fullArmy Then
					SetLog(getLocaleString("logArmyFull"), $COLOR_ORANGE)
					$CommandStop = 3
				EndIf
			EndIf
		EndIf
		If _Sleep(200) Then Return
		If $CommandStop = -1 Then
			DropTrophy()
			If $Restart = True Then ExitLoop
			If $fullArmy Then ExitLoop
			If _Sleep(200) Then ExitLoop
			checkMainScreen(False)
		EndIf
		If _Sleep(200) Then Return
		If $Restart = True Then ExitLoop
		$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
		SetLog(getLocaleString("logIdle") & StringFormat("%02i", Floor(Floor($TimeIdle / 60) / 60)) & ":" & StringFormat("%02i", Floor(Mod(Floor($TimeIdle / 60), 60))) & ":" & StringFormat("%02i", Floor(Mod($TimeIdle, 60))))
		If $OutOfGold = 1 Then Return
	WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions
   ;launch profilereport() only if option balance D/R it's activated
	If $iChkUseCCBalanced = 1 then
		ProfileReport()
		checkMainScreen(False)
		If $Restart = True Then Return
		If _Sleep(1000) Then Return
	EndIf
	PrepareSearch()
		If $OutOfGold = 1  Then Return ; Check flag for enough gold to search
		If $Restart = True Then Return
	VillageSearch()
		If $OutOfGold = 1  Then Return ; Check flag for enough gold to search
		If $Restart = True Then Return
	PrepareAttack($iMatchMode)
		If $Restart = True Then Return
	;checkDarkElix()
	;DEAttack()
		If $Restart = True Then Return
	Attack()
		If $Restart = True Then Return
	ReturnHome($TakeLootSnapShot)
		If _Sleep(1500) Then Return
	Return True
EndFunc   ;==>AttackMain

Func Attack() ;Selects which algorithm
	SetLog(getLocaleString("logAtkStart"), $COLOR_GREEN)
	algorithm_AllTroops()
EndFunc   ;==>Attack
