; run.ahk
; Description: Run and manage all the scripts for labview
; Author: Travis Gall

#Include lib\init.ahk
#Include lib\system.ahk
#Include lib\labview.ahk

#Include ahk\ide.ahk
#Include ahk\explorer.ahk
#Include ahk\rocker.ahk
#Include ahk\tracker.ahk

; GUI Hooks {{{1
; Keyboard {{{2
; Alt {{{3

; A {{{3
; S {{{3
^s::
  TrackFile()
  Send, ^s
Return

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

