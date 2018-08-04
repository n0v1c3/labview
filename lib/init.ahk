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
MON_X_POS := 1
MON_WIDTH := 2
MON_HEIGHT := 3

MonitorList := {}
MonitorList.Insert("mon-1", {X:0, W:3, H:0})
MonitorList.Insert("mon-2", {X:0, W:0, H:0})
MonitorList.Insert("mon-3", {X:0, W:0, H:0})

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary

IsFirst := True

Loop, %MonitorCount%
{
  SysGet, MonitorName, MonitorName, %A_Index%
  SysGet, Monitor, Monitor, %A_Index%
  SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%

  ; TODO-TJG [180731] - This should be able to handle "X" monitors

  ; Initialize all monitors to the first screen
  If (IsFirst)
  {
    IsFirst := False
    For Key, Value in MonitorList
    {
      Value.X := MonitorWorkAreaLeft ; X-Offset
      Value.W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
      Value.H := MonitorWorkAreaBottom ; Height
    }
  }

  ; Note: this is not "Else'd" to ensure reuse of the "zero"
  ;       workspace for this virtual environment
  If (MonitorWorkAreaLeft <= MonitorList["mon-3"].X)
  {
    MonitorList["mon-2"].X := MonitorList["mon-3"].X
    MonitorList["mon-2"].W := MonitorList["mon-3"].W
    MonitorList["mon-2"].H := MonitorList["mon-3"].H
    MonitorList["mon-3"].X := MonitorWorkAreaLeft ; X-Offset
    MonitorList["mon-3"].W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
    MonitorList["mon-3"].H := MonitorWorkAreaBottom ; Height
  }

  ;if (MonitorWorkAreaLeft == -1920) ; xOffset > MonitorWorkAreaLeft || MonitorWorkAreaLeft == 0)
  ;{
    xOffset := MonitorWorkAreaLeft
    height := MonitorWorkAreaBottom
    width := MonitorWorkAreaRight - MonitorWorkAreaLeft
  ;}
}

; Perforce cannot be 1/3 of the monitor width
PerforceAdjust := 15

DefaultLayout := {}
MonX := MonitorList["mon-2"].X
MonW := MonitorList["mon-2"].W/4
MonH := MonitorList["mon-2"].H/4
DefaultLayout.Insert("2_1", {X:MonX, Y:0, W:MonW, H:MonH*3})
DefaultLayout.Insert("2_2", {X:MonX+MonW, Y:0, W:MonW*3, H:MonH*3})
DefaultLayout.Insert("2_3", {X:MonX, Y:MonH*3, W:MonW, H:MonH})
; Special offsets for YouTube
YTHeight := 200
YTWidth := 10
DefaultLayout.Insert("2_4", {X:MonX+MonW, Y:MonH*3-YTHeight, W:MonW+YTWidth, H:MonH+YTHeight})

DefaultLayout.Insert("2_5", {X:MonX+(2*MonW), Y:MonH*3, W:MonW*2, H:MonH})

DefaultLayout.Insert("3_1", {X:MonitorList["mon-3"].X, Y:0, W:MonitorList["mon-3"].W/3*2-PerforceAdjust, H:((MonitorList["mon-3"].H/3)*2)})
; DefaultLayout.Insert("3_1", {X:0, Y:0, W:1264, H:720})
DefaultLayout.Insert("3_2", {X:MonitorList["mon-3"].X + ((MonitorList["mon-3"].W/3)*2) - PerforceAdjust, Y:0, W:MonitorList["mon-3"].W/3+PerforceAdjust, H:MonitorList["mon-3"].H})
DefaultLayout.Insert("3_3", {X:MonitorList["mon-3"].X, Y:MonitorList["mon-3"].H/3*2, W:(MonitorList["mon-3"].W/3*2)-PerforceAdjust, H:MonitorList["mon-3"].H/3})

LayoutList := {}

; 2_4
LayoutList.Insert("lv_project", {path: "Project Explorer", layout: DefaultLayout["2_1"]})

; 2_4
LayoutList.Insert("youtube", {path: "YouTube", layout: DefaultLayout["2_4"]})

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
