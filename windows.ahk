#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)

Debug := False
XOffset := -10

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
if (Debug) {
	MsgBox, Monitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
}
; TODO-TJG[180225] ~ Handle multple monitors
Loop, %MonitorCount%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor, Monitor, %A_Index%
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
	if (Debug) {
		MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
	}
}

; TODO-TJG[180225] ~ Shortcut to organize all LabVIEW windows for a project
; Make active window into a project explorer
#+a::
WinGetTitle, WinTitle, A
WinMove, %WinTitle%,, (XOffset), 0, (A_ScreenWidth*0.2), (MonitorWorkAreaBottom)
Return

; TODO-TJG[180225] ~ Override LabVIEW Ctrl+E to put the next workspace into place
; Make active window into a workspace
#+s::
WinGetTitle, WinTitle, A
WinMove, %WinTitle%,, (A_ScreenWidth*0.2+(2*XOffset)), 0, (A_ScreenWidth*0.8-(2*XOffset)), (MonitorWorkAreaBottom)
Return