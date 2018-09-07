; workspaces.ahk
; Description: Objects containing application positions
; Author: Travis Gall

; GAPS between windows
GAPS := 5

; Patch for window with a minimum width
P4V_ADJUST := 15

; Floating window sizes
F_1 := {X:0, Y:0, Width:1300, Height:850}
F_2 := {X:0, Y:0, Width:1300, Height:850}
F_3 := {X:0, Y:0, Width:1300, Height:850}

; Initialize monitors
Monitors := []
Monitors.Push({X:0, Y:0, W:0, H:0})
Monitors.Push({X:0, Y:0, W:0, H:0})
Monitors.Push({X:0, Y:0, W:0, H:0})

; Flag to indicat it is the first monitor tested
Counter := 1

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary

; Loop through each monitor
Loop, %MonitorCount%
{   
  SysGet, MonitorName, MonitorName, %A_Index%
  SysGet, Monitor, Monitor, %A_Index%
  SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index% 

  Monitors[Counter].X := MonitorWorkAreaLeft ; X-Offset
  Monitors[Counter].W := MonitorWorkAreaRight - MonitorWorkAreaLeft ; Width
  Monitors[Counter].H := MonitorWorkAreaBottom ; Height
  
  Counter++
}

; Initialize workspaces
Workspaces := {}

; Workspace 1 (Full screen workspace)
;  ______
; |1     |
; |      |
; |______|

X = Monitors[1].X
Y = Monitors[1].Y
Width := Monitors[1].Width
Height := Monitors[1].Height
F_1.X := 0
F_1.Y := 0
F_2.X := 0
F_2.Y := 0
F_3.X := 0
F_3.Y := 0

Workspaces.Insert("1_1", {X:X+GAPS, Y:Y+GAPS, Width:Width-(2*GAPS), Height:Height-(2*GAPS)})
Workspaces.Insert("1_F1", {X:F_1.X, Y:F_1.Y, Width:F_1.Width, Height:F_1.Height})
Workspaces.Insert("1_F2", {X:F_2.X, Y:F_2.Y, Width:F_2.Width, Height:F_2.Height})
Workspaces.Insert("1_F3", {X:F_3.X, Y:F_3.Y, Width:F_3.Width, Height:F_3.Height})

; Workspace 2 (Quarters)
;  __5_6__
; |2|1    |
; | |_____|
; |_|3|4__|

X = Monitors[2].X
Y = Monitors[2].Y
Width := Monitors[2].Width/4
Height := Monitors[2].Height/4
F_1.X := 0
F_1.Y := 0
F_2.X := 0
F_2.Y := 0
F_3.X := 0
F_3.Y := 0

Workspaces.Insert("2_1", {X:X+Width+GAPS, Y:Y+GAPS, Width:Width*3-(2*GAPS), Height:Height*3-(2*GAPS)})
Workspaces.Insert("2_2", {X:X+GAPS, Y:Y+GAPS, Width:Width-(2*GAPS), Height:Height*4-(2*GAPS)})
Workspaces.Insert("2_3", {X:X+Width+GAPS, Y:Y+Height*3+GAPS, Width:Width-(2*GAPS), Height:Height-(2*GAPS)})
Workspaces.Insert("2_4", {X:X+Width*2+GAPS, Y:Y+Height*3+GAPS, Width:Width*2-(2*GAPS), Height:Height-(2*GAPS)})
Workspaces.Insert("2_5", {X:X+Width+GAPS, Y:Y+GAPS, Width:Width-(2*GAPS), Height:Height*4-(2*GAPS)})
Workspaces.Insert("2_6", {X:X+Width*2+GAPS, Y:Y+GAPS, Width:Width*2-(2*GAPS), Height:Height*4-(2*GAPS)})
Workspaces.Insert("2_F1", {X:F_1.X, Y:F_1.Y, Width:F_1.Width, Height:F_1.Height})
Workspaces.Insert("2_F2", {X:F_2.X, Y:F_2.Y, Width:F_2.Width, Height:F_2.Height})
Workspaces.Insert("2_F3", {X:F_3.X, Y:F_3.Y, Width:F_3.Width, Height:F_3.Height})

; Workspace 3 (Thirds)
;  ___5__6_
; |2 |1    |
; |  |_____|
; |__|3_|4_|

X = Monitors[3].X
Y = Monitors[3].Y
Width := Monitors[3].Width/3
Height := Monitors[3].Height/3
F_1.X := 0
F_1.Y := 0
F_2.X := 0
F_2.Y := 0
F_3.X := 0
F_3.Y := 0

Workspaces.Insert("3_1", {X:X+Width+GAPS, Y:Y+GAPS, Width:Width*2-(2*GAPS), Height:Height*2-(2*GAPS)})
Workspaces.Insert("3_2", {X:X+GAPS, Y:Y+GAPS, Width:Width-(2*GAPS), Height:Height*3-(2*GAPS)})
Workspaces.Insert("3_3", {X:X+Width+GAPS, Y:Y+Height*2+GAPS, Width:Width-(2*GAPS), Height:Height-(2*GAPS)})
Workspaces.Insert("3_4", {X:X+Width*2+GAPS, Y:Y+Height*2GAPS, Width:Width-(2*GAPS), Height:Height-(2*GAPS)})
Workspaces.Insert("3_5", {X:X+Width+GAPS, Y:Y+GAPS, Width:Width-(2*GAPS), Height:Height*3-(2*GAPS)})
Workspaces.Insert("3_6", {X:X+Width*2+GAPS, Y:Y+GAPS, Width:Width-(2*GAPS), Height:Height*3-(2*GAPS)})
Workspaces.Insert("3_F1", {X:F_1.X, Y:F_1.Y, Width:F_1.Width, Height:F_1.Height})
Workspaces.Insert("3_F2", {X:F_2.X, Y:F_2.Y, Width:F_2.Width, Height:F_2.Height})
Workspaces.Insert("3_F3", {X:F_3.X, Y:F_3.Y, Width:F_3.Width, Height:F_3.Height})

; Default application layout
Applications := {}


Workspace := "1_1"
Applications["virtualbox"] := {Ref:"Virtual Box", Run:"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe startvm ArchBase", Workspace:Workspace}
Applications["p4v-hist"] := {Ref:"Revision Graph", Run:"", Workspace:Workspace}

Workspace := "2_1"
Applications["lv-blocks"] := {Ref:"Block Diagram", Run:"", Workspace:Workspace}

Workspace := "3_1"
Applications["chrome"] := {Ref:"ahk_exe chrome.exe", Run:"chrome.exe", Workspace:Workspace}