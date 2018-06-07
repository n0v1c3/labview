#NoEnv

SendMode Input
SetWorkingDir %A_ScriptDir%

; TODO-TJG [180514] ~ Bring active window to center of the current monitor adjust for multiple monitors
; TODO-TJG [180514] ~ Toggle should be Normal, Always on Top, Always on bottom
; TODO-TJG [180514] ~ Reload script shortcut
	
; Activate all Explorer windows
#e::
WinGet, explorerWindows, List, ahk_class CabinetWClass
Loop %explorerWindows%
{
	WinActivate, % "ahk_id " . explorerWindows%A_Index%
	If A_Index <= 3
	{
		WinMove, A,, -3840, 360 * (A_Index - 1), 1264, 360
	}
}
Return

; Activate the terminal windows
#t::
WinGet, terminalWindows, List, ahk_class mintty
Loop %terminalWindows%
{
	;WinGetPos, x, y, width, height, % "ahk_id " . terminalWindows%A_Index%

	;If x < -1920
	;{
		WinActivate, % "ahk_id " . terminalWindows%A_Index%
		WinMove, A,, -1920, 0, 1920, 830
	;}
}
Return

#n::
WinGet, notepadWindows, List, ahk_class Notepad++
Loop %notepadWindows%
{
	;WinGetPos, x, y, width, height, % "ahk_id " . notepadWindows%A_Index%

	;If x < -1920
	;{
		WinActivate, % "ahk_id " . notepadWindows%A_Index%
		WinMove, A,, -1920, 0, 1920, 830
	;}
}
Return

; Activate the putty windows
; #p::
; WinGet, terminalWindows, List, ahk_class PuTTY
; Loop %terminalWindows%
; {
	; WinActivate, % "ahk_id " . terminalWindows%A_Index%
; }
; Return

#s::
	WinGet, windowList, List, ahk_class Microsoft-Windows-Tablet-SnipperEditor
	; Microsoft-Windows-Tablet-SnipperToolbar
	Loop %windowList%
	{
		WinActivate, % "ahk_id " . windowList%A_Index%
		WinClose, A
		If WinActive("ahk_class #32770")
		{
			Send, {Tab}
			Send, {Enter}
		}
		
	}
	Run "SnippingTool.exe"
Return

#m::
	WinActivate, % "ahk_exe" . "NIMax.EXE"
	WinMove, A,, -2579, 0, 655, 1080 
Return

; Outlook
#o::
	WinActivate, % "ahk_exe" . "OUTLOOK.EXE"
	WinMove, A,, -2579, 0, 655, 1080 
Return

; Chrome
#c::
	WinActivate, % "ahk_exe" . "chrome.exe"
	WinMove, A,, -3840, 0, 1264, 1080 
Return

; Perforce
#p::
	WinActivate, % "ahk_exe" . "p4v.exe"
	WinMove, A,, -2579, 0, 655, 1080 
Return

; Testify (Unit Tests)
#u::
	WinActivate, % "ahk_exe" . "Testify - Scripting.exe"
	WinMove, A,, -3840, 0, 1264, 1080 
Return

; LabVIEW IDE (position is currently handled in the ide.ahk script)
#i::
	WinActivate, % "ahk_exe" . "LabVIEW.exe"
Return

; Calculator (fx)
#f::
	WinActivate, % "ahk_exe" . "calc.exe"
	WinMove, A,, -1920, 780, ,  300
Return

^SPACE:: 
Winset, Alwaysontop, , A
Return
