; init.ahk
; Description: Initialization for shared scripts
; Author: Travis Gall

; Setup {{{1
; Enable warnings to assist with detecting common errors.
; #Warn

; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv
; Replace old script with new script without confirmation
#SingleInstance Force
; Recommended for new scripts due to its superior speed and reliability.
SendMode Input
; Ensures a consistent starting directory.
SetWorkingDir %A_ScriptDir%
; Partial tital match enabled
SetTitleMatchMode, 2

; Layout {{{1

; X, Height, Width
; Monitor[0] will always be the "primary" monitor
Monitors := [[], [], []]

; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
Loop, %MonitorCount%
{
  SysGet, MonitorName, MonitorName, %A_Index%
  SysGet, Monitor, Monitor, %A_Index%
  SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
  
  ; TODO-TJG [180731] - This should be able to handle "X" monitors

  ; Check the "X" offset
  If (MonitorWorkAreaLeft = 0)
  {
    Monitors[0,0] := MonitorWorkAreaLeft
    Monitors[0,1] := MonitorWorkAreaBottom
    Monitors[0,2] := MonitorWorkAreaRight - MonitorWorkAreaLeft
  }

  ; Monitors[2] will always trail Monitors[1]
  Monitors[2] := Monitors[1]

  ; Note: this is not "Else'd" to ensure reuse of the "zero"
  ;       workspace for this virtual environment
  If (MonitorWorkAreaLeft <= 0)
  {
    Monitors[1,0] := MonitorWorkAreaLeft
    Monitors[1,1] := MonitorWorkAreaBottom
    Monitors[1,2] := MonitorWorkAreaRight - MonitorWorkAreaLeft
  }
  
  ;if (MonitorWorkAreaLeft == -1920) ; xOffset > MonitorWorkAreaLeft || MonitorWorkAreaLeft == 0)
  ;{
    xOffset := MonitorWorkAreaLeft
    height := MonitorWorkAreaBottom
    width := MonitorWorkAreaRight - MonitorWorkAreaLeft
  ;}
}

APP_X_POS := 0
;APP_Y_POS := 1
APP_WIDTH := 2
APP_HEIGHT := 3

; IDE_ProjectExplorer := Monitors[0,APP_X_POS] ,Y,W,H
; WIN_Explorers[0] := [Monitors[1,APP_X_POS] ,0, 50%, 33%]
; WIN_Explorers[1] := [Monitors[1,APP_X_POS] , M, 50%, 33%]
; WIN_Explorers[2] := [Monitors[1,APP_X_POS] ,66%, 50%, 33%]

; General sizings and Positions
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := height - bottomPanelHeight
rightPanelWidth := width - leftPanelWidth
