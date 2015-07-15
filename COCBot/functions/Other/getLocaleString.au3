Func getLocaleString($Key)
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
	Return $ReturnStr
EndFunc   ;==>getLocaleString

;~ Func getLocaleStringFormatted($Key)
;~ 	$ReturnStrFormatted = ""
;~ 	If IsDeclared("cmbLanguage") Then
;~ 		$array = _GUICtrlComboBox_GetListArray($cmbLanguage)
;~ 		$CurrLangSel = $array[_GUICtrlComboBox_GetCurSel($cmbLanguage) + 1]
;~ 		$ReturnStrFormatted = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\" & $CurrLangSel & ".ini", "general", $Key, "")
;~ 		If $ReturnStrFormatted = "" Then
;~ 			$ReturnStrFormatted = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\English.ini", "general", $Key, "")
;~ 		EndIf
;~ 	Else
;~ 		$ReturnStrFormatted = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\" & $StartupLanguage & ".ini", "general", $Key, "")
;~ 		If $ReturnStrFormatted = "" Then
;~ 			$ReturnStrFormatted = IniRead(@ScriptDir & "\COCBot\GUI\localization\languages\English.ini", "general", $Key, "")
;~ 		EndIf
;~ 	EndIf
;~ 	$ReturnStrFormatted = StringFormat($ReturnStrFormatted)
;~ 	Return $ReturnStrFormatted
;~ EndFunc   ;==>getLocaleStringFormatted


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
