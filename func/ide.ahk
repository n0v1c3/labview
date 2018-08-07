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
 /*
; Setup {{{1
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
*/

; TODO-TJG [180804] - Remove this
/*
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
*/

/*
; TODO-TJG [180804] - WTF is this for?
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

*/
/*
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
*/
