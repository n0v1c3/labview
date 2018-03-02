#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Name: ide.ahk
; Description: Manage windows to create a simulated IDE for LabVIEW development
; TODOs:
; TODO-TJG [180227] ~ Open all mandatory windows if they are not open yet
; TODO-TJG [180225] ~ Handle multiple monitors
; TODO-TJG [180226] ~ Change to array of data
; TODO-TJG [180227] ~ Store original window properties and restore on save
; TODO-TJG [180228] ~ Center Block Diagram based off navigation window

xOffset := -1920 ; Default xOffset (IDE on primary monitor)

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
Loop, %MonitorCount%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor, Monitor, %A_Index%
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
	; MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
	if (MonitorWorkAreaLeft < xOffset)
	{
		; xOffset := MonitorWorkAreaLeft
	}
}


leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := MonitorWorkAreaBottom - bottomPanelHeight
rightPanelWidth := A_ScreenWidth - leftPanelWidth

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
lvProbesWidth := (rightPanelWidth - leftPanelWidth)/2
lvProbesHeight := bottomPanelHeight
lvProbesX := leftPanelWidth * 2
lvProbesY := bottomPanelY

lvBookmarks := "Bookmark Manager"
lvBookmarksWidth := (rightPanelWidth - leftPanelWidth)/2
lvBookmarksHeight := bottomPanelHeight
lvBookmarksX := leftPanelWidth * 2 + lvProbesWidth
lvBookmarksY := bottomPanelY

lvNavigation := "Navigation"
lvNavigationWidth := leftPanelWidth
lvNavigationHeight := bottomPanelHeight
lvNavigationX := 0
lvNavigationY := bottomPanelY

lvTools := "Tools"
lvToolsX := MonitorWorkAreaRight - 115
lvToolsY := bottomPanelY - 200

; Layout LabVIEW windows into an IDE format
$^`::

; Send the original keystroke to the OS
;Send, ^e
Sleep, 100

WinGet windows, List
Loop %windows%
{
	lvWindow := False
	
	id := windows%A_Index%
	WinGetTitle wt, ahk_id %id%
	
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
		lvWindow := False
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
		lvWindow := False
	}
	
	Else IfInString, wt, %lvBookmarks%
	{
		lvWinX := lvBookmarksX
		lvWinY := lvBookmarksY
		lvWinWidth := lvBookmarksWidth
		lvWinHeight := lvBookmarksHeight
		lvWindow := True
	}
	
	Else IfInString, wt, %lvNavigation%
	{
		lvWinX := lvNavigationX
		lvWinY := lvNavigationY
		lvWinWidth := lvNavigationWidth
		lvWinHeight := lvNavigationHeight
		lvWindow := True
	}
	
	If lvWindow
	{
		WinMove, %wt%,, lvWinX + xOffset, lvWinY, lvWinWidth, lvWinHeight
	}
}
Return