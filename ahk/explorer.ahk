#NoEnv

SendMode Input
SetWorkingDir %A_ScriptDir%

; TODO-TJG [180514] ~ Bring active window to center of the current monitor adjust for multiple monitors
; TODO-TJG [180514] ~ Open minimum of 3 Explorer windows
; TODO-TJG [180514] ~ Toggle should be Normal, Always on Top, Always on bottom
; TODO-TJG [180514] ~ Shortcut to display all active Explorer windows on top
; TODO-TJG [180514] ~ Snip close "Tool-bar" window
; TODO-TJG [180514] ~ Snip auto-save to downloads folder and close snip window
; TODO-TJG [180514] ~ Check if Outlook is open prior to re-open
; TODO-TJG [180514] ~ Selector for "Primary" Explorer monitor
; TODO-TJG [180514] ~ {Win}{c} for PowerShell terminal window

<#NumPad5::
	WinGetPos,,, Width, Height, A
    WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
Return

; Activate all Explorer windows
<#e::
WinGet, explorerWindows, List, ahk_class CabinetWClass
Loop %explorerWindows%
	WinActivate, % "ahk_id " . explorerWindows%A_Index%
Return

; Activate the terminal windows
<#t::
WinGet, terminalWindows, List, ahk_class mintty
Loop %terminalWindows%
{
	WinGetPos, x, y, width, height, % "ahk_id " . terminalWindows%A_Index%

	If x < -1920
	{
		WinActivate, % "ahk_id " . terminalWindows%A_Index%
	}
}
Return

; Activate the putty windows
<#p::
WinGet, terminalWindows, List, ahk_class PuTTY
Loop %terminalWindows%
{
	WinActivate, % "ahk_id " . terminalWindows%A_Index%
}
Return

<#s::
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

#m::
	Run "C:\Program Files (x86)\National Instruments\MAX\NIMax.exe"
Return

#o::
	Run "Outlook.exe"
	Send, #{Up}
	Send, #{Right}
Return

^SPACE:: 
Winset, Alwaysontop, , A
Return

/*
NumPad4::
WinGetPos, X, Y, W, H, A, , ,
WinMove, A, , 1600, , 960,
Return

NumPad6::
WinGetPos, X, Y, W, H, A, , ,
WinMove, A, , 2560, , 960,
Return
*/