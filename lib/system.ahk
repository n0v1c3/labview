; Variables {{{1
; Tool set {{{2
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

; Functions {{{1
; Script {{{1
; Activate/Run all Progarms {{{2
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
