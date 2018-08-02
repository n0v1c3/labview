; init.ahk
; Description: Initialization for shared scripts
; Author: Travis Gall

; Setup {{{1
; Debug {{{2
; Enable warnings to assist with detecting common errors.
; #Warn

; Environment {{{2
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

; Layout {{{1

; X, Height, Width
; Monitor[0] will always be the "primary" monitor
Monitors := [[]]
MON_X_POS := 0
MON_WIDTH := 1
MON_HEIGHT := 2

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
Loop, %MonitorCount%
{
  SysGet, MonitorName, MonitorName, %A_Index%
  SysGet, Monitor, Monitor, %A_Index%
  SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%

  ; TODO-TJG [180731] - This should be able to handle "X" monitors

  ; Check the "X" offset
  If (MonitorWorkAreaLeft = 0)
  {
    Monitors[0,MON_X_POS] := MonitorWorkAreaLeft ; X-Offset
    Monitors[0,MON_WIDTH] := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
    Monitors[0,MON_HEIGHT] := MonitorWorkAreaBottom ; Height
  }

  ; Monitors[2] will always trail Monitors[1]
  Monitors[2] := Monitors[1]

  ; Note: this is not "Else'd" to ensure reuse of the "zero"
  ;       workspace for this virtual environment
  If (MonitorWorkAreaLeft <= 0)
  {
    Monitors[1,MON_X_POS] := MonitorWorkAreaLeft ; X-Offset
    Monitors[1,MON_WIDTH] := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
    Monitors[1,MON_HEIGHT] := MonitorWorkAreaBottom ; Height
  }
  ; "Right" monitor will be Monitors[2]
  Else
  {
    Monitors[2,MON_X_POS] := MonitorWorkAreaLeft ; X-Offset
    Monitors[2,MON_WIDTH] := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
    Monitors[2,MON_HEIGHT] := MonitorWorkAreaBottom ; Height
  }

  if (MonitorWorkAreaLeft == -1920) ; xOffset > MonitorWorkAreaLeft || MonitorWorkAreaLeft == 0)
  {
    xOffset := MonitorWorkAreaLeft
    height := MonitorWorkAreaBottom
    width := MonitorWorkAreaRight - MonitorWorkAreaLeft
  }
}

; Relative to Monitors
Layouts := [[]]
LAY_NAME := 1
LAY_EXE := 2
LAY_X := 3
LAY_Y := 4
LAY_WIDTH := 5
LAY_HEIGHT := 6

LayoutsLength := 0
CHROME := ++LayoutsLength
EXPLORER := ++LayoutsLength
FCS := ++LayoutsLength
FCSLG := ++LayoutsLength
LABVIEW := ++LayoutsLength
TERM := ++LayoutsLength
NIMAX := ++LayoutsLength
NOTEPAD := ++LayoutsLength
OUTLOOK := ++LayoutsLength
P4V := ++LayoutsLength
QLARITY := ++LayoutsLength
TESTIFY := ++LayoutsLength

Layouts[CHROME] := ["Chrome", "ahk_exe chrome.exe", -3849, 0, 1264, 720]
; Layouts[EXPLORER] := ["Explorer", "ahk_exe Explorer.exe", , , , ]
Layouts[FCS] := ["FCS", "ahk_exe FCS.exe", -3840, 0, 1264, 720]
Layouts[FCSLG] := ["FCSLG", "ahk_exe FCSLicenseGenerator.exe", -2579, 0, 655, 1080]
; Layouts[LABVIEW] := ["LabVIEW", "ahk_exe LabVIEW.exe", , , , ]
Layouts[TERM] := ["term", "ahk_exe mintty.exe", -1920, 0, 1920, 830]
Layouts[NIMAX] := ["NIMax", "ahk_exe NIMax.EXE", -2579, 0, 655, 1080]
Layouts[NOTEPAD] := ["Notepad", "ahk_exe notepad++.exe", -3840, 0, 1264, 720]
LayoutsOUTLOOK[] := ["Outlook", "ahk_exe OUTLOOK.exe", -2579, 0, 655, 1080]
Layouts[P4V] := ["P4V", "ahk_exe p4v.exe", -2579, 0, 655, 1080]
Layouts[QLARITY] := ["Qlarity", "ahk_class Afx:00400000:0", -3840, 0, 1264, 720]
Layouts[TESTIFY] := ["Testify", "ahk_exe Testify - Scripting.exe", -3840, 0, 1264, 720]

ProgramList := []
ProgramList.Push("chrome.exe")
ProgramList.Push("Explorer.exe")
ProgramList.Push("FCS.exe")
ProgramList.Push("FCSLicenseGenerator.exe")
ProgramList.Push("LabVIEW.exe")
ProgramList.Push("mintty.exe")
ProgramList.Push("NIMax.exe")
ProgramList.Push("Notepad++.exe")
ProgramList.Push("Outlook.exe")
ProgramList.Push("p4v.exe")
ProgramList.Push("QlarityFoundry.exe")
ProgramList.Push("Testify - Scripting.exe")

; IDE_ProjectExplorer := Monitors[0,APP_X_POS] ,Y,W,H
; WIN_Explorers[0] := [Monitors[1,APP_X_POS] ,0, 50%, 33%]
; WIN_Explorers[1] := [Monitors[1,APP_X_POS] , M, 50%, 33%]
; WIN_Explorers[2] := [Monitors[1,APP_X_POS] ,66%, 50%, 33%]

; General sizings and Positions
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := height - bottomPanelHeight
rightPanelWidth := width - leftPanelWidth

; Local DIR {{{2
; These directories are not sync'd with the origin
LocalDIR = %A_ScriptDir%\local
LocalCSVFile = %LocalDIR%\tracker.csv

; Scripting {{{1
; Local DIR {{{2
; Ensure Required directory exists
IfNotExist, LocalDIR
	FileCreateDir, %LocalDIR%
