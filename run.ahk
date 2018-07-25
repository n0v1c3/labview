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

; Scripts {{{1
Run, ahk\explorer.ahk
Run, ahk\ide.ahk
;Run, ahk\magnifier.ahk
Run, ahk\rocker.ahk

; Programs {{{1
ProgramList := []
ProgramList.Push("chrome.exe")
ProgramList.Push("Explorer.exe")
ProgramList.Push("FCS.exe")
ProgramList.Push("FCSLicenseGenerator.exe")
ProgramList.Push("LabVIEW.exe")
ProgramList.Push("mintty.exe")
ProgramList.Push("NIMax.exe")
ProgramList.Push("Notepad++.exe")
ProgramList.Push("Outlook.exe")
ProgramList.Push("p4v.exe")
ProgramList.Push("QlarityFoundry.exe")
ProgramList.Push("Testify - Scripting.exe")

For index, element in ProgramList
{
	If WinExist("ahk_exe" . element)
	{
		WinActivate
	}
	Else
	{
		;Run, %element%
	}
}


; Shortcuts {{{1
; Reload/Kill {{{2
F12::
  AHKPanic(1, 0, 0, 0)
  Reload
Return

+F12::
  AHKPanic(1, 0, 0, 1)
Return

; Functions {{{1
; AHK Panic {{{2
AHKPanic(Kill=0, Pause=0, Suspend=0, SelfToo=0) {
  DetectHiddenWindows, On
  WinGet, IDList ,List, ahk_class AutoHotkey
  Loop %IDList%
  {
    ID:=IDList%A_Index%
    WinGetTitle, ATitle, ahk_id %ID%
    IfNotInString, ATitle, %A_ScriptFullPath%
    {
      If Suspend
        PostMessage, 0x111, 65305,,, ahk_id %ID%  ; Suspend.
      If Pause
        PostMessage, 0x111, 65306,,, ahk_id %ID%  ; Pause.
      If Kill
        WinClose, ahk_id %ID% ;kill
    }
  }
  If SelfToo
  {
    If Suspend
      Suspend, Toggle  ; Suspend.
    If Pause
      Pause, Toggle, 1  ; Pause.
    If Kill
      ExitApp
  }
}
