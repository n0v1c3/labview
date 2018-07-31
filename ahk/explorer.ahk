; ide.ahk
; Description: Windows that are not part of LabVIEW require management too
; Author: Travis Gall

; Activate all Explorer windows
WinMoveAll(ClassName, X, Y, W, H)
{
  WindGet, WindowList, List, ahk_class ClassName
  Loop %WindowList%
  {
    WinActivate, % "ahk_id " . WindowList%A_Index%
    WinMove, A,, X, Y, Width, Height
  }
}
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
  WinMoveAll("Notepad++", 0, 0, 1264, 1080)
; WinGet, notepadWindows, List, ahk_class Notepad++
; Loop %notepadWindows%
; {
	;WinGetPos, x, y, width, height, % "ahk_id " . notepadWindows%A_Index%

	;If x < -1920
	;{
		; WinActivate, % "ahk_id " . notepadWindows%A_Index%
		; WinMove, A,, -3840, 0, 1264, 1080 
	;}
; }
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

; TODO-TJG [180726] - These should be functions and variables
#m::
	WinActivate, % "ahk_exe" . "NIMax.EXE"
	WinMove, A,, -2579, 0, 655, 1080 
Return

; Outlook
#o::
	WinActivate, % "ahk_exe" . "OUTLOOK.EXE"
	WinMove, A,, -2579, 0, 655, 1080 
Return

$^d::
IfWinActive, % "ahk_exe" . "OUTLOOK.exe"
{
	Send, ^{q}
	Send, ^{d}
	Send, {Up}
}
Else
	Send, ^{d}
Return

; FCSLicenseGenerator
#g::
	WinActivate, % "ahk_exe" . "FCSLicenseGenerator.exe"
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

; FracCommandSetup
#f::
	WinActivate, % "ahk_exe" . "FCS.exe"
	WinMove, A,, -3840, 0, 1264, 1080 
Return

; Qlarity
#q::
	; ahk_class used to prevent the "Tool-Tip" window from being moved instead of the Qlarity window
	WinActivate, % "ahk_class" . "Afx:00400000:0"
	WinMove, A,, -3840, 0, 1264, 1080 
Return
