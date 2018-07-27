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
; Get current monitor and workspace information
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
Loop, %MonitorCount%
{
  SysGet, MonitorName, MonitorName, %A_Index%
  SysGet, Monitor, Monitor, %A_Index%
  SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
  ;if (MonitorWorkAreaLeft == -1920) ; xOffset > MonitorWorkAreaLeft || MonitorWorkAreaLeft == 0)
  ;{
    xOffset := MonitorWorkAreaLeft
    height := MonitorWorkAreaBottom
    width := MonitorWorkAreaRight - MonitorWorkAreaLeft
  ;}
}

; General sizings and Positions
leftPanelWidth := 400
bottomPanelHeight := 250
bottomPanelY := height - bottomPanelHeight
rightPanelWidth := width - leftPanelWidth
