; layout.ahk
; Description: Objects containing application positions
; Author: Travis Gall

; Monitors {{{1
; Virtual Monitors {{{2
; List of "virtual" monitors
MonitorList := {}
MonitorList.Insert("mon-1", {X:0, W:0, H:0})
MonitorList.Insert("mon-2", {X:0, W:0, H:0})
MonitorList.Insert("mon-3", {X:0, W:0, H:0})

; Physical Monitors {{{2
; Initialize flag
FirstMonitor := True

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary

Loop, %MonitorCount%
{
  SysGet, MonitorName, MonitorName, %A_Index%
  SysGet, Monitor, Monitor, %A_Index%
  SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%

  ; TODO-TJG [180731] - This should be able to handle "X" monitors

  ; Initialize all monitors to the first screen
  If (FirstMonitor)
  {
    FirstMonitor := False
    For Key, Value in MonitorList
    {
      Value.X := MonitorWorkAreaLeft ; X-Offset
      Value.W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
      Value.H := MonitorWorkAreaBottom ; Height
    }
  }

  ; Move monitor 3 down the list
  If (MonitorWorkAreaLeft <= MonitorList["mon-3"].X)
  {
    MonitorList["mon-2"].X := MonitorList["mon-3"].X
    MonitorList["mon-2"].W := MonitorList["mon-3"].W
    MonitorList["mon-2"].H := MonitorList["mon-3"].H
    MonitorList["mon-3"].X := MonitorWorkAreaLeft ; X-Offset
    MonitorList["mon-3"].W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
    MonitorList["mon-3"].H := MonitorWorkAreaBottom ; Height
  }

  ; TODO-TJG [180803] - This will be replaced with the object layout
  if (MonitorWorkAreaLeft == -1920) ; xOffset > MonitorWorkAreaLeft || MonitorWorkAreaLeft == 0)
  {
    xOffset := MonitorWorkAreaLeft
    height := MonitorWorkAreaBottom
    width := MonitorWorkAreaRight - MonitorWorkAreaLeft
  }
}

; Layouts {{{1
; Offsets {{{2
; Perforce cannot be 1/3 of the monitor width
PerforceAdjust := 15
; Special offsets for YouTube
YTHeight := 200
YTWidth := 10

; Defaults {{{2
DefaultLayout := {}

; Monitor 2 {{{3
MonX := MonitorList["mon-2"].X
MonW := MonitorList["mon-2"].W/4
MonH := MonitorList["mon-2"].H/4
DefaultLayout.Insert("2_1", {X:MonX, Y:0, W:MonW, H:MonH*3})
DefaultLayout.Insert("2_2", {X:MonX+MonW, Y:0, W:MonW*3, H:MonH*3})
DefaultLayout.Insert("2_3", {X:MonX, Y:MonH*3, W:MonW, H:MonH})
DefaultLayout.Insert("2_4", {X:MonX+MonW, Y:MonH*3-YTHeight, W:MonW+YTWidth, H:MonH+YTHeight})
DefaultLayout.Insert("2_5", {X:MonX+(2*MonW), Y:MonH*3, W:MonW*2, H:MonH})

; Monitor 3 {{{3
DefaultLayout.Insert("3_1", {X:MonitorList["mon-3"].X, Y:0, W:MonitorList["mon-3"].W/3*2-PerforceAdjust, H:((MonitorList["mon-3"].H/3)*2)})
DefaultLayout.Insert("3_2", {X:MonitorList["mon-3"].X + ((MonitorList["mon-3"].W/3)*2) - PerforceAdjust, Y:0, W:MonitorList["mon-3"].W/3+PerforceAdjust, H:MonitorList["mon-3"].H})
DefaultLayout.Insert("3_3", {X:MonitorList["mon-3"].X, Y:MonitorList["mon-3"].H/3*2, W:(MonitorList["mon-3"].W/3*2)-PerforceAdjust, H:MonitorList["mon-3"].H/3})

; Applications {{{2
LayoutList := {}

; 2_1 {{{3
LayoutList.Insert("lv_project", {path: "Project Explorer", layout: DefaultLayout["2_1"]})

; 2_2 {{{3
LayoutList.Insert("lv_block", {path: "Block Diagram", layout: DefaultLayout["2_2"]})

; 2_3 {{{3
LayoutList.Insert("lv_navigation", {path: "Navigation", layout: DefaultLayout["2_3"]})

; 2_4 {{{3
LayoutList.Insert("youtube", {path: "YouTube", layout: DefaultLayout["2_4"]})

; 2_5 {{{3
LayoutList.Insert("lv_probe", {path: "Probe Watch Window", layout: DefaultLayout["2_5"]})
LayoutList.Insert("lv_bookmark", {path: "Bookmark Manager", layout: DefaultLayout["2_5"]})
LayoutList.Insert("lv_error", {path: "Error list", layout: DefaultLayout["2_5"]})

; 3_1 {{{3
LayoutList.Insert("chrome", {path: "ahk_exe chrome.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("fcs", {path: "ahk_exe FCS.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("term", {path: "ahk_exe mintty.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("notepad", {path: "ahk_exe notepad++.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("qlarity", {path: "ahk_class Afx:00400000:0", layout: DefaultLayout["3_1"]})
LayoutList.Insert("testify", {path: "ahk_exe Testify - Scripting.exe", layout: DefaultLayout["3_1"]})
LayoutList.Insert("lv_hierarchy", {path: "VI Hierarchy", layout: DefaultLayout["3_1"]})

; 3_2 {{{3
LayoutList.Insert("fcslg", {path: "ahk_exe FCSLicenseGenerator.exe", layout: DefaultLayout["3_2"]})
LayoutList.Insert("nimax", {path: "ahk_exe NIMax.EXE", layout: DefaultLayout["3_2"]})
LayoutList.Insert("outlook", {path: "ahk_exe OUTLOOK.exe", layout: DefaultLayout["3_2"]})
LayoutList.Insert("p4v", {path: "ahk_exe p4v.exe", layout: DefaultLayout["3_2"]})

; 3_3 {{{3
; LayoutList.Insert("explorer", {path: "ahk_exe chrome.exe", layout: DefaultLayout["3_1"]})

; Clean-Up {{{1
; General sizings and Positions
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := height - bottomPanelHeight
rightPanelWidth := width - leftPanelWidth

