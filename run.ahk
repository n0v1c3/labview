; run.ahk
; Description: Run and manage all the scripts for labview
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

#Include lib\init.ahk
#Include lib\system.ahk
#Include lib\labview.ahk

#Include ahk\ide.ahk
#Include ahk\explorer.ahk
#Include ahk\magnifier.ahk

F12::
  AHKPanic(1, 0, 0, 0)
  Reload
Return

+F12::
  AHKPanic(1, 0, 0, 1)
Return
