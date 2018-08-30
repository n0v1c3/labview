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

; ` {{{3
; Cycle windows
#`::
  WinBackground()
Return

; Close window under the cursor
#!`::
  WinForeground()
Return

#+`::
  UMID := CursorID()
  WinClose, ahk_id %UMID%
Return

; 1 {{{3
#1::
  WinActivate, % SavedIDs[1]
Return

#!1::
  SavedIDs[1] := "ahk_id " . CursorID()
Return

#2::
  WinActivate, % SavedIDs[2]
Return

#!2::
  SavedIDs[2] := "ahk_id " . CursorID()
Return

#3::
  WinActivate, % SavedIDs[3]
Return

#!3::
  SavedIDs[3] := "ahk_id " . CursorID()
Return

; C {{{3
; Chrome
#c::
  WinActivateMove(LayoutList["chrome"])
  WinActivateMove(LayoutList["youtube"])
  Send, !{Esc}
  
Return

; D {{{3
; Perforce "Depot"
#d::
  WinActivateMove(LayoutList["p4v"])
Return

; Delete
$^d::
  ; Delete > Outlook
  IfWinActive, % LayoutList["outlook"].path
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
  WinActivateMove(LayoutList["explorer_1"])
  WinActivateMove(LayoutList["explorer_2"])
Return

#^e::
  ExplorerSwap(LayoutList["explorer_1"], LayoutList["explorer_2"])
Return

#!e::
  ExplorerSwap(LayoutList["explorer_2"], LayoutList["explorer_1"])
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

; Send e-mail
#+o::
  WinActivateMove(LayoutList["outlook"])
  Send, !S
Return

; P {{{3
; Sticky (Post-It)
#p::
  WinActivateMove(LayoutList["sticky"])
Return

; Q {{{3
; Qlarity
#q::
  WinActivateMove(LayoutList["qlarity"])
Return

; R {{{3
; PuTTy (Remote)
#r::
  WinActivateMove(LayoutList["putty"])
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
IfWinActive Block Diagram
{
  WinGetPos, X, Y, , , A
  WinMove, 0, 0
  Send, ^s
  Sleep, 100
  WinMove, %X%, %Y%
}
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
  IfWinActive Revision Graph
  {
    P4V_HideHistory()
  }
  IfWinActive Block Diagram
  {
    BD_CleanWires()
  }
Return

