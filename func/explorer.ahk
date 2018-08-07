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
  MsgBox, % A.id
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

  If (Application.path <> "")
  {
    WinActivate, % Application.id
    WinGet, WinList, List, % Application.path
    If (Application.id == "ahk_id " . WinExist("A"))
    {
	  Running := True
      WinMove, A,, Application.layout.X, Application.layout.Y, Application.layout.W, Application.layout.H
    }
    Else If (WinList)
    {
	  Running := True
	  Loop %WinList%
	  {
	    WinActivate, % "ahk_id " . WinList%A_Index%
		WinMove, A,, Application.layout.X, Application.layout.Y, Application.layout.W, Application.layout.H
	  }
	}
  }
  
  
  If (!Running && Application.run != "") 
  {
    Run, % Application.run
    Sleep, 1000
	; TODO - Only insert ID if needed (ie. Explorer)
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
