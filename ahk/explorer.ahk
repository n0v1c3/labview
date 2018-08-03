; explorer.ahk
; Description: Windows that are not part of LabVIEW require management too
; Author: Travis Gall

WinActivateMove(Application)
{
  WinActivate, % Application.path
  WinMove, A,, Application.layout.X, Application.layout.Y, Application.layout.W, Application.layout.H
}

; Activate all referenced windows
WinActivateMoveAll(WindowReference, X, Y, Width, Height)
{
  WinGet, WindowList, List, % WindowReference
  Loop %WindowList%
  {
    ; WinActivateMove("ahk_id " . WindowList%A_Index%, X, Y, Width, Height)
  }
}
