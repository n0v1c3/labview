; init.ahk
; Description: Initialization for shared scripts
; Author: Travis Gall

; Setup {{{1
; Debug {{{2
; Enable warnings to assist with detecting common errors.
Debug := False
; #Warn

; Environment {{{2
; Settings {{{3
; Recommended environment settings
#NoEnv
#SingleInstance Force
#Warn All, Off
SendMode Input
SetWorkingDir %A_ScriptDir%

; Partial tital match enabled
SetTitleMatchMode, 2

; Better mouse tracking
CoordMode Pixel, Screen
CoordMode Mouse, Screen
	
; Explorer {{{3
ExplorerIDs := ["",""]
SavedIDs := []

; Directories {{{3
; Local working directory
LocalDIR = %A_ScriptDir%\local
LocalCSVFile = %LocalDIR%\tracker.csv

IfNotExist, LocalDIR
  FileCreateDir, %LocalDIR%
