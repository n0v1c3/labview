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

xOffset := 0
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := MonitorWorkAreaBottom - bottomPanelHeight
rightPanelWidth := A_ScreenWidth - leftPanelWidth

; TODO-TJG [180226] ~ Change to array of data
lvControls := "Controls"
lvControlsWidth := leftPanelWidth
lvControlsHeight := bottomPanelHeight
lvControlsX := leftPanelWidth ; In right panel
lvControlsY := bottomPanelY

lvFunctions := "Functions"
lvFunctionsWidth := leftPanelWidth
lvFunctionsHeight := bottomPanelHeight
lvFunctionsX := leftPanelWidth ; In right panel
lvFunctionsY := bottomPanelY


lvProj := "Project Explorer"
lvProject := "Project Explorer"
lvProjectWidth := leftPanelWidth
lvProjectHeight := bottomPanelY
lvProjectX := 0
lvProjectY := 0

lvPanel := "Front Panel"
lvPanelWidth := rightPanelWidth
lvPanelHeight := bottomPanelY
lvPanelX := leftPanelWidth
lvPanelY := 0

lvBlock := "Block Diagram"
lvBlockWidth := rightPanelWidth
lvBlockHeight := bottomPanelY
lvBlockX := leftPanelWidth
lvBlockY := 0

lvProbes := "Probe Watch"
lvProbesWidth := rightPanelWidth - leftPanelWidth
lvProbesHeight := bottomPanelHeight
lvProbesX := leftPanelWidth * 2
lvProbesY := bottomPanelY

lvBookmarks := "Bookmark Manager"
lvBookmarksWidth := rightPanelWidth - leftPanelWidth
lvBookmarksHeight := bottomPanelHeight
lvBookmarksX := leftPanelWidth * 2
lvBookmarksY := bottomPanelY

lvTools := "Tools"
lvToolsX := MonitorWorkAreaRight - 115
lvToolsY := bottomPanelY - 200

; Layout LabVIEW windows into an IDE format
$^e::
Send, ^e
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
	
	Else IfInString, wt, %lvProbes%
	{
		lvWinX := lvProbesX
		lvWinY := lvProbesY
		lvWinWidth := lvProbesWidth
		lvWinHeight := lvProbesHeight
		lvWindow := True
	}
	
	Else IfInString, wt, %lvTools%
	{
		lvWinX := lvToolsX
		lvWinY := lvToolsY
		lvWinWidth := lvToolsWidth
		lvWinHeight := lvToolsHeight
		lvWindow := True
	}
	
	Else IfInString, wt, %lvBookmarks%
	{
		lvWinX := lvBookmarksX
		lvWinY := lvBookmarksY
		lvWinWidth := lvBookmarksWidth
		lvWinHeight := lvBookmarksHeight
		lvWindow := True
	}
	
	If lvWindow
	{
		WinMove, %wt%,, lvWinX + xOffset, lvWinY, lvWinWidth, lvWinHeight
	}
}
Return

; TODO-TJG [180226] ~ Create shortcuts for align left and bottom
^{Left}::
Return

^{Down}::
Return
