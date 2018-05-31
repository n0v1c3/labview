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

; Includes {{{1
; Run all required ahk scripts
#Include ./ahk/ide.ahk
#Include ./ahk/explorer.ahk

; Scripts {{{1
; magnifier.ahk {{{2
Run, %A_AHKPath%, ./ahk/magnifier.ahk

; Shortcuts {{{1
; Reload/Kill {{{2
F12::
Reload
Return

+F12::
ExitApp
Return
