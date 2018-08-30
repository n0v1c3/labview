; explorer.ahk
; Description: Windows that are not part of LabVIEW require management too
; Author: Travis Gall

; ID of window under the cursor
CursorID()
{
  MouseGetPos,,, WinID
  WinActivate, ahk_id %WinID%
  Return WinID
}

ExplorerSwap(A, B)
{
  CurID := "ahk_id " . CursorID()

  If (B.id == CurID)
    B.id := A.id
  Else If (A.id != CurID)
    WinClose, % A.id
  A.id := CurID

  WinActivateMove(A)
  WinActivateMove(B)
}

WinActivateMove(Application)
{
  Running := False

  ; Only target the id when present
  If (Application.id <> "")
  {
    WinActivate, % Application.id
    If (Application.id == "ahk_id " . WinExist("A"))
    {
      Running := True
      WinMove, A,, Application.layout.X, Application.layout.Y, Application.layout.W, Application.layout.H
    }
  }

  ; Loop through all mathches to the path
  Else If (Application.path <> "")
  {
    WinGet, WinList, List, % Application.path
    If (WinList)
    {
      Running := True
      Loop %WinList%
      {
        WinActivate, % "ahk_id " . WinList%A_Index%
        WinMove, % "ahk_id " . WinList%A_Index%,, Application.layout.X, Application.layout.Y, Application.layout.W, Application.layout.H
      }
    }
  }

  ; Run application if not running
  If (!Running && Application.run != "")
  {
    Run, % Application.run

    ; Wait for the application to start
    While (!WinExist(Application.path))
      Sleep, 1

    ; Padding for explorer load
    Sleep, 750

    WinMove, A,, Application.layout.X, Application.layout.Y, Application.layout.W, Application.layout.H

    ; Save ID of certain programs
    If (Application.id)
      Application.id := "ahk_id " . WinExist("A")
  }
}

WinBackground()
{
  ; Used to select window under the cursor
  CursorID()

  ; Send window to the background
  Send, !{Esc}
  Sleep, 10

  ; Select new window under cursor and return PID
  Return CursorID()
}

WinForeground()
{
  CurWin := CursorID()
  PrevWin := CurWin

  Send, !{Esc}
  Sleep, 10

  While (CurWin <> CursorID())
  {
    PrevWin := CursorID()
    Send, !{Esc}
    Sleep, 10
  }
  WinActivate, ahk_id %PrevWin%
  Return PrevWin
}

P4V_HideHistory()
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
	Send, e
}