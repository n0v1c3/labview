; tracker.ahk
; Description: Run and manage all the scripts for labview
; Author: Travis Gall

; REQUIREMENTS {{{1
; FUNCTIONS {{{1
IsLineInMyFile(TestText, FilePath)
{
    Loop, Read, %FilePath%
        if (A_LoopReadLine = TestText)
            return 1
    return 0
}

; LOGIC {{{1
#IfWinActive Block Diagram
	^s::
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

	; Original save request
	Send, ^s
	Return
#IfWinActive
