; mappings.ahk
; Description: Manage all shortcut mappings
; Author: Travis Gall

; Arrows {{{2
; Left {{{3
; Left align
^Left::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Down}{Enter}
MouseMove %x%, %y%
Return

; Horizontal center align
^+Left::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Down}{Right}{Enter}
MouseMove %x%, %y%
Return

; Spacing left edges
^!+Left::
MouseGetPos x, y
MouseMove 475, 60
Click
Send, {Down}{Down}{Enter}
MouseMove %x%, %y%
Return

; Up {{{3
; Top align
^Up::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Enter}
MouseMove %x%, %y%
Return

; Vertical center align
^+Up::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Right}{Enter}
MouseMove %x%, %y%
Return

; Spacing top edges
^!+Up::
MouseGetPos x, y
MouseMove 475, 60
Click
Send, {Down}{Enter}
MouseMove %x%, %y%
Return

; Down {{{3
; Bottom align
^Down::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Left}{Enter}
MouseMove %x%, %y%
Return

; Right {{{3
; Right align
^Right::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Down}{Left}{Enter}
MouseMove %x%, %y%
Return

; Keyboard {{{2
; 'F' Keys {{{3
; F1 {{{4
$F1::
Send, {F1}
IfWinActive, Configuration
{
	Sleep, 250
	Send, {Enter}
}
Return
; Reload this AHK script

; F12 {{{4
F12::
  Reload
  ; Will not reach this line
Return

; Kill this AHK script
+F12::
  ExitApp
  ; Will not reach this line
Return

; C {{{3
; Chrome
#c::
  WinActivateMove(LayoutList["chrome"])
  WinActivateMove(LayoutList["youtube"])
  Send, !{Esc}
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
    WinMove, A,, DefaultLayout["3_3"].X+((DefaultLayout["3_3"].W/2)*(A_Index-1)), DefaultLayout["3_3"].Y, DefaultLayout["3_3"].W/2, DefaultLayout["3_3"].H 
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
  WinActivateMove(LayoutList["lv_project"])
  WinActivateMove(LayoutList["lv_block"])
  WinActivateMove(LayoutList["lv_navigation"])
  WinActivateMove(LayoutList["lv_probe"])
  WinActivateMove(LayoutList["lv_bookmark"])
  WinActivateMove(LayoutList["lv_error"])
  WinActivateMove(LayoutList["lv_hierarchy"])
Return

; L {{{3
; Login to "Configuration GUI"
$^l::
Send, ^l
IfWinActive, Configuration
{
	Sleep, 250
	Send, AMI
	Sleep, 100
	Send, {Tab}
	Sleep, 100
  ; TODO-TJG [180804] - Put this in local information and handle versions
	Send, AdvMeas7612
	Sleep, 100
	Send, {Enter}
}
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
;  WinActivateMove(LayoutList["YouTube"])
  WinActivateMove(LayoutList["youtube"])
  Send, !{Esc}
Return

#+y::
;  WinActivateMove(LayoutList["YouTube"])
  WinActivateMove(LayoutList["youtube"])
Return

; Mouse {{{2
; RButton {{{3
~*RButton::
;  RRocker()
Return

; LButton {{{3
~*LButton::
;  LRocker()
Return

; MButton {{{3
; Clean wires
MButton::
  BD_CleanWires()
Return

