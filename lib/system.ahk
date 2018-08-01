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
