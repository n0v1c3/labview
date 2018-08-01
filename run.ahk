; run.ahk
; Description: Run and manage all the scripts for labview
; Author: Travis Gall

#Include lib\init.ahk
#Include lib\system.ahk
#Include lib\labview.ahk

#Include ahk\ide.ahk
#Include ahk\explorer.ahk
#Include ahk\rocker.ahk
; #Include ahk\tracker.ahk

; GUI Hooks {{{1
; Keyboard {{{2
; C {{{3
; Chrome
#c::
  ; WinActivateMove("ahk_exe chrome.exe", -3840, 0, 1264, 1080)
  WinActivateMove2(Layouts[Chrome])
Return

; D {{{3
; Delete
$^d::
  ; Delete > Outlook
  IfWinActive, % "ahk_exe" . "OUTLOOK.exe"
  {
    Send, ^{q}
    Send, ^{d}
    Send, {Up}
  }
  Else
  {
    Send, ^{d}
  }
Return

; E {{{3
; Explorer
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

; F {{{3
; FracCommandSetup
#f::
  winActivateMove("ahk_exe FCS.exe", -3840, 0, 1264, 720)
Return

; I {{{3
; LabVIEW IDE
#i::
  ; TODO-TJG [180731] - Fix this useless activate
  WinActivate, % "ahk_exe" . "LabVIEW.exe"
Return

; M {{{3
; NIMax
#m::
  winActivateMove("ahk_exe NIMax.EXE", -2579, 0, 655, 1080)
Return

; G {{{3
; FCSLicenseGenerator
#g::
  winActivateMove("ahk_exe FCSLicenseGenerator.exe", -2579, 0, 655, 1080)
Return

; N {{{3
; Notepad++
#n::
  WinActivateMoveAll("ahk_exe notepad++.exe", -3840, 0, 1264, 720)
Return

; O {{{3
; Outlook
#o::
  WinActivateMoveAll("ahk_exe OUTLOOK.exe", -2579, 0, 655, 1080)
Return

; P {{{3
; Perforce
#p::
  WinActivateMoveAll("ahk_exe p4v.exe", -2579, 0, 655, 1080)
Return

; Q {{{3
; Qlarity
#q::
  ; ahk_class used to prevent the "Tool-Tip" window from being moved instead of the Qlarity window
  winActivateMove("ahk_class Afx:00400000:0", -3840, 0, 1264, 720) Return

; S {{{3
; Snipper
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

; Save logger
$^s::
  ; Tracker()
  Send, ^s
Return

; T {{{3
; Terminal
#t::
  WinActivateMove("ahk_exe mintty.exe", -1920, 0, 1920, 830)
Return

; U {{{3
; Terminal
#u::
  WinActivateMove("ahk_exe Testify - Scripting.exe", -3840, 0, 1264, 720)
Return

; ` {{{3

; 'F' Keys {{{3
; Reload this AHK script
F12::
  Reload
  ; Will not reach this line
Return

; Kill this AHK script
+F12::
  ExitApp
  ; Will not reach this line
Return

; Mouse {{{2

~*RButton::
  RRocker()
Return

~*LButton::
  LRocker()
Return

