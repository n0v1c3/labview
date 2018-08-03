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

; Local working directory
LocalDIR = %A_ScriptDir%\local
LocalCSVFile = %LocalDIR%\tracker.csv

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

DefaultLayout := {}
; DefaultLayout.Insert("3_1", {X:-3849, Y:0, W:1264, H:720})
DefaultLayout.Insert("3_1", {X:0, Y:0, W:1264, H:720})
DefaultLayout.Insert("3_2", {X:-2579, Y:0, W:655, H:1080})

LayoutList := {}

; 3_1
LayoutList.Insert("chrome", {path: "ahk_exe chrome.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("fcs", {path: "ahk_exe FCS.exe", layout: DefaultLayout["3_1"]})
; LayoutList.Insert("labview", {path: "ahk_exe chrome.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("term", {path: "ahk_exe mintty.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("notepad", {path: "ahk_exe notepad++.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("qlarity", {path: "ahk_class Afx:00400000:0", layout: DefaultLayout["3_1"]})
LayoutList.Insert("testify", {path: "ahk_exe Testify - Scripting.exe", layout: DefaultLayout["3_1"]})

; 3_2
LayoutList.Insert("fcslg", {path: "ahk_exe FCSLicenseGenerator.exe", layout: DefaultLayout["3_2"]})
LayoutList.Insert("nimax", {path: "ahk_exe NIMax.EXE", layout: DefaultLayout["3_2"]})
LayoutList.Insert("outlook", {path: "ahk_exe OUTLOOK.exe", layout: DefaultLayout["3_2"]})
LayoutList.Insert("p4v", {path: "ahk_exe p4v.exe", layout: DefaultLayout["3_2"]})

; 3_3
; LayoutList.Insert("explorer", {path: "ahk_exe chrome.exe", layout: DefaultLayout["3_1"]})

; General sizings and Positions
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := height - bottomPanelHeight
rightPanelWidth := width - leftPanelWidth

; Scripting {{{1
; Local DIR {{{2
; Ensure Required directory exists
IfNotExist, LocalDIR
	FileCreateDir, %LocalDIR%
