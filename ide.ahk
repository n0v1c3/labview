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
; TODO-TJG[180225] ~ Handle multiple monitors
Loop, %MonitorCount%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor, Monitor, %A_Index%
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
	if (Debug) {
		MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
	}
}

xOffset := -1920

; TODO-TJG [180226] ~ Change to array of data
lvControls := "Controls"
lvControlsWidth := 400
lvControlsHeight := 250
lvControlsX := 0
lvControlsY := MonitorWorkAreaBottom - lvControlsHeight

lvFunctions := "Functions"
lvFunctionsWidth := lvControlsWidth
lvFunctionsHeight := lvControlsHeight
lvFunctionsX := 0
lvFunctionsY := MonitorWorkAreaBottom - lvFunctionsHeight


lvProj := "Project Explorer"
lvProject := "Project Explorer"
lvProjectWidth := lvControlsWidth
lvProjectHeight := MonitorWorkAreaBottom - lvControlsHeight
lvProjectX := 0
lvProjectY := 0

lvPanel := "Front Panel"
lvPanelWidth := A_ScreenWidth - lvControlsWidth
lvPanelHeigth := MonitorWorkAreaBottom - lvControlsHeight
lvPanelX := lvControlsWidth
lvPanelY := 0

lvBlock := "Block Diagram"
lvBlockWidth := A_ScreenWidth - lvControlsWidth
lvBlockHeight := MonitorWorkAreaBottom - lvControlsHeight
lvBlockX := lvControlsWidth
lvBlockY := 0

; Layout LabVIEW windows into an IDE format
^+e::
WinGet windows, List
Loop %windows%
{
	lvWindow := False
	
	id := windows%A_Index%
	WinGetTitle wt, ahk_id %id%
	
	; TODO-TJG [180226] ~ Use data array to find index of valid values for current window
	IfInString, wt, %lvProject%
	{
		lvWinX := lvProjectX
		lvWinY := lvProjectY
		lvWinWidth := lvProjectWidth
		lvWinHeight := lvProjectHeight
		lvWindow := True
	}
	
	Else IfInString, wt, %lvPanel%
	{
		lvWinX := lvPanelX
		lvWinY := lvPanelY
		lvWinWidth := lvPanelWidth
		lvWinHeight := lvPanelHeight
		lvWindow := True
	}
	
	Else IfInString, wt, %lvBlock%
	{
		lvWinX := lvBlockX
		lvWinY := lvBlockY
		lvWinWidth := lvBlockWidth
		lvWinHeight := lvBlockHeight
		lvWindow := True
	}
	
	Else IfInString, wt, %lvControls%
	{
		lvWinX := lvControlsX
		lvWinY := lvControlsY
		lvWinWidth := lvControlsWidth
		lvWinHeight := lvControlsHeight
		lvWindow := True
	}
	
	Else IfInString, wt, %lvFunctions%
	{
		lvWinX := lvFunctionsX
		lvWinY := lvFunctionsY
		lvWinWidth := lvFunctionsWidth
		lvWinHeight := lvFunctionsHeight
		lvWindow := True
	}
	
	If lvWindow
	{
		WinMove, %wt%,, lvWinX + xOffset, lvWinY, lvWinWidth, lvWinHeight
	}
}
Return