Func getLocaleString($Key,$Formetted = False)
	$ReturnStr = ""
	If IsDeclared("cmbLanguage") Then
		$array = _GUICtrlComboBox_GetListArray($cmbLanguage)
		$CurrLangSel = $array[_GUICtrlComboBox_GetCurSel($cmbLanguage) + 1]
		$ReturnStr = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\" & $CurrLangSel & ".ini", "general", $Key, "")
		If $ReturnStr = "" Then
			$ReturnStr = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\English.ini", "general", $Key, "")
		EndIf
	Else
		$ReturnStr = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\" & $StartupLanguage & ".ini", "general", $Key, "")
		If $ReturnStr = "" Then
			$ReturnStr = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\English.ini", "general", $Key, "")
		EndIf
	EndIf
	If $Formetted = True Then
		Return StringFormat($ReturnStr)
	Else
		Return $ReturnStr
	EndIf
EndFunc   ;==>getLocaleString

Func Populatelocalization()
	$searchfile = FileFindFirstFile(@ScriptDir & "\COCBot\GUI\localization\languages\*.ini")
	$txtLang = ""
	While True
		$newfile = FileFindNextFile($searchfile)
		If @error Then ExitLoop
		$txtLang = $txtLang & StringLeft($newfile, StringLen($newfile) - 4) & "|"
	WEnd
	FileClose($searchfile)
	$txtLang = StringLeft($txtLang, StringLen($txtLang) - 1)
	_GUICtrlComboBox_ResetContent($cmbLanguage)
	GUICtrlSetData($cmbLanguage, $txtLang)
EndFunc   ;==>Populatelocalization
