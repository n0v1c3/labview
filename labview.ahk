; Recommended for performance and compatibility with future AHK releases
#NoEnv
; Replace running version with new version
#SingleInstance Force

; Reload this script
F12::
Reload
Return

; Kill this script
+F12::
ExitApp
Reload

; Slow the mouse down
Alt::
; System DLL for mouse speed
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 2, UInt, 0)
; Prevent key repeat
KeyWait Alt
Return

; Speed the mouse up
Alt Up::
; System DLL for mouse speed
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 10, UInt, 0)
Return

; Click
Ctrl::
; System DLL for mouse speed
MouseClick
; Prevent key repeat
KeyWait Ctrl
Return

; Up::
; MouseGetPos, MouseX, MouseY
; MouseMove, %MouseX%, %MouseY%-10
; Return
