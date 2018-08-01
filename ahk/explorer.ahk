; explorer.ahk
; Description: Windows that are not part of LabVIEW require management too
; Author: Travis Gall

; Activate a referenced window
WinActivateMove(WindowReference, X, Y, Width, Height)
{
  WinActivate, % WindowReference
  WinMove, A,, X, Y, Width, Height
}

WinActivateMove2(WindowReference)
{
  Global LAY_EXE
  Global LAY_X
  Global LAY_Y
  Global LAY_WIDTH
  Global LAY_HEIGHT
  WinActivate, % WindowReference[LAY_EXE]
  WinMove, A,, WindowReference[LAY_X], WindowReference[LAY_Y], WindowReference[LAY_WIDTH], WindowReference[LAY_HEIGHT]
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
