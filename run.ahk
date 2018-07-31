; run.ahk
; Description: Run and manage all the scripts for labview
; Author: Travis Gall

#Include lib\init.ahk
#Include lib\system.ahk
#Include lib\labview.ahk

#Include ahk\ide.ahk
#Include ahk\explorer.ahk
#Include ahk\magnifier.ahk
#Include ahk\rocker.ahk
#Include ahk\tracker.ahk

; GUI Hooks {{{1
; Keyboard {{{2
; Alt {{{3

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

; Magnify {{{1
; Clean-Me {{{2
; Shift+Win+a
; Toggle window antialize
#+a::
antialize := !antialize
Return 

; Shift+Win+f
; Toggle window freeze (stop all movement and updates)
#+f::
winFrozen := !winFrozen
Return

; Shift+Win+p
; Toggle window update (play/pause)
#+p::
winEnabled := !winEnabled
Return

; Shift+Win+Up
; Move window offset from cursor up
#+Up::
winMouseOffsetY := winMouseOffsetY - GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Down
; Move window offset from cursor up
#+Down::
winMouseOffsetY := winMouseOffsetY + GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Left
; Move window offset from cursor up
#+Left::
winMouseOffsetX := winMouseOffsetX - GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Right
; Move window offset from cursor up
#+Right::
winMouseOffsetX := winMouseOffsetX + GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+WheelUp
; Zoom in
#+WheelUp::
zoom := zoom + (zoom < ZOOM_LEVEL_MAX ? 1 : 0)
Goto ZoomTooltip
Return

; Shift+Win+WheelDown
; Zoom out
#+WheelDown::
zoom := zoom - (zoom > ZOOM_LEVEL_MIN ? 1 : 0)
Goto ZoomTooltip
Return
