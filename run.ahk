; run.ahk
; Description: Run and manage all the scripts for labview
; Author: Travis Gall


; #Persistent
; SetTimer, ActivateWinUM, 100
; return

; ActivateWinUM:
; MouseGetPos,,, WinUMID
; WinActivate, ahk_id %WinUMID%
; return

#Include lib\init.ahk
#Include lib\layout.ahk
#Include lib\labview.ahk

#Include func\explorer.ahk
#Include func\ide.ahk
#Include func\quickkeys.ahk
; #Include func\rocker.ahk
; #Include func\tracker.ahk
#Include func\windrag.ahk

;For Key, Value In LayoutList
  ; WinActivateMove(Value)

#Include lib\mappings.ahk
