; Author: Travis Gall
; Title: quickkeys.ahk
; Description : Capture keys pressed while another key is
;               pressed.
;               ex// ; Press down LWin press other keys release
;                    ; the win key, run command from lookup.
;                    QuickKeys("LWin")

; Debug := True

#InstallKeybdHook

KeyHistory
WinSet, Transparent, 0, ahk_class AutoHotkey

; Return keys between "keywatch" as a single string
QuickKeys(keywatch)
{
  Global Debug
  If Debug
    T := A_TickCount

  KeyWait, % keywatch

  ; Open the key history window and copy all contents
  KeyHistory
  ControlGetText keyhistorylines, Edit1, ahk_class AutoHotkey
  Send, !{F4}

  ; Key log.... I guess I just made a key logger :-)
  keylog := []
  Loop, parse, keyhistorylines, `n
    keylog.Insert(1, A_LoopField)

  ; The string the user typed
  For Each, key In keylog
  {
    ; Enable logging only when pressed
    If InStr(key, keywatch)
    {
      rb_up := InStr(key, "`tu`t")
      If !rb_up
        break
    }

    ; Build the string as key LIFT
    Else If rb_up And InStr(key, "`tu`t")
      keystring := SubStr(key, 17) . keystring
  }

  ; Remove all the crap
  StringReplace, keystring, keystring, `r,,A
  StringReplace, keystring, keystring, `n,,A
  StringReplace, keystring, keystring, %A_Space%,,A
  StringReplace, keystring, keystring, %A_Tab%,,A

  ; Mappings {{{
  If (keystring == "4")
    Send, {RButton}{Down}{Right}{Enter}{Enter}{LButton Down}
  If (keystring == "w")
    Send, {RButton}{Down}{Right}{Enter}{Right}{Enter}{LButton Down}
	
  Else If (keystring == "add")
    Send, {RButton}{Down}{Right}{Down}{Enter}{Enter}
  Else If (keystring == "sub")
    Send, {RButton}{Down}{Right}{Down}{Enter}{Right}{Enter}

  ; Normal Operation {{{
  Else
    Send, {%keywatch%}

  ; Debugging {{{
  If Debug
  {
    ToolTip, % (A_TickCount - T) . " | " . KeyString
    Sleep, 1000
    ToolTip
  }
}
