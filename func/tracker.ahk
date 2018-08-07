; tracker.ahk
; Description: Run and manage all the scripts for labview
; Author: Travis Gall

; Globals {{{1
LocalDIR = %A_WorkingDir%\local
LocalCSVFile = %LocalDIR%\tracker.csv

; Requirements {{{1
IfNotExist, LocalDIR
  FileCreateDir, %LocalDIR%

; Functions {{{1
IsLineInMyFile(TestText, FilePath)
{
  Loop, Read, %FilePath%
  If (A_LoopReadLine = TestText)
    Return 1
  Return 0
}

; Logic {{{1
TrackFile()
{
  #IfWinActive Block Diagram
    ; Lost system values
    OriginalClipboard := clipboard
    MouseGetPos x, y

    ; Open information window and copy full path
    Send, ^i
    Sleep, 200
    MouseMove 350, 150 ; Location relative to the information window for full path
    Click, 3 ; Tripple click to select all text
    Send, ^c

    ; Close information window
    Send, {Enter}
    Sleep, 100

    ; Add file's path to the log
    If Not IsLineInMyFile(clipboard, LocalCSVFile)
      FileAppend, `n%clipboard%, %LocalCSVFile%

    ; Restore original state
    MouseMove %x%, %y%
    clipboard := OriginalClipboard
  #IfWinActive

  Return 1
}
