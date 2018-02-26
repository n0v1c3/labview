#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)

Debug := False

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

lvControls := "Controls"
lvControlsWidth := 375
lvControlsHeight := 250
lvControlsX := 0
lvControlsY := MonitorWorkAreaBottom - lvControlsHeight

lvFunctions := "Functions"
lvFunctionsWidth := lvControlsWidth
lvFunctionsHeight := lvControlsHeight
lvFunctionsX := 0
lvFunctionsY := MonitorWorkAreaBottom - lvFunctionsHeight


lvProj := "lvproj"
lvProjectWidth := lvControlsWidth
lvProjectHeight := MonitorWorkAreaBottom - lvControlsHeight
lvProjectX := 0
lvProjectY := 0

lvPanel := "Front Panel"
lvPanelWidth := A_ScreenWidth - lvControlsWidth
lvPanelHeigth := MonitorWorkAreaBottom
lvPanelX := lvControlsWidth
lvPanelY := 0

lvBlock := "Block Diagram"
lvBlockWidth := A_ScreenWidth - lvControlsWidth
lvBlockHeight := MonitorWorkAreaBottom
lvBlockX := lvControlsWidth
lvBlockY := 0

; Make active window into a project explorer
^+e::
WinGetTitle, OriginalWindow, A

WinGet windows, List
Loop %windows%
{
	id := windows%A_Index%
	WinGetTitle wt, ahk_id %id%
	IfInString, wt, lvProj
	{
		if (Debug) {
			MsgBox %wt%
		}
		
		WinActivate, %wt%
		WinGetTitle, WinTitle, A
		
		IfInString, wt, %lvPanel%
		{
			WinMove, %WinTitle%,, lvPanelX, lvPanelY, lvPanelWidth, lvPanelHeigth
		}
		Else
		{
			IfInString, wt, %lvBlock%
			{
				WinMove, %WinTitle%,, lvBlockX, lvBlockY, lvBlockWidth, lvBlockHeight
			}
			Else
			{
				WinMove, %WinTitle%,, lvProjectX, lvProjectY, lvProjectWidth, lvProjectHeight
			}
		}
	}
}

WinActivate, %OriginalWindow%
Return