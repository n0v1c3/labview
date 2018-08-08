; ide.ahk
; Description: Main LabVIEW
; Author: Travis Gall

; Block Diagrams {{{1
; Get list of open Block Diagrams for a drop-down list
CurrentBlockDiagrams()
{
  WindowList := ""
  First := True

  WinGet windows, List
  Loop %windows%
  {
    id := windows%A_Index%
    WinGetTitle wt, ahk_id %id%
    IfInString, wt, Block Diagram
    {
      WindowList .= (First ? wt "|" : "|" wt)
      First := False
    }
  }
  Return WindowList
}

BD_CleanWires()
{
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
}

; Center block diagram
BD_Centre()
{
  MouseGetPos x, y
  ; Positions are relative to the active window
  centerX := (leftPanelWidth / 2) - leftPanelWidth
  centerY := bottomPanelY + (bottomPanelHeight / 2)
  MouseMove %centerX%, %centerY%
  Click
  MouseMove %x%, %y%
}