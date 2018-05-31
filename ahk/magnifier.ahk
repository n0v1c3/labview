; Routine: magnifier.ahk
; Description: On screen magnifier that follows the cursor on the screen
; Author: Travis Gall

; ===
; Initialize
; ===

; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv
#SingleInstance Force ; Replace old script with new script without confirmation

; Set coordinate mode to affect (MouseGetPos, Click, and MouseMove/Click/Drag) all relative to the entire screen
CoordMode Mouse, Screen

OnExit, ExitSub

; ===
; Constants
; ===

; ---
; Antializing
; ---

ANTIALIZE_INIT := 1

; ---
; DLLs
; ---

; SystemParametersInfo
DLL_GDC := "GetDC"

DLL_SSBM := "gdi32.dll\SetStretchBltMode"

DLL_SB := "gdi32.dll\StretchBlt"

DLL_SPI := "SystemParametersInfo"
DLL_SPI_GETMOUSESPEED = 0x70
DLL_SPI_SETMOUSESPEED = 0x71

; ---
; Mouse
; ---

MOUSE_MIN := 3
MOUSE_OVERRIDE_ENABLED_INIT := 0
MOUSE_CURSOR_LENGTH_INIT := 30
MOUSE_CURSOR_WIDTH_INIT := 2

; ---
; Window
; ---

GUI_WIN_BACKGROUND := f3ffff
GUI_WIN_COMP_BACKGROUND := ffffff
GUI_WIN_INIT_OFFSET := 10000
GUI_WIN_WIDTH_INIT := 150
GUI_WIN_HEIGHT_INIT := 150
GUI_WIN_REPAINT_DELAY_INIT := 10
GUI_WIN_MOUSE_OFFSET_INIT := 25
GUI_WIN_MOUSE_OFFSET_ADJUST := 8
GUI_WIN_ENABLED_INIT := 1
GUI_WIN_FROZEN := 0
GUI_WIN_NAME_INIT := "Magnifier"

; ---
; Zoom
; ---

ZOOM_LEVEL_INIT := 2
ZOOM_LEVEL_MAX := 10
ZOOM_LEVEL_MIN := 1

; ===
; Variables
; ===

; ---
; Antializing
; ---

; 1 = On, 0 = Off
antialize := ANTIALIZE_INIT

; ---
; Mouse
; ---

; Retrieve the current speed so that it can be restored later:
DllCall(DLL_SPI, UInt, DLL_SPI_GETMOUSESPEED, UInt, 0, UIntP, mouseSensitivityOriginal, UInt, 0)
mouseOverrideEnabled := MOUSE_OVERRIDE_ENABLED_INIT
mouseCursorVerticalWidth := MOUSE_CURSOR_WIDTH_INIT
mouseCursorVerticalLength := MOUSE_CURSOR_LENGTH_INIT
mouseCursorHorizontalWidth := MOUSE_CURSOR_WIDTH_INIT
mouseCursorHorizontalLength := MOUSE_CURSOR_HEIGHT_INIT

; Range {1..20}
mouseSensitivityMultiplier := mouseSensitivityOriginal / ZOOM_LEVEL_MAX 

; ---
; Windown
; ---

winWidth := GUI_WIN_WIDTH_INIT
winHeight := GUI_WIN_HEIGHT_INIT
winMouseOffsetX := GUI_WIN_MOUSE_OFFSET_INIT
winMouseOffsetY := GUI_WIN_MOUSE_OFFSET_INIT
winName := GUI_WIN_NAME_INIT
winEnabled := GUI_WIN_ENABLED_INIT
winFrozen := GUI_WIN_FROZEN
winRepaintDelay := GUI_WIN_REPAINT_DELAY_INIT

; ---
; Zoom
; ---

zoom :=  ZOOM_LEVEL_INIT

; ===
; GUI
; ===

; Create a window to display magnification
Gui +E0x20 -Caption +AlwaysOnTop -Resize +ToolWindow +Border
Gui Color, %GUI_WIN_BACKGROUND%, %GUI_WIN_COMP_BACKGROUND%

;Gui, Add, Picture, % "x" winWidth/2 " y" winHeight/2 " BackgroundTrans", E:\home\travis\Documents\development\n0v1c3\windows\ahk\testCursor.bmp

; Display window, initialize off screen to prevent "flicker"
Gui Show, % "w" winWidth " h" winHeight " x-"winMouseOffsetX " y-"winMouseOffsetY, %winName%

; Get window ID information for the magnifier and screen
WinGet winID, id,  %winName%
WinGet screenID, id

; Configure window, components, and screen for transparancy
;WinSet Transparent, 0, %winName%;%WindowTrans%, %winID% ; Confirm what this line was doing
;WinSet TransColor, %GUI_WIN_COMP_BACKGROUND%, %winID%
;WinSet TransColor, %GUI_WIN_COMP_BACKGROUND%, %screenID%

; Adjust shape of the window
;WinSet, Region, 10-30 W128 H128 E, %winName%

; Get handles to the device context (DC) for the window and screen
winDC := DllCall(DLL_GDC, UInt, winID)
screenDC := DllCall(DLL_GDC, UInt, screenID)

; ===
; Repaint Loop
; ===

Repaint:
; Get current cursor position
MouseGetPos mouseX, mouseY

if (!winFrozen) {		
    ; Posision window beside the cursor
    WinMove, %winName%, , (mouseX + winMouseOffsetX), (mouseY + winMouseOffsetY)
}

; Window updating enabled
if (winEnabled) {
    ;DllCall(DLL_SSBM, UInt, winDC, Int, 4*antialize)
    DllCall(DLL_SB, UInt, winDC, Int, 0, Int, 0, Int, (winWidth), Int, (winHeight), UInt, screenDC, UInt, (mouseX - ((winWidth / 2) / zoom)), UInt, (mouseY - ((winHeight / 2) / zoom)), Int, ((winWidth) / zoom), Int, (winHeight / zoom), UInt, 0xCC0020)
	gui, add, text, % "x" (winWidth/2 - mouseCursorVerticalWidth) " y" (winHeight/2 - mouseCursorVerticalLength/2) " w" (mouseCursorVerticalWidth) " h" (mouseCursorVerticalLength) " 0x7"  ;Vertical Line > Black
	gui, add, text, % "x" winWidth/2 - mouseCursorVerticalLength/2 " y" winHeight/2 - mouseCursorVerticalWidth " w" mouseCursorVerticalLength " h" mouseCursorVerticalWidth " 0x7"  ;Vertical Line > Black
}

; Adjust the system mouse sensitivity based on the current zoom and override configurations
DllCall(DLL_SPI, UInt, DLL_SPI_SETMOUSESPEED, UInt, 0, UInt, (mouseOverrideEnabled ? mouseOverrideEnabled : (mouseSensitivityOriginal - Ceil(zoom * mouseSensitivityMultiplier) + MOUSE_MIN)), UInt, 0)

; Set delay to repaint the window
SetTimer Repaint, %winRepaintDelay%
Return ; Repaint

; Display tooltip with the current zoom level
ZoomTooltip:
; Display a tool tip with the current zoom level (%) and mouse sensitivity
Tooltip % "Zoom = " (zoom*100) "%"

; Display tool tip for 1 second
SetTimer ToolTipHide, 1000
Return ; ZoomToolTip

; Remove tool tip from the screen
TooltipHide:
Tooltip
Return ; ToolTipHide

ExitSub:
; DC clean upA
; TODO [161218] - These IDs become invalid
;DllCall("gdi32.dll\DeleteDC", UInt, %winDC%)
;DllCall("gdi32.dll\DeleteDC", UInt, %screenDC%)

DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, mouseSensitivityOriginal, UInt, 0)
ExitApp  ; A script with an OnExit subroutine will not terminate unless the subroutine uses ExitApp.
Return ; ExitSub

; ===
; Hotkeys
; ===

; Shift+Win+a
; Toggle window antialize
; TODO [161217] - Ensure that antialiasing can be toggled
#+a::
antialize := !antialize
Return 

; Shift+Win+f
; Toggle window freeze (stop all movement and updates)
#+f::
winFrozen := !winFrozen
Return

; Shift+Win+p
; Toggle window update (play/pause)
#+p::
winEnabled := !winEnabled
Return

; Shift+Win+Up
; Move window offset from cursor up
#+Up::
winMouseOffsetY := winMouseOffsetY - GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Down
; Move window offset from cursor up
#+Down::
winMouseOffsetY := winMouseOffsetY + GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Left
; Move window offset from cursor up
#+Left::
winMouseOffsetX := winMouseOffsetX - GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+Right
; Move window offset from cursor up
#+Right::
winMouseOffsetX := winMouseOffsetX + GUI_WIN_MOUSE_OFFSET_ADJUST
Return

; Shift+Win+WheelUp
; Zoom in
#+WheelUp::
zoom := zoom + (zoom < ZOOM_LEVEL_MAX ? 1 : 0)
Goto ZoomTooltip
Return

; Shift+Win+WheelDown
; Zoom out
#+WheelDown::
zoom := zoom - (zoom > ZOOM_LEVEL_MIN ? 1 : 0)
Goto ZoomTooltip
Return
