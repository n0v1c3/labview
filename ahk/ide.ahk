﻿; ide.ahk
; Description: Main LabVIEW
; Author: Travis Gall

; Setup {{{1
; Enable warnings to assist with detecting common errors.
; #Warn
; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv
; Replace old script with new script without confirmation
#SingleInstance Force
; Recommended for new scripts due to its superior speed and reliability.
SendMode Input
; Ensures a consistent starting directory.
SetWorkingDir %A_ScriptDir%
; Partial tital match enabled
SetTitleMatchMode, 2

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
Loop, %MonitorCount%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor, Monitor, %A_Index%
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
	if (MonitorWorkAreaLeft == -1920) ; xOffset > MonitorWorkAreaLeft || MonitorWorkAreaLeft == 0)
	{
		xOffset := MonitorWorkAreaLeft
		height := MonitorWorkAreaBottom
		width := MonitorWorkAreaRight - MonitorWorkAreaLeft
	}
}

; General IDE Sizing and Positions
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := height - bottomPanelHeight
rightPanelWidth := width - leftPanelWidth

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
RowPE := Row

; Do NOT resize the Front Panel
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
LVWindowInfo[Row,1] := "Probe Watch Window"
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
LVWindowInfo[Row,1] := "Error list"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "VI Hierarchy"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "LabVIEW Class Hierarchy"
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

; Activate Block Diagram selected from the drop-down list
SelectBlockDiagram:
Gui, LVBD: Submit
WinActivate, %BlockDiagram%
Return

; Display the Block Diagram drop-down list
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

; Layout LabVIEW windows into an IDE format
^+`::
WinGet windows, List
Loop %windows%
{
	id := windows%A_Index%
	WinGetTitle wt, ahk_id %id%

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

; Clean window swap
$^e::
Send, ^e
Sleep, 250
WinGet, currentWindow, ID, A
; WinMove, ahk_id %currentWindow%,, leftPanelWidth, 0
WinActivate, .*Project Explorer
WinActivate, VI Hierarchy
WinActivate, LabVIEW Class Hierarchy
WinActivate, Bookmark Manager
WinActivate, Error list
WinActivate, ahk_id %currentWindow%
Return

!^e::
Send, ^{Space}
Sleep, 200
Send, err
Sleep, 200
Send, {Enter}
Sleep, 200
Click
Sleep, 200
Send, ErrorIn^{Enter}
Return

!^+e::
Send, ^{Space}
Sleep, 200
Send, err
Sleep, 200
Send, {Down}
Sleep, 200
Send, {Enter}
Sleep, 200
Click
Sleep, 200
Send, ErrorOut^{Enter}
Return

; Clean wires
MButton::
	; Prevent shift clicks
	MouseGetPos x, y ; Save current mouse position
	While GetKeyState("Shift", "P")
	{
		Sleep, 1
	}
	MouseMove %x%, %y% ; Prevent small mouse movements

  ; Right click at current mouse location
	Click, Right
	Send, c
	Send, {Enter}
Return

; Left align
^Left::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Down}{Enter}
MouseMove %x%, %y%
Return

; Top align
^Up::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Enter}
MouseMove %x%, %y%
Return

; Bottom align
^Down::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Left}{Enter}
MouseMove %x%, %y%
Return

; Right align
^Right::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Down}{Left}{Enter}
MouseMove %x%, %y%
Return

; Vertical center align
^+Up::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Right}{Enter}
MouseMove %x%, %y%
Return

; Horizontal center align
^+Left::
MouseGetPos x, y
MouseMove 450, 60
Click
Send, {Down}{Down}{Right}{Enter}
MouseMove %x%, %y%
Return

; Spacing top edges
^!+Up::
MouseGetPos x, y
MouseMove 475, 60
Click
Send, {Down}{Enter}
MouseMove %x%, %y%
Return

; Spacing left edges
^!+Left::
MouseGetPos x, y
MouseMove 475, 60
Click
Send, {Down}{Down}{Enter}
MouseMove %x%, %y%
Return

; Center block diagram
^+c::
MouseGetPos x, y
; Positions are relative to the active window
centerX := (leftPanelWidth / 2) - leftPanelWidth
centerY := bottomPanelY + (bottomPanelHeight / 2)
MouseMove %centerX%, %centerY%
Click
MouseMove %x%, %y%
Return

; Slow the mouse down
$Alt::
; System DLL for mouse speed
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 2, UInt, 0)
; Prevent key repeat
; KeyWait Alt
Return

; Speed the mouse up
Alt Up::
; System DLL for mouse speed
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 10, UInt, 0)
Return

; Login to "Configuration GUI"
$^l::
Send, ^l
IfWinActive, Configuration
{
	Sleep, 250
	Send, AMI
	Sleep, 100
	Send, {Tab}
	Sleep, 100
	Send, AdvMeas7612
	Sleep, 100
	Send, {Enter}
}
Return

$F1::
Send, {F1}
IfWinActive, Configuration
{
	Sleep, 250
	Send, {Enter}
}
Return

; Get list of open Block Diagrams for a drop-down list
CurrentBlockDiagrams()
{
	WindowList := ""
	isFirst := True

	WinGet windows, List
	Loop %windows%
	{
		id := windows%A_Index%
		WinGetTitle wt, ahk_id %id%
		IfInString, wt, Block Diagram
		{
			WindowList .= (isFirst ? wt "|" : "|" wt)
			isFirst := False
		}
	}
	Return WindowList
}

