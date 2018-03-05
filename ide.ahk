#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
Loop, %MonitorCount%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor, Monitor, %A_Index%
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
}

; General IDE Sizing and Positions
xOffset := -1920
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := MonitorWorkAreaBottom - bottomPanelHeight
rightPanelWidth := A_ScreenWidth - leftPanelWidth

; Specific IDE Sizing and Positions
Row := 0
LVWindowInfo := []

Row += 1
LVWindowInfo[Row,1] := "Controls"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Functions"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Project Explorer"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelY
LVWindowInfo[Row,4] := 0
LVWindowInfo[Row,5] := 0

; Do NOT reposition or resize the Front Panel
Row += 1
LVWindowInfo[Row,1] := "Front Panel"
; LVWindowInfo[Row,2] := rightPanelWidth
; LVWindowInfo[Row,3] := bottomPanelY
; LVWindowInfo[Row,4] := leftPanelWidth
; LVWindowInfo[Row,5] := 0

Row += 1
LVWindowInfo[Row,1] := "Block Diagram"
LVWindowInfo[Row,2] := rightPanelWidth
LVWindowInfo[Row,3] := bottomPanelY
LVWindowInfo[Row,4] := leftPanelWidth
LVWindowInfo[Row,5] := 0

Row += 1
LVWindowInfo[Row,1] := "Probe Watch"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Bookmark Manager"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Navigation"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := 0
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
; Do NOT change the size of the Tools window
LVWindowInfo[Row,1] := "Tools"
LVWindowInfo[Row,4] := leftPanelWidth + rightPanelWidth - 115
LVWindowInfo[Row,5] := bottomPanelY - 200

; Activate Block Diagram selected from the dropdown list
SelectBlockDiagram:
Gui, LVBD: Submit
WinActivate, %BlockDiagram%
Return

; Display the Block Diagram dropdown list
^`::
BlockDiagramList := CurrentBlockDiagrams()
Gui, LVBD: New, , LV - Blocks
Gui, Add, DropDownList, w600 vBlockDiagram, %BlockDiagramList%
Gui, Show, , LV - Blocks
Return

; Window specific shortcuts for the LVBD GUI
#IfWinActive LV - Blocks
; Submit
Enter::
	GoSub, SelectBlockDiagram
Return

; Hide
~Esc::
Gui, LVBD: Hide
Return
#IfWinActive

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
		xOffset := MonitorWorkAreaLeft
	}
}


; Layout LabVIEW windows into an IDE format
^+`::
WinGet windows, List
Loop %windows%
{
	id := windows%A_Index%
	WinGetTitle wt, ahk_id %id%
	lvWindow := False
	
	For Row in LVWindowInfo
	{
		LVWindowTitle := LVWindowInfo[Row,1]
		IfInString, wt, %LVWindowTitle%
		{
			LVWindowWidth := LVWindowInfo[Row,2]
			LVWindowHeight := LVWindowInfo[Row,3]
			LVWindowX := LVWindowInfo[Row,4]
			LVWindowY := LVWindowInfo[Row,5]
			WinMove, %wt%,, LVWindowX + xOffset, LVWindowY, LVWindowWidth, LVWindowHeight
		}
	}
}
Return

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
MouseClick
KeyWait Ctrl ; Prevent key repeat
Return

; Reload this script
F12::
Reload
Return

; Kill this script
+F12::
ExitApp
Reload

; Get list of open Block Diagrams for a dropdown list
CurrentBlockDiagrams()
{
	; TODO-TJG [180302] ~ Better access to this variable from the array
	lvBlock := "Block Diagram"
	WindowList := ""
	isFirst := True
	
	WinGet windows, List
	Loop %windows%
	{
		id := windows%A_Index%
		WinGetTitle wt, ahk_id %id%
		IfInString, wt, %lvBlock%
		{
			WindowList .= (isFirst ? wt "|" : "|" wt)
			isFirst := False
		}
	}
	Return WindowList
}
