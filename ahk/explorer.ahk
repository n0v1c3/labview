; explorer.ahk
; Description: Windows that are not part of LabVIEW require management too
; Author: Travis Gall

; Activate a referenced window
WinActivateMove(WindowReference, X, Y, Width, Height)
{
  WinActivate, % WindowReference
  WinMove, A,, X, Y, Width, Height
}

; Activate all referenced windows
WinActivateMoveAll(WindowReference, X, Y, Width, Height)
{
  WinGet, WindowList, List, % WindowReference
  Loop %WindowList%
  {
    WinActivateMove("ahk_id " . WindowList%A_Index%, X, Y, Width, Height)
  }
}
