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
	  
	  MonitorList["mon-1"].X := MonitorWorkAreaLeft ; X-Offset
      MonitorList["mon-1"].W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
	  MonitorList["mon-1"].H := MonitorWorkAreaBottom ; Height
    }
  }

  ; Move monitor 3 down the list
  If (MonitorWorkAreaLeft < 0) ; <= MonitorList["mon-3"].X)
  {
    MonitorList["mon-3"].X := MonitorWorkAreaLeft ; X-Offset
    MonitorList["mon-3"].W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
    MonitorList["mon-3"].H := MonitorWorkAreaBottom ; Height
  }
  Else If (MonitorWorkAreaLeft > 0) ; <= MonitorList["mon-3"].X)
  {
    MonitorList["mon-2"].X := MonitorWorkAreaLeft ; X-Offset
    MonitorList["mon-2"].W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
    MonitorList["mon-2"].H := MonitorWorkAreaBottom ; Height
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
; Gaps at the edge of windows in pixels
Gaps := 5
; Perforce cannot be 1/3 of the monitor width
PerforceAdjust := 15
; Special offsets for YouTube
YTXOff := 10
YTYOff := 25
YTWOff := 20
YTHOff := 200
YTHeight := 200
YTWidth := 20

; Defaults {{{2
DefaultLayout := {}

; Monitor 1 {{{3
MonX := MonitorList["mon-1"].X
MonW := MonitorList["mon-1"].W/3
MonH := MonitorList["mon-1"].H/3
DefaultLayout.Insert("1_1", {X:MonX+Gaps, Y:0+Gaps, W:MonW*3-(2*Gaps), H:MonH*3-(2*Gaps)})

; Monitor 2 {{{3
MonX := MonitorList["mon-2"].X
MonW := MonitorList["mon-2"].W/4
MonH := MonitorList["mon-2"].H/4
DefaultLayout.Insert("2_1", {X:MonX+Gaps, Y:0+Gaps, W:MonW-(2*Gaps), H:MonH*3-(2*Gaps)})
DefaultLayout.Insert("2_2", {X:MonX+MonW+Gaps, Y:0+Gaps, W:MonW*3-(2*Gaps), H:MonH*3-(2*Gaps)})
DefaultLayout.Insert("2_3", {X:MonX+Gaps, Y:MonH*3+Gaps, W:MonW-(2*Gaps), H:MonH-(2*Gaps)})
DefaultLayout.Insert("2_4", {X:MonX+MonW-YTWidth+Gaps, Y:MonH*3-YTHeight+YTYOff+Gaps, W:MonW+YTWidth-(2*Gaps), H:MonH+YTHeight-(2*Gaps)})
DefaultLayout.Insert("2_5", {X:MonX+(2*MonW)-YTWOff-YTXOff+Gaps, Y:MonH*3+Gaps, W:MonW*2+YTWOff+YTXOff-(2*Gaps), H:MonH-(2*Gaps)})

; Monitor 3 {{{3
MonX := MonitorList["mon-3"].X
MonW := MonitorList["mon-3"].W/3
MonH := MonitorList["mon-3"].H/3
DefaultLayout.Insert("3_1", {X:MonitorList["mon-3"].X+Gaps, Y:0+Gaps, W:MonitorList["mon-3"].W/3*2-PerforceAdjust-(2*Gaps), H:((MonitorList["mon-3"].H/3)*2)-(2*Gaps)})
DefaultLayout.Insert("3_2", {X:MonitorList["mon-3"].X + ((MonitorList["mon-3"].W/3)*2) - PerforceAdjust, Y:0+Gaps, W:MonitorList["mon-3"].W/3+PerforceAdjust, H:MonitorList["mon-3"].H-(2*Gaps)})
DefaultLayout.Insert("3_3", {X:MonitorList["mon-3"].X, Y:MonitorList["mon-3"].H/3*2, W:(MonitorList["mon-3"].W/3*2)-PerforceAdjust, H:MonitorList["mon-3"].H/3})
DefaultLayout.Insert("3_3_1", {X:DefaultLayout["3_3"].X+Gaps, Y:DefaultLayout["3_3"].Y+Gaps, W:DefaultLayout["3_3"].W/2-(2*Gaps), H:DefaultLayout["3_3"].H-(2*Gaps)})
DefaultLayout.Insert("3_3_2", {X:DefaultLayout["3_3"].X + DefaultLayout["3_3"].W/2+Gaps, Y:DefaultLayout["3_3"].Y+Gaps, W:DefaultLayout["3_3"].W/2-(2*Gaps), H:DefaultLayout["3_3"].H-(2*Gaps)})

; Applications {{{2
LayoutList := {}

; 1_1 {{{3
Layout := DefaultLayout["1_1"]
LayoutList.Insert("virtualbox", {path: "ahk_exe VirtualBox.exe", run: "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe startvm ArchBase", layout: Layout})

; 2_1 {{{3
Layout := DefaultLayout["2_1"]
LayoutList.Insert("lv_project", {path: "Project Explorer", layout: Layout})

; 2_2 {{{3
Layout := DefaultLayout["2_2"]
LayoutList.Insert("lv_block", {path: "Block Diagram", layout: Layout})

; 2_3 {{{3
Layout := DefaultLayout["2_3"]
LayoutList.Insert("lv_navigation", {path: "Navigation", layout: Layout})
LayoutList.Insert("sticky", {path: "ahk_exe StikyNot.exe", run: "C:\Windows\system32\StikyNot.exe", layout: Layout})

; 2_4 {{{3
Layout := DefaultLayout["2_4"]
LayoutList.Insert("youtube", {path: "YouTube", run: "chrome.exe --new-window youtube.com", layout: Layout, id: "y1"})

; 2_5 {{{3
Layout := DefaultLayout["2_5"]
LayoutList.Insert("lv_probe", {path: "Probe Watch Window", layout: Layout})
LayoutList.Insert("lv_bookmark", {path: "Bookmark Manager", layout: Layout})
LayoutList.Insert("lv_error", {path: "Error list", layout: Layout})

; 3_1 {{{3
Layout := DefaultLayout["3_1"]
LayoutList.Insert("slack", {path: "ahk_exe slack.exe", run: "C:\Users\travis.gall\AppData\Local\slack\slack.exe", layout: Layout})
LayoutList.Insert("chrome", {path: "ahk_exe chrome.exe", run: "chrome.exe", layout: Layout})
LayoutList.Insert("paint", {path: "ahk_exe mspaint.exe", run: "mspaint.exe", layout: Layout})
LayoutList.Insert("putty", {path: "ahk_class PuTTY", run: "C:\Program Files (x86)\PuTTY\putty.exe", layout: Layout})
LayoutList.Insert("excel", {path: "ahk_exe excel.exe", run: "excel.exe", layout: Layout})
LayoutList.Insert("fcs", {path: "ahk_exe FCS.exe", run: "C:\Program Files (x86)\Advanced Measurements\FCS\FCS.exe", layout: Layout})
LayoutList.Insert("term", {path: "ahk_exe mintty.exe", run: "C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -", layout: Layout})
LayoutList.Insert("notepad", {path: "ahk_exe notepad++.exe", run: "notepad++.exe", layout: Layout})
LayoutList.Insert("qlarity", {path: "ahk_class Afx:00400000:0", run: "C:\Program Files (x86)\QSI Corporation\Qlarity Foundry 2.63\QlarityFoundry.exe", layout: Layout})
LayoutList.Insert("testify", {path: "ahk_exe Testify - Scripting.exe", run: "C:\LabVIEW\Testify\Scripting\Testify - Scripting.exe", layout: Layout})
LayoutList.Insert("lv_hierarchy", {path: "VI Hierarchy", layout: Layout})

; 3_2 {{{3
Layout := DefaultLayout["3_2"]
LayoutList.Insert("fcslg", {path: "ahk_exe FCSLicenseGenerator.exe", run: "C:\Program Files (x86)\Advanced Measurements\FCSLicenseGenerator\FCSLicenseGenerator.exe", layout: Layout})
LayoutList.Insert("nimax", {path: "ahk_exe NIMax.EXE", run: "C:\Program Files (x86)\National Instruments\MAX\NIMax.exe", layout: Layout})
LayoutList.Insert("outlook", {path: "ahk_exe OUTLOOK.exe", run: "outlook.exe", layout: Layout})
LayoutList.Insert("p4v", {path: "ahk_exe p4v.exe", run: "C:\Program Files\Perforce\p4v.exe", layout: Layout})

; 3_3 {{{3
Layout := DefaultLayout["3_3_1"]
LayoutList.Insert("explorer_1", {path: "ahk_class CabinetWClass", run: "explorer.exe", layout: Layout, id: "e1"})
Layout := DefaultLayout["3_3_2"]
LayoutList.Insert("explorer_2", {path: "ahk_class CabinetWClass", run: "explorer.exe", layout: Layout, id: "e2"})

; Clean-Up {{{1
; General sizings and Positions
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := height - bottomPanelHeight
rightPanelWidth := width - leftPanelWidth
