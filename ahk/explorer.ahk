; ide.ahk
; Description: Windows that are not part of LabVIEW require management too
; Author: Travis Gall

; Setup {{{1
; Enable warnings to assist with detecting common errors.
; #Warn
; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv
; Replace old script with new script without confirmation
#SingleInstance Force
; Recommended for new scripts due to its superior speed and reliability.
SendMode Input
; Ensures a consistent starting directory.
SetWorkingDir %A_ScriptDir%
; Partial tital match enabled
SetTitleMatchMode, 2

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

; LabVIEW IDE (position is currently handled in the ide.ahk script)
#i::
	WinActivate, % "ahk_exe" . "LabVIEW.exe"
Return

^SPACE:: 
Winset, Alwaysontop, , A
Return
