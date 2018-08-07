; rocker.ahk
; Description: Mouse function calls
; Requires: ide.ahk
; Author: Travis Gall

; Setup {{{1
Counter = 1
RButtonFirst := True
LButtonFirst := True

; Functions {{{1
RRocker()
{
  If RButtonFirst
  {
    LButtonFirst := False

    CtrlLock := False
    LButtonLock := False

    CtrlCounts := 0
    LButtonCounts := 0

    if GetKeyState("RButton")
    {
      Loop
      {
        If !GetKeyState("RButton")
          Break

        If GetKeyState("Ctrl") And !CtrlLock
        {
          CtrlCounts := CtrlCounts + 1
          CtrlLock := True
        }
        If !GetKeyState("Ctrl")
          CtrlLock := False

        If GetKeyState("LButton") And !LButtonLock
        {
          LButtonCounts := LButtonCounts + 1
          LButtonLock := True

          KeyWait, LButton
        }
        If !GetKeyState("LButton")
          LButtonLock := False
      }
    }

    ; Normal LButton operation
    If (CtrlCounts != 0 Or LButtonCounts != 0)
    {
      Sleep, 25
      IfWinExist, ahk_class #32768 ; Close context menu if open
        Send, {Escape}
    }

    ; Navigate backwards
    IfEqual LButtonCounts, 1
    {

      ; Chrome
      IfWinActive, % "ahk_exe" . "chrome.exe"
        Send, !{Left}

      ; Notepad++
      IfWinActive, % "ahk_exe" . "Notepad++.exe"
        Send, ^{PgUp}

      IfWinActive, % "ahk_exe" . "LabVIEW.exe"
      {
        BlockDiagramList := CurrentBlockDiagrams()
        Gui, LVBD: New, , LV - Blocks
        Gui, Add, DropDownList, w600 vBlockDiagram, %BlockDiagramList%
        Gui, Show, , LV - Blocks
        Loop, %Counter%
        {
          Send, {Down}
          Counter := Counter + 1
        }
        ; GoSub, SelectBlockDiagram
      }
    }

    IfEqual, LButtonCounts, 2
      MsgBox, "Test2"

    LButtonFirst := True
  }
}

LRocker()
{
  If LButtonFirst
  {
    RButtonFirst := False

    CtrlLock := False
    RButtonLock := False

    CtrlCounts := 0
    RButtonCounts := 0
    if GetKeyState("LButton")
    {
      Loop
      {
        If !GetKeyState("LButton")
          Break

        If GetKeyState("Ctrl") And !CtrlLock
        {
          CtrlCounts := CtrlCounts + 1
          CtrlLock := True
        }
        If !GetKeyState("Ctrl")
          CtrlLock := False

        If GetKeyState("RButton") And !RButtonLock
        {
          RButtonCounts := RButtonCounts + 1
          RButtonLock := True

          KeyWait, RButton
        }
        If !GetKeyState("RButton")
          RButtonLock := False
      }
    }

    ; Normal LButton operation
    If (CtrlCounts != 0 Or RButtonCounts != 0)
    {
      Sleep, 25
      IfWinExist, ahk_class #32768 ; Close context menu if open
        Send, {Escape}
    }
    ; Navigate backwards
    IfEqual RButtonCounts, 1
    {

      ; Chrome
      IfWinActive, % "ahk_exe" . "chrome.exe"
      {
        ; Navigate "Tabs"
        IfEqual CtrlCounts, 1
          Send, {Ctrl}{Tab}
        ; Navigate "Forward"
        Else
          Send, !{Right}
      }

      ; Notepad++
      IfWinActive, % "ahk_exe" . "Notepad++.exe"
        Send, ^{PgDn}

      ; LabVIEW found in ide.ahkButton Up}{Escape}{LButton}
      IfWinActive, % "ahk_exe" . "LabVIEW.exe"
      {
        BlockDiagramList := CurrentBlockDiagrams()
        Gui, LVBD: New, , LV - Blocks
        Gui, Add, DropDownList, w600 vBlockDiagram, %BlockDiagramList%
        Gui, Show, , LV - Blocks
        Send, {End}
        Counter := 1
        ; GoSub, SelectBlockDiagram
      }
    }


    IfEqual, RButtonCounts, 2
      MsgBox, "Test"

    RButtonFirst := True
  }	
}
