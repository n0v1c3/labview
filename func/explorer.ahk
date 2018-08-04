; explorer.ahk
; Description: Windows that are not part of LabVIEW require management too
; Author: Travis Gall

WinActivateMove(Application)
{
  WinGet, Windows, List, % Application.path
  Loop %Windows%
  {
    WinActivate, % "ahk_id " . Windows%A_Index%
    WinMove, A,, Application.layout.X, Application.layout.Y, Application.layout.W, Application.layout.H
  }
}
