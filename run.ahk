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
  WinActivateMove(LayoutList["chrome"])
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
  If A_Index <= 2
  {
    WinMove, A,, -3840 + ((A_Index - 1) * 632), 720, 632, 360
  }
}
Return

; F {{{3
; FracCommandSetup
#f::
  WinActivateMove(LayoutList["fcs"])
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
  WinActivateMove(LayoutList["nimax"])
Return

; G {{{3
; FCSLicenseGenerator
#g::
  WinActivateMove(LayoutList["fcslg"])
Return

; N {{{3
; Notepad++
#n::
  WinActivateMove(LayoutList["notepad"])
Return

; O {{{3
; Outlook
#o::
  WinActivateMove(LayoutList["outlook"])
Return

; P {{{3
; Perforce
#p::
  WinActivateMove(LayoutList["p4v"])
Return

; Q {{{3
; Qlarity
#q::
  WinActivateMove(LayoutList["qlarity"])
Return

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
  WinActivateMove(LayoutList["term"])
Return

; U {{{3
; Testify (Unit Tests)
#u::
  WinActivateMove(LayoutList["testify"])
Return

; Y {{{3
; YouTube
#y::
  WinActivate, YouTube
  WinMove, A,, DefaultLayout["2_4"].X, DefaultLayout["2_4"].Y, DefaultLayout["2_4"].W, DefaultLayout["2_4"].H
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
; RButton {{{3
~*RButton::
  RRocker()
Return

; LButton {{{3
~*LButton::
  LRocker()
Return

